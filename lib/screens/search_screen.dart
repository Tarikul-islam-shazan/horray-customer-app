import 'package:flutter/material.dart';
import 'package:horray/provider/brand.dart';
import 'package:provider/provider.dart';
//import '../dummy_data.dart';
import '../widgets/brand_item.dart';

class SearchScreen extends StatefulWidget {
  static final routeName = "/search";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
    );
  }
}
