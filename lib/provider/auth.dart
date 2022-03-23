import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:horray/provider/agent.dart';
import 'package:horray/provider/user.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

class Auth with ChangeNotifier {
  String _apiUrl = 'http://192.168.0.103:3000/';
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
  Agent _loadedAgent = new Agent(
    id: '',
    agentRefrence: '',
    point: 0,
    members: [],
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

  Agent get loadedAgent {
    return _loadedAgent;
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
      print('Response body: ${response.body}');
      //_token = response.body;
      var data = json.decode(response.body);
      if (data == null) return;
      _token = data['idToken'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            data['expiresIn'],
          ),
        ),
      );
      Map<String, dynamic> payload = Jwt.parseJwt(_token);
      print(payload);
      _userId = payload['id'];
      print(_userId);
      this.getUserinfo();
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> getAgent(String ref) async {
    try {
      final url = _apiUrl + 'agents/$ref';
      var response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );
      // print('Response body: ${response.body}');
      var data = json.decode(response.body);
      if (data == null) return;
      _loadedAgent = new Agent(
        id: data['id'],
        agentRefrence: data['agentRefrence'],
        point: data['point'],
        members: [],
      );
      // print(data['members'][0]);
      for (var i = 0; i < data['members'].length; i++) {
        _loadedAgent.members.insert(i, data['members'][i]);
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> updateAgent(
    String agentId,
    String ref,
  ) async {
    try {
      final url = _apiUrl + 'agents/$agentId';
      //print(url);
      var response = await http.patch(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
        body: {'memberRefrence': ref},
      );
      //print({'memberRefrence': ref});
      print('Response body: ${response.body}');
      var data = json.decode(response.body);
      // if (data == null) throw new Error();
      if (data['statusCode'] == 401) {
        return;
      }
      _loadedAgent = new Agent(
        id: data['id'],
        agentRefrence: data['agentRefrence'],
        point: data['point'],
        members: [],
      );
      // print(data['members'][0]);
      for (var i = 0; i < data['members'].length; i++) {
        _loadedAgent.members.insert(i, data['members'][i]);
      }

      this.getAgent(loadedAgent.agentRefrence);

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
        this.getAgent(_loadedUser.reference);
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
