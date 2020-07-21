import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shutterhouse/components/menu_option.dart';
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
    Widget showOptions() {
      return PopupMenuButton<String>(
        padding: EdgeInsets.all(24),
        offset: Offset(30, 100),
        icon: Icon(
          Icons.more_vert,
          color: appBarIconColor,
        ),
        itemBuilder: (BuildContext buildContext) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'item_edit_profile',
            child: MenuOption(
              label: 'Edit Profile',
              icon: Icons.edit,
            ),
          ),
          PopupMenuItem<String>(
            value: 'item_logout',
            child: MenuOption(
              label: 'Logout',
              icon: Icons.exit_to_app,
            ),
          ),
          PopupMenuItem<String>(
            value: 'item_help',
            child: MenuOption(
              label: 'Help',
              icon: Icons.help_outline,
            ),
          ),PopupMenuItem<String>(
            value: 'item_about',
            child: MenuOption(
              label: 'About',
              icon: Icons.info_outline,
            ),
          ),
        ],
        onSelected: (selectedOption){
          switch(selectedOption){
            case 'item_logout': print('Logout');
            break;
            case 'item_edit_profile': print('Edit Profile');
            break;
            case 'item_help': print('Help');
            break;
            case 'item_about': print('About');
            break;
          }
        }, //TODO: add methods
      );
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    Widget displayPage;
    switch (_currentIndex) {
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
          leading: showOptions(),
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
          padding: EdgeInsets.fromLTRB(24.0, 0, 24, 24),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (newIndex) {
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



