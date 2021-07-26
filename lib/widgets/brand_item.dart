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
      borderRadius: BorderRadius.circular(15),
      child: Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/' + imgUrl,
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 10,
              child: Container(
                width: 100,
                color: Colors.black26,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                child: Text(
                  percentage,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
