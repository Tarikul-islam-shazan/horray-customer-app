import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../provider/user.dart';

class Auth with ChangeNotifier {
  String _apiUrl = dotenv.env['HORRAY_API_URL'].toString();
  String _token = '';
  DateTime _expiryDate = DateTime.now();
  User _loadedUser = new User(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    reference: '',
    role: [],
  );

  String _userId = '';
  bool _isAgent = false;

  bool get isAuth {
    return token != '';
  }

  bool get isAgent {
    return _isAgent;
  }

  String get userId {
    return _userId;
  }

  User get loadedUser {
    return _loadedUser;
  }

  String get token {
    if (_expiryDate.isAfter(DateTime.now()) && _token.isNotEmpty) {
      return _token;
    }
    return '';
  }

  Future<void> login(String phone, String password) async {
    try {
      final url = _apiUrl + 'auth/login';
      var response = await http.post(Uri.parse(url), body: {
        'phone': phone,
        'password': password,
      });

      debugPrint('Response body: ${response.body}');

      var data = json.decode(response.body);
      if (data == null) return;
      _token = data['idToken'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            data['expiresIn'].replaceAll('s', ''),
          ),
        ),
      );
      Map<String, dynamic> payload = Jwt.parseJwt(_token);
      _userId = payload['id'];
      this.getUserinfo();
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> getUserinfo() async {
    try {
      final url = _apiUrl + 'users/$userId';
      var response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );
      //print('Response body: ${json.decode(response.body)}');
      var data = json.decode(response.body);
      //print(data['firstName']);
      if (data == null) return;
      _loadedUser = new User(
        id: data['id'],
        firstName: data['firstName'],
        lastName: data['lastName'],
        email: data['email'],
        phone: data['phone'],
        reference: data['reference'],
        role: [],
      );
      //print(data['roles'][0]);
      for (var i = 0; i < data['roles'].length; i++) {
        _loadedUser.role.insert(i, data['roles'][i]);
      }
      //print(_loadedUser.role);
      var isAgentExist = _loadedUser.role.firstWhere((el) => el == 'agent');
      //print(isAgent);
      if (isAgentExist.isNotEmpty) {
        _isAgent = true;
        // this.getAgent(_loadedUser.reference);
      }
      notifyListeners();
    } catch (err) {
      print(err);
      throw new ErrorDescription(err.toString());
    }
  }

  void logout() {
    _token = '';
    notifyListeners();
  }
}
