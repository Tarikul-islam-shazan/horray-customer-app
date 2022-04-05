import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../screens/brand_detail_screen.dart';

class BrandItem extends StatelessWidget {
  final String id;
  final int percentage;
  final String imgUrl;

  var _siteUploadUrl =
      dotenv.env['HORRAY_UPLOAD_URL'].toString() + 'marchants/';

  BrandItem(
    this.id,
    this.percentage,
    this.imgUrl,
  );

  void selectBrand(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      BrandDetailScreen.routeName,
      arguments: {
        'id': id,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectBrand(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromRGBO(211, 211, 211, 1)),
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 1,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                child: ClipRRect(
                  child: Image.network(
                    _siteUploadUrl + imgUrl,
                    width: 70,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Container(
                  child: Text(
                    percentage.toString() + '%',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
