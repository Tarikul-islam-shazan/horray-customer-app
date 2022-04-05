import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BrandDetailItem extends StatelessWidget {
  var _siteUploadUrl =
      dotenv.env['HORRAY_UPLOAD_URL'].toString() + 'marchants/';
  final String imageUrl;
  final String name;
  final int percentage;
  //final String rating;

  BrandDetailItem(this.imageUrl, this.name, this.percentage);

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
                  child: Image.network(
                    _siteUploadUrl + imageUrl,
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
                        percentage.toString() + '%',
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
            GridTile(
              //padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(Icons.reviews),
                  SizedBox(
                    width: 6,
                  ),
                  Text('Rate: '),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
