import 'package:flutter/material.dart';
import 'package:shutterhouse/components/booking_card.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          BookingCard(
            startDay: 15,
            startMonth: 'April',
            endDay: 19,
            endMonth: 'April',
            productName: 'Nikon D5100 DSLR Camera',
            productUrl: 'https://pluspng.com/img-png/nikon-png-black-nikon-black-nikon-camera-png-image-260.jpg',
          ),
          BookingCard(
            startDay: 15,
            startMonth: 'April',
            endDay: 19,
            endMonth: 'April',
            productName: 'Nikon D5100 DSLR Camera',
            productUrl: 'https://pluspng.com/img-png/nikon-png-black-nikon-black-nikon-camera-png-image-260.jpg',
          )
        ],
      ),
    );
  }
}
