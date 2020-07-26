import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shutterhouse/components/booking_card.dart';
import 'package:shutterhouse/components/category_list.dart';
import 'package:shutterhouse/model/booking.dart';
import 'package:shutterhouse/utilities/user_api.dart';

class ScheduleCard extends StatefulWidget {
  @override
  _ScheduleCardState createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
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
        if(snapshot.data['endTimestamp'] < DateTime.now().millisecondsSinceEpoch){
          continue;
        }else{
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
        }
      }
    }

    myList.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));

    List<BookingCard> bookings = [];
    for (var booking in myList) {
      bookings.add(BookingCard(booking: booking,));
      setState(() {
        myBookings = bookings;
      });
    }
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
        children: myBookings,
      ),
    );
  }
}
