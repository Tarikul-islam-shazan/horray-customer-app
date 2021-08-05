import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTitle(String title, IconData icon) {
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
      onTap: () {},
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
          ),
          buildListTitle(
            'Settings',
            Icons.settings,
          ),
          buildListTitle(
            'Conatct Us',
            Icons.phone_enabled,
          ),
        ],
      ),
    );
  }
}