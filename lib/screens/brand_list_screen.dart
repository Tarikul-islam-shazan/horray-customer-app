import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import '../dummy_data.dart';
import '../widgets/brand_item.dart';

class BrandListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Color.fromRGBO(211, 211, 211, 1)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ImageSlideshow(
                width: double.infinity,
                height: 200,
                initialPage: 1,
                indicatorColor: Colors.blue,
                indicatorBackgroundColor: Colors.grey,
                children: [
                  Image.asset(
                    'assets/images/buyOneGetOne.jpeg',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/50Off.jpeg',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/winterSale.jpeg',
                    fit: BoxFit.cover,
                  ),
                ],
                onPageChanged: (value) {
                  print('Page changed: $value');
                },
                autoPlayInterval: 3000,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
            height: 200,
            child: GridView(
              padding: EdgeInsets.all(15),
              children: DUMMY_BRANDS
                  .map((brand) => BrandItem(
                        brand.id,
                        brand.percentage,
                        brand.imgUrl,
                        'top',
                      ))
                  .toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 180,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 200),
                  child: Text(
                    'HIGHEST DISCOUNT',
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
            height: 300,
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
                maxCrossAxisExtent: 180,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
