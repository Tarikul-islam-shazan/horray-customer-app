import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

import '../screens/scan_qr_screen.dart';
import '../screens/contact_us_screen.dart';
import '../screens/faq_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/brand_detail_screen.dart';

void main() => runApp(HorrayApp());

class HorrayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    return MaterialApp(
      title: 'Horray',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.amber,
        canvasColor: Colors.white,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
              fontSize: 16,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.w500,
            )),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(),
        BrandDetailScreen.routeName: (ctx) => BrandDetailScreen(),
        FAQSreen.routeName: (ctx) => FAQSreen(),
        SettingsScreen.routeName: (ctx) => SettingsScreen(),
        ContactUsScreen.routeName: (ctx) => ContactUsScreen(),
        ScanQRScreen.routeName: (ctx) => ScanQRScreen(),
      },
    );
  }
}
