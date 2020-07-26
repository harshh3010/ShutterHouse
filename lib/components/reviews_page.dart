import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shutterhouse/components/review_card.dart';
import 'package:shutterhouse/utilities/constants.dart';

class ReviewsPage extends StatefulWidget {
  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'User Reviews',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Proxima Nova',
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'View All',
                  style: TextStyle(
                    fontFamily: 'Proxima Nova',
                    color: Colors.grey.shade400,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ReviewCard(
              name: 'Harsh Gyanchandani',
              imageUrl: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
              text: 'This product is awesome... I rented it for a family trip, the photos and videos i clicked were simply amazinggg!',
            ),
            ReviewCard(
              name: 'Harsh Gyanchandani',
              imageUrl: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
              text: 'This product is awesome... I rented it for a family trip, the photos and videos i clicked were simply amazinggg!',
            ),
          ],
        ),
      ),
    );
  }
}