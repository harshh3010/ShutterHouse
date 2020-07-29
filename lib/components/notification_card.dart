import 'package:flutter/material.dart';
import 'package:shutterhouse/model/booking_notification.dart';
import 'package:shutterhouse/utilities/constants.dart';

class NotificationCard extends StatelessWidget {

  final BookingNotification notification;
  NotificationCard({@required this.notification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: kColorRed,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [ BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 3.0,
            ),]
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'There is a new booking for your product ${notification.productName} by ${notification.customerEmail}',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Proxima Nova',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}