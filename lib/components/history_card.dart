import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shutterhouse/components/booking_card.dart';
import 'package:shutterhouse/model/booking.dart';
import 'package:shutterhouse/utilities/user_api.dart';

import 'category_list.dart';


class HistoryCard extends StatefulWidget {
  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  List<Widget> myBookings = [
    Center(
      child: Padding(
        padding: const EdgeInsets.all(80.0),
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          strokeWidth: 4,
        ),
      ),
    )
  ];
  List<String> _address;
  UserApi userApi = UserApi.instance;
  bool dataLoaded = false;

  void loadBookings() async {
    List<Booking> myList = [];

    for (var category in CategoryList.getCategories()) {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection('Bookings')
          .document('${_address[2]},${_address[4]}')
          .collection(category.id)
          .where('customerEmail', isEqualTo: userApi.email)
          .getDocuments();
      for (var snapshot in querySnapshot.documents) {
        setState(() {
          dataLoaded = true;
        });
        if(snapshot.data['endTimestamp'] < DateTime.now().millisecondsSinceEpoch){
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
          );
          myList.add(booking);
        }else{
          continue;
        }
      }
    }

    myList.sort((a, b) => b.startTimestamp.compareTo(a.startTimestamp));

    List<BookingCard> bookings = [];
    for (var booking in myList) {
      bookings.add(BookingCard(booking: booking,));
      setState(() {
        myBookings = bookings;
      });
    }

    setState(() {
      myBookings = bookings;
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
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: myBookings
      ),
    );
  }
}

