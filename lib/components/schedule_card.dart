import 'package:flutter/material.dart';
import 'package:shutterhouse/components/booking_card.dart';
import 'package:shutterhouse/model/booking.dart';
import 'package:shutterhouse/utilities/user_api.dart';

class ScheduleCard extends StatefulWidget {
  @override
  _ScheduleCardState createState() => _ScheduleCardState();

  final List<Booking> bookings;
  ScheduleCard({@required this.bookings});
}

class _ScheduleCardState extends State<ScheduleCard> {

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
      bookings.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));

      List<BookingCard> myList = [];
      for (var booking in bookings) {
       if(booking.endTimestamp > DateTime.now().millisecondsSinceEpoch){
         myList.add(BookingCard(booking: booking,));
         setState(() {
           myBookings = myList;
         });
       }else{
         continue;
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
        children: myBookings,
      ),
    );
  }
}
