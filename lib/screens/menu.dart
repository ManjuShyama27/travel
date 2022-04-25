import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:travel/API/API.dart';
import 'package:travel/components/colors.dart';
import 'package:travel/screens/Profile.dart';
import 'package:travel/screens/favorites.dart';
import 'package:travel/screens/home.dart';
import 'package:travel/screens/search.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavoritePage(),
    SearchPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: GNav(
                haptic: true,
                tabBorderRadius: 10,
                tabActiveBorder: Border.all(color: Colors.white, width: 0),
                tabBorder: Border.all(color: Colors.white, width: 0),
                tabShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 0)
                ],
                curve: Curves.easeOutExpo,
                duration: Duration(milliseconds: 500),
                gap: 7,
                color: MyColor.secClr,
                activeColor: MyColor.bg1Clr,
                iconSize: 24,
                tabBackgroundColor: MyColor.sec1Clr.withOpacity(0.3),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.favorite_border,
                    text: 'Likes',
                  ),
                  GButton(
                    icon: Icons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.person_outline,
                    text: 'Profile',
                  )
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ));
  }
}
