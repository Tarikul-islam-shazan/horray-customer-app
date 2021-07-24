import 'package:flutter/material.dart';

class BrandItem extends StatelessWidget {
  final String id;
  final String name;
  final Color color;

  BrandItem(
    this.id,
    this.name,
    this.color,
  );

  void selectBrand() {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectBrand,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          name,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.6),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
