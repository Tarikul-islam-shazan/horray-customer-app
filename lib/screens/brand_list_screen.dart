import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/brand_item.dart';

class BrandListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BRANDS'),
      ),
      body: GridView(
        padding: EdgeInsets.all(10),
        children: DUMMY_BRANDS
            .map((brand) => BrandItem(
                  brand.id,
                  brand.name,
                  brand.brandColor,
                ))
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
      ),
    );
  }
}
