import 'package:flutter/material.dart';

class Brand {
  final String id;
  final String name;
  final String percentage;
  final String establishedDate;
  final String imgUrl;

  const Brand({
    @required this.id,
    @required this.name,
    @required this.percentage,
    @required this.establishedDate,
    @required this.imgUrl,
  });
}
