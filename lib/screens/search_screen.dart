import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/brand_item.dart';

class SearchScreen extends StatelessWidget {
  static final routeName = "/serach";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      /* Clear the search field */
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: Container(
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
    );
  }
}
