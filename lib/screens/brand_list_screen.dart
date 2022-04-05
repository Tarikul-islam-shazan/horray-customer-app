import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import '../provider/brand.dart';
import '../screens/search_screen.dart';
import '../widgets/main_drawer.dart';
import '../widgets/brand_item.dart';

class BrandListScreen extends StatefulWidget {
  static final pageTitle = "Horray";
  static final discountText = 'Get Discount',
      onlineShoppingText = 'Online Shopping';

  @override
  _BrandListScreenState createState() => _BrandListScreenState();
}

class _BrandListScreenState extends State<BrandListScreen> {
  var _isInit = true;
  var _brand;
  //var _siteUploadUrl = dotenv.env['HORRAY_UPLOAD_URL'].toString() + 'marchants/';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      try {
        _brand = Provider.of<Brand>(context, listen: false);
        await _brand.getBrands();
        print('data ${_brand.loadedBrand[0].address}');
      } catch (error) {
        print('Error $error');
      }
      //_brand.loadedBrand.map((data) => {print(data.id)});
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          BrandListScreen.pageTitle.toUpperCase(),
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
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(SearchScreen.routeName);
                        },
                        child: Center(
                          child: Text(
                            BrandListScreen.discountText.toUpperCase(),
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
                            BrandListScreen.onlineShoppingText,
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
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(SearchScreen.routeName);
                      },
                      child: Text('See All..',
                          style: Theme.of(context).textTheme.headline6),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 300,
              child: Consumer<Brand>(
                builder: (_, brand, child) => GridView(
                  padding: EdgeInsets.all(10),
                  children: brand.loadedBrand
                      .map(
                        (BrandType b) => BrandItem(
                          b.id,
                          b.discount,
                          b.imageUrl,
                        ),
                      )
                      .toList(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 180,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
