import 'package:flutter/material.dart';
import 'package:shutterhouse/components/booking_card.dart';
import 'package:shutterhouse/model/booking.dart';
import 'package:shutterhouse/utilities/user_api.dart';

class HistoryCard extends StatefulWidget {
  @override
  _HistoryCardState createState() => _HistoryCardState();

  final List<Booking> bookings;
  HistoryCard({@required this.bookings});
}

class _HistoryCardState extends State<HistoryCard> {

  UserApi userApi = UserApi.instance;
  List<Widget> myBookings;

  @override
  Widget build(BuildContext context) {

    List<Booking> bookings = widget.bookings;

    if(bookings.isEmpty){
      myBookings = [
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
    }else{
      bookings.sort((a, b) => b.startTimestamp.compareTo(a.startTimestamp));

      List<BookingCard> myList = [];
      for (var booking in bookings) {
        if(booking.endTimestamp > DateTime.now().millisecondsSinceEpoch){
          continue;
        }else{
          myList.add(BookingCard(booking: booking,));
          setState(() {
            myBookings = myList;
          });
        }
      }

      setState(() {
        myBookings = myList;
      });
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: myBookings
      ),
    );
  }
}

