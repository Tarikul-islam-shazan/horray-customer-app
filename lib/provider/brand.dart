import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class BrandType {
  final String id;
  final String name;
  final String address;
  final String email;
  final String phone;
  final double latitude;
  final double longitude;
  final int discount;
  final String imageUrl;

  BrandType({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.discount,
    required this.imageUrl,
  });
}

class Brand with ChangeNotifier {
  String _apiUrl = dotenv.env['HORRAY_API_URL'].toString();
  List<BrandType> _loadedBrand = [];
  BrandType _brand = new BrandType(
    id: "",
    name: "",
    address: "",
    email: "",
    phone: "",
    latitude: 0.0,
    longitude: 0.0,
    discount: 0,
    imageUrl: "",
  );

  List<BrandType> get loadedBrand {
    return [..._loadedBrand];
  }

  Future<void> getBrands() async {
    try {
      print("Called");
      final url = _apiUrl + 'marchant?skip=0&limit=5';
      final response = await http.get(
        Uri.parse(url),
      );
      print('Response body: ${response.body}');
      final extractedData = json.decode(response.body);
      if (extractedData == null) return;
      _loadedBrand = [];
      extractedData.forEach((data) {
        _loadedBrand.add(
          BrandType(
            id: data['id'],
            name: data['name'],
            address: data['address'],
            email: data['email'],
            phone: data['phone'],
            latitude: double.parse(data['latitude'].toString()),
            longitude: double.parse(data['longitude'].toString()),
            discount: int.parse(data['discount'].toString()),
            imageUrl: data['imageUrl'] ?? '',
          ),
        );
        //print(_loadedBrand[0].address);
        //_loadedBrand.add();
      });
      //print(_brand.address);

      // _loadedBrand = brands;
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }
}
