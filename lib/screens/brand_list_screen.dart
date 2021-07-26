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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 200),
                  child: Text(
                    'TOP BRANDS',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    'See All..',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 250,
            child: GridView(
              padding: EdgeInsets.all(5),
              children: DUMMY_BRANDS
                  .map((brand) => BrandItem(
                        brand.id,
                        brand.percentage,
                        brand.imgUrl,
                        'top',
                      ))
                  .toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 2 / 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 200),
                  child: Text(
                    'MY FAVOURITE',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Container(
                  child: Text(
                    'See All..',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 250,
            child: GridView(
              padding: EdgeInsets.all(10),
              children: DUMMY_FAVOURITE
                  .map((brand) => BrandItem(
                        brand.id,
                        brand.percentage,
                        brand.imgUrl,
                        'favourite',
                      ))
                  .toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 2 / 1,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2),
            ),
          ),
        ],
      ),
    );
  }
}
