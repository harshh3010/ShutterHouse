import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shutterhouse/navigation_pages/profile_page.dart';
import 'package:shutterhouse/navigation_pages/search_page.dart';
import 'package:shutterhouse/utilities/constants.dart';
import 'package:shutterhouse/utilities/user_api.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  UserApi userApi = UserApi.instance;
  int _currentIndex = 0;
  Color appBarColor = Colors.white;
  Color appBarIconColor = Colors.grey.shade800;

  @override
  Widget build(BuildContext context) {
    Widget displayPage;
    switch(_currentIndex){
      case 0:
        displayPage = SearchPage();
        appBarColor = Colors.white;
       appBarIconColor = Colors.grey.shade800;
        break;
      case 1:
        displayPage = ProfilePage();
        appBarColor = kColorBlue;
        appBarIconColor = Colors.white;
        break;
      case 2:
        displayPage = Container(
          color: Colors.red,
        );
        appBarColor = Colors.white;
        appBarIconColor = Colors.grey.shade800;
        break;
    }
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appBarColor,
          leading: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Icon(
              Icons.more_vert,
              color: appBarIconColor,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Icon(
                Icons.shopping_cart,
                color: appBarIconColor,
              ),
            ),
          ],
        ),
        body: displayPage,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(24.0,0,24,24),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (newIndex){
              setState(() {
                _currentIndex = newIndex;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                  ),
                ),
                title: Text(
                  'SEARCH',
                  style: TextStyle(
                    fontFamily: 'Proxima Nova',
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.person_outline,
                  ),
                ),
                title: Text(
                  'PROFILE',
                  style: TextStyle(
                    fontFamily: 'Proxima Nova',
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.chat_bubble_outline,
                  ),
                ),
                title: Text(
                  'CHAT',
                  style: TextStyle(
                    fontFamily: 'Proxima Nova',
                  ),
                ),
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 0,
            fixedColor: kColorRed,
            unselectedItemColor: Colors.grey.shade800,
            iconSize: 30,
          ),
        ),
      ),
    );
  }
}