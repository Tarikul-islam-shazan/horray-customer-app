import 'package:flutter/material.dart';
import '../screens/favorite_screen.dart';
import '../screens/offer_scree.dart';
import '../screens/profile_screen.dart';
import '../screens/brand_list_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': BrandListScreen(),
      'title': 'Home',
    },
    {
      'page': Favorite(),
      'title': 'Favorite',
    },
    {
      'page': OfferScreen(),
      'title': 'Offer',
    },
    {
      'page': Profile(),
      'title': 'Profile',
    },
  ];

  int selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BRANDS'),
          elevation: 0,
        ),
        drawer: MainDrawer(),
        body: _pages[selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: selectedPageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.favorite),
              title: Text('Favorite'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.local_offer),
              title: Text('Offer'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.supervised_user_circle),
              title: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
