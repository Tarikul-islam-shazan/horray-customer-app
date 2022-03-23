import 'package:flutter/material.dart';

class User with ChangeNotifier {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String reference;
  final List<String> role;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.reference,
    required this.role,
  });
}
