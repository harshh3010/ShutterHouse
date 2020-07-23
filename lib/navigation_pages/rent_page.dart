import 'package:flutter/material.dart';
import 'package:shutterhouse/components/rent_card.dart';
import 'package:shutterhouse/screens/rent_screen.dart';
import 'package:shutterhouse/utilities/constants.dart';

class RentPage extends StatefulWidget {
  @override
  _RentPageState createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 30.0, vertical: 10),
              child: Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'On Rent',
                    style: TextStyle(
                      color: kColorRed,
                      fontSize: 36,
                      fontFamily: 'Proxima Nova',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context,RentScreen.id);
                    },
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: kColorRed,
                    ),
                  )
                ],
              ),
            ),
            RentCard(
              startMonth: 'July',
              startDay: 23,
              endMonth: 'July',
              endDay: 27,
              productUrl: 'https://pluspng.com/img-png/nikon-png-black-nikon-black-nikon-camera-png-image-260.jpg',
              productName: 'Name of Product',
            ),
            SizedBox(
              height: 15,
            ),
            RentCard(
              startMonth: 'July',
              startDay: 23,
              endMonth: 'July',
              endDay: 27,
              productUrl: 'https://pluspng.com/img-png/nikon-png-black-nikon-black-nikon-camera-png-image-260.jpg',
              productName: 'Name of Product',
            ),
            SizedBox(
              height: 15,
            ),
            RentCard(
              startMonth: 'July',
              startDay: 23,
              endMonth: 'July',
              endDay: 27,
              productUrl: 'https://pluspng.com/img-png/nikon-png-black-nikon-black-nikon-camera-png-image-260.jpg',
              productName: 'Name of Product',
            ),
          ],
        ),
      ),
    );
  }
}
