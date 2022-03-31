import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:horray/screens/search_screen.dart';
import '../widgets/main_drawer.dart';
import '../dummy_data.dart';
import '../widgets/brand_item.dart';

class BrandListScreen extends StatelessWidget {
  static final pageTitle = "Horray";
  static final discountText = 'Get Discount',
      onlineShoppingText = 'Online Shopping';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pageTitle.toUpperCase(),
          style: Theme.of(context).textTheme.headline3,
        ),
        elevation: 0,
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
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
                    //print('Page changed: $value');
                  },
                  autoPlayInterval: 4000,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 180,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Card(
                      elevation: 3.0,
                      color: Colors.pink,
                      child: InkWell(
                        splashColor: Colors.pink,
                        onTap: () {},
                        child: Center(
                          child: Text(
                            discountText.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Card(
                      color: Colors.purple.withAlpha(90),
                      child: InkWell(
                        splashColor: Colors.blue,
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(SearchScreen.routeName);
                          //debugPrint('Card tapped');
                        },
                        child: Center(
                          child: Text(
                            onlineShoppingText,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Container(
                    child: Text(
                      'See All..',
                      style: Theme.of(context).textTheme.headline6,
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
      ),
    );
  }
}
