import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shutterhouse/components/menu_option.dart';
import 'package:shutterhouse/navigation_pages/profile_page.dart';
import 'package:shutterhouse/navigation_pages/rent_page.dart';
import 'package:shutterhouse/navigation_pages/search_page.dart';
import 'package:shutterhouse/screens/edit_profile_screen.dart';
import 'package:shutterhouse/screens/notification_screen.dart';
import 'package:shutterhouse/screens/welcome_screen.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _loading = false;

  Future<void> signOut() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, WelcomeScreen.id);
  }

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
          ),
          PopupMenuItem<String>(
            value: 'item_about',
            child: MenuOption(
              label: 'About',
              icon: Icons.info_outline,
            ),
          ),
        ],
        onSelected: (selectedOption) async {
          switch (selectedOption) {
            case 'item_logout':
              setState(() {
                _loading = true;
              });
              await signOut();
              setState(() {
                _loading = false;
              });
              break;
            case 'item_edit_profile':
              Navigator.pushNamed(context, EditProfileScreen.id);
              break;
            case 'item_help':
              Alert(
                context: context,
                type: AlertType.info,
                title: 'We\'re always there for you',
                desc: 'For any queries, please mail us at harsh.gyanchandani@gmail.com',
                buttons: [
                  DialogButton(
                    color: kColorRed,
                    child: Text(
                      'Okay',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ],
              ).show();
              break;
            case 'item_about':
              Alert(
                context: context,
                type: AlertType.info,
                title: 'About Us',
                desc: 'This app has been created by Harsh Gyanchandani ©2020',
                buttons: [
                  DialogButton(
                    color: kColorRed,
                    child: Text(
                      'Okay',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ],
              ).show();
              break;
          }
        },
      );
    }

    List<Widget> navigationPages = [
      SearchPage(),
      ProfilePage(),
      RentPage(),
    ];

    switch (_currentIndex) {
      case 0:
        appBarColor = Colors.white;
        appBarIconColor = Colors.grey.shade800;
        break;
      case 1:
        appBarColor = kColorBlue;
        appBarIconColor = Colors.white;
        break;
      case 2:
        appBarColor = Colors.white;
        appBarIconColor = Colors.grey.shade800;
        break;
    }

    return ModalProgressHUD(
      inAsyncCall: _loading,
      color: Colors.white,
      opacity: .5,
      progressIndicator: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(kColorRed),
      ),
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: appBarColor,
            leading: showOptions(),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context,NotificationScreen.id);
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: appBarIconColor,
                  ),
                )
              ),
            ],
          ),
          body: IndexedStack(
            index: _currentIndex,
            children: navigationPages,
          ),
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
                      Icons.attach_money,
                    ),
                  ),
                  title: Text(
                    'RENT',
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
      ),
    );
  }
}
