import 'package:flutter/material.dart';
import '../screens/brand_detail_screen.dart';

class BrandItem extends StatelessWidget {
  final String id;
  final String percentage;
  final String imgUrl;
  final String type;

  BrandItem(
    this.id,
    this.percentage,
    this.imgUrl,
    this.type,
  );

  void selectBrand(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      BrandDetailScreen.routeName,
      arguments: {
        'id': id,
        'type': type,
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
                  child: Image.asset(
                    'assets/images/' + imgUrl,
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
                    percentage,
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
