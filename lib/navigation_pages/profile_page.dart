import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shutterhouse/components/booking_card.dart';
import 'package:shutterhouse/components/category_list.dart';
import 'package:shutterhouse/components/history_card.dart';
import 'package:shutterhouse/components/number_label.dart';
import 'package:shutterhouse/components/schedule_card.dart';
import 'package:shutterhouse/components/rents_button.dart';
import 'package:shutterhouse/model/booking.dart';

import 'package:shutterhouse/utilities/constants.dart';
import 'package:shutterhouse/utilities/user_api.dart';

enum Rents { Schedule, History }

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  UserApi userApi = UserApi.instance;
  Rents selectedButton = Rents.Schedule;
  List<String> _address;
  List<Booking> myBookings = [];

  // Function to load all the user's bookings
  Future<void> loadBookings() async {
    List<Booking> myList = [];

    for (var category in CategoryList.getCategories()) {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection('Bookings')
          .document('${_address[2]},${_address[4]}')
          .collection(category.id)
          .where('customerEmail', isEqualTo: userApi.email)
          .getDocuments();
      for (var snapshot in querySnapshot.documents) {
        Booking booking = Booking(
          id: snapshot.data['id'],
          productName: snapshot.data['productName'],
          productId: snapshot.data['productId'],
          startTimestamp: snapshot.data['startTimestamp'],
          endTimestamp: snapshot.data['endTimestamp'],
          imageUrl: snapshot.data['imageUrl'],
          ownerEmail: snapshot.data['ownerEmail'],
          customerEmail: snapshot.data['customerEmail'],
          cost: snapshot.data['cost'],
          country: snapshot.data['country'],
          city: snapshot.data['city'],
          category: snapshot.data['category'],
          contactNo: snapshot.data['contactNo'],
        );
        myList.add(booking);
      }
    }

    setState(() {
      myBookings = myList;
    });

  }

  @override
  void initState() {
    super.initState();
    _address = (userApi.address).split(',').toList();
    loadBookings();
  }

  @override
  Widget build(BuildContext context) {

    Widget cardToDisplay;
    if(selectedButton == Rents.Schedule){
      cardToDisplay = ScheduleCard(bookings: myBookings,);
    }else{
      cardToDisplay = HistoryCard(bookings: myBookings,);
    }

    List<String> _address = (userApi.address).split(',').toList();

    return Container(
      child: RefreshIndicator(
        onRefresh: loadBookings,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 30.0),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 80.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kColorBlue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.zero,
                              topRight: Radius.zero,
                              bottomLeft: Radius.circular(50.0),
                              bottomRight: Radius.circular(50.0),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(userApi.dpURL),
                                    fit: BoxFit.cover,
                                  ),
                                  border: new Border.all(
                                    width: 5.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                userApi.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontFamily: 'Proxima Nova',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.blueGrey.shade400,
                                    size: 16.0,
                                  ),
                                  Text(
                                    '${_address[2]},${_address[4]}',
                                    style: TextStyle(
                                      fontFamily: 'Proxima Nova',
                                      color: Colors.blueGrey.shade400,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 36,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  NumberLabel(
                                    value: '⭐ ${userApi.rating}',
                                    label: 'RATING',
                                    valueColor: Colors.white,
                                    labelColor: Colors.blueGrey.shade400,
                                  ),
                                  NumberLabel(
                                    value: '${userApi.reviews}',
                                    label: 'REVIEWS',
                                    valueColor: Colors.white,
                                    labelColor: Colors.blueGrey.shade400,
                                  ),
                                  NumberLabel(
                                    value: '${userApi.rents}',
                                    label: 'RENTS',
                                    valueColor: Colors.white,
                                    labelColor: Colors.blueGrey.shade400,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 30.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width - 60.0,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 5.0,
                                    ),
                                  ]),
                              child: Row(
                                children: <Widget>[
                                  RentsButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedButton = Rents.Schedule;
                                      });
                                    },
                                    label: 'Schedule',
                                    isActive: selectedButton == Rents.Schedule,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  RentsButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedButton = Rents.History;
                                      });
                                    },
                                    label: 'History',
                                    isActive: selectedButton == Rents.History,
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  cardToDisplay,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

