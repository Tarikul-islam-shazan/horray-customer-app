import 'package:flutter/material.dart';

class BrandDetailItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String percentage;
  final String establishedDate;
  final String rating;
  final String opening;
  final String closing;

  BrandDetailItem(this.imageUrl, this.name, this.percentage,
      this.establishedDate, this.rating, this.opening, this.closing);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    'assets/images/' + imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: Container(
                    width: 250,
                    height: 50,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Center(
                      child: Text(
                        percentage,
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: [
                      Icon(Icons.watch),
                      SizedBox(
                        width: 6,
                      ),
                      Text('Opening: ' + opening),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.watch_later),
                      SizedBox(
                        width: 6,
                      ),
                      Text('Closing: ' + closing),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.reviews),
                      SizedBox(
                        width: 6,
                      ),
                      Text('Rate: ' + rating),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
