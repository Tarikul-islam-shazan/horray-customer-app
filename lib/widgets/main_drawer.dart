import 'package:flutter/material.dart';
import '../screens/contact_us_screen.dart';
import '../screens/faq_screen.dart';
import '../screens/settings_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTitle(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Horray!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTitle(
            'FAQ',
            Icons.verified_user,
            () {
              Navigator.of(context).pushNamed(FAQSreen.routeName);
            },
          ),
          buildListTitle(
            'Settings',
            Icons.settings,
            () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
          ),
          buildListTitle(
            'Conatct Us',
            Icons.phone_enabled,
            () {
              Navigator.of(context).pushNamed(ContactUsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
