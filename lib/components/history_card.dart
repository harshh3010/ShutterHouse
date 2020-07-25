import 'package:flutter/material.dart';
import 'package:shutterhouse/components/booking_card.dart';

class HistoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          BookingCard(
            startDay: 12,
            startMonth: 'April',
            endDay: 13,
            endMonth: 'April',
            productName: 'Nikon D5100 DSLR Camera',
            productUrl: 'https://pluspng.com/img-png/nikon-png-black-nikon-black-nikon-camera-png-image-260.jpg',
          ),
          BookingCard(
            startDay: 11,
            startMonth: 'April',
            endDay: 12,
            endMonth: 'April',
            productName: 'Nikon D5100 DSLR Camera',
            productUrl: 'https://pluspng.com/img-png/nikon-png-black-nikon-black-nikon-camera-png-image-260.jpg',
          ),
          BookingCard(
            startDay: 10,
            startMonth: 'April',
            endDay: 11,
            endMonth: 'April',
            productName: 'Nikon D5100 DSLR Camera',
            productUrl: 'https://pluspng.com/img-png/nikon-png-black-nikon-black-nikon-camera-png-image-260.jpg',
          )
        ],
      ),
    );
  }
}
