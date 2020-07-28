import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shutterhouse/model/booking.dart';
import 'package:shutterhouse/utilities/constants.dart';

class BookingCard extends StatelessWidget {

  final Booking booking;
  final Function onPressed;
  final IconData icon;
  BookingCard({@required this.booking,@required this.onPressed,this.icon});

  @override
  Widget build(BuildContext context) {

    final DateFormat formatter = DateFormat('MMMM, d, yyyy');
    String startDate = formatter.format(DateTime.fromMillisecondsSinceEpoch(booking.startTimestamp));
    String endDate = formatter.format(DateTime.fromMillisecondsSinceEpoch(booking.endTimestamp));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
          child: Text(
            '$startDate',
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 30,
              fontFamily: 'Proxima Nova',
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 30, vertical: 10),
          child: Container(
            height: 180,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 3.0,
                  ),
                ]),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        booking.productName,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w900,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      GestureDetector(
                        child: IconButton(
                          onPressed: onPressed,
                          icon: Icon(
                            icon,
                            color: kColorRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Image(
                          image: NetworkImage(booking.imageUrl),
                          width: 80,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '$startDate to $endDate',
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        )
      ],
    );
  }
}