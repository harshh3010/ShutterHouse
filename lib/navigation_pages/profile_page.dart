import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shutterhouse/components/user_profile_card.dart';
import 'package:shutterhouse/utilities/constants.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                UserProfileCard(
                  name: 'Harsh Gyanchandani',
                  dpUrl: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                  city: 'Bhopal',
                  country: 'India',
                  rating: 4.5,
                  rents: 10,
                  reviews: 12,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 30),
                  child: Text(
                    'April, 25',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 30,
                      fontFamily: 'Proxima Nova',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    child: Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [ BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 3.0,
                          ),]
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Name of the product',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Proxima Nova',
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              Icon(
                                Icons.more_vert,
                                color: Colors.grey.shade800,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Image(
                                  image: NetworkImage('https://pluspng.com/img-png/nikon-png-black-nikon-black-nikon-camera-png-image-260.jpg'),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'April,25 - April,28',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Proxima Nova',
                                      fontWeight: FontWeight.w900,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
