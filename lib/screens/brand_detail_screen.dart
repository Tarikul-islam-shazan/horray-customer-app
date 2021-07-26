import 'package:flutter/material.dart';
import '../widgets/brand_detail_item.dart';
import '../dummy_data.dart';
import '../models/brand.dart';

class BrandDetailScreen extends StatelessWidget {
  static const routeName = '/brand-detail';
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final brandType = routeArgs['type'];
    final brandId = routeArgs['id'];
    final List<Brand> brandItem = brandType == 'top'
        ? DUMMY_BRANDS.where((brand) {
            return brand.id == brandId;
          }).toList()
        : DUMMY_FAVOURITE.where((brand) {
            return brand.id == brandId;
          }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(brandItem[0].name),
      ),
      body: BrandDetailItem(
        brandItem[0].imgUrl,
        brandItem[0].name,
        brandItem[0].percentage,
      ),
    );
  }
}
