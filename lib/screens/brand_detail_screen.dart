import 'package:flutter/material.dart';
import '../widgets/brand_detail_item.dart';
import '../dummy_data.dart';
import '../models/brand.dart';

class BrandDetailScreen extends StatefulWidget {
  static const routeName = '/brand-detail';

  @override
  _BrandDetailScreenState createState() => _BrandDetailScreenState();
}

class _BrandDetailScreenState extends State<BrandDetailScreen> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
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
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            BrandDetailItem(
              brandItem[0].imgUrl,
              brandItem[0].name,
              brandItem[0].percentage,
              brandItem[0].establishedDate,
              brandItem[0].rating,
              brandItem[0].openingTime,
              brandItem[0].closingTime,
            ),
            const SizedBox(height: 50),
            Flexible(
              child: Form(
                key: _form,
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Amout',
                          border: OutlineInputBorder(),
                        ),
                        //textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,

                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'Please provide a phone no.';
                          }
                          if (value.toString().length != 11) {
                            return 'Please enter 11 digits.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          //_loginForm['phone'] = value.toString();
                        },
                      ),
                      const SizedBox(height: 50),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 16),
                          //onPrimary: Colors.white,
                          padding: EdgeInsets.all(16),
                        ),
                        onPressed: () {
                          //Navigator.of(context).pushNamed(ScanQRScreen.routeName);
                        },
                        child: Text(
                          'Get Discount',
                        ),
                      ),
                    ],
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
