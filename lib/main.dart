import 'package:flutter/material.dart';
import 'package:horray/screens/brand_detail_screen.dart';
import '../screens/brand_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horray',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 16,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.w500,
            )),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => BrandListScreen(),
        BrandDetailScreen.routeName: (ctx) => BrandDetailScreen(),
      },
    );
  }
}
