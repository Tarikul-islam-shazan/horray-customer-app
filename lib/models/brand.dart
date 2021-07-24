import 'package:flutter/material.dart';

class Brand {
  final String id;
  final String name;
  final Color brandColor;
  final String establishedDate;

  const Brand({
    @required this.id,
    @required this.name,
    @required this.brandColor,
    @required this.establishedDate,
  });
}
