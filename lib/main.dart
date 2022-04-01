import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../screens/login_screen.dart';
import '../screens/payment_info_screen.dart';
import '../screens/scan_qr_screen.dart';
import '../screens/contact_us_screen.dart';
import '../screens/faq_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/brand_detail_screen.dart';
import '../screens/search_screen.dart';
import './provider/auth.dart';
import './provider/agent.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(HorrayApp());
}

class HorrayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Agent>(
          create: (context) =>
              Agent(Provider.of<Auth>(context, listen: false).token),
          update: (ctx, auth, previousProducts) => Agent(auth.token),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Horray',
          theme: ThemeData(
            primaryColor: Colors.white,
            accentColor: Colors.amber,
            canvasColor: Colors.white,
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  //fontFamily: 'RobotoCondensed',
                  color: Colors.white,
                ),
                bodyText2: TextStyle(
                  // fontFamily: 'RobotoCondensed',
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline2: TextStyle(
                  fontSize: 32,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
                headline3: TextStyle(
                  fontSize: 24,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.w500,
                ),
                headline6: TextStyle(
                  fontSize: 16,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.w500,
                )),
          ),
          home: TabsScreen(),
          routes: {
            BrandDetailScreen.routeName: (ctx) => BrandDetailScreen(),
            FAQSreen.routeName: (ctx) => FAQSreen(),
            SettingsScreen.routeName: (ctx) => SettingsScreen(),
            ContactUsScreen.routeName: (ctx) => ContactUsScreen(),
            ScanQRScreen.routeName: (ctx) => ScanQRScreen(),
            PaymentInfo.routeName: (ctx) => PaymentInfo(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            SearchScreen.routeName: (ctx) => SearchScreen(),
          },
        ),
      ),
    );
  }
}
