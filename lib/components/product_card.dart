import 'package:flutter/material.dart';
import 'package:shutterhouse/utilities/constants.dart';

class ProductCard extends StatelessWidget {

  final String name,photoUrl;
  final double price,rating;
  ProductCard({@required this.name,@required this.photoUrl, @required this.price, @required this.rating});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 3.0,
              ),
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image(
              image: NetworkImage(photoUrl),
              width: 100,
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w900,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Rs. $price',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.w900,
                            color: kColorRed,
                          ),
                        ),
                        Text(
                          '⭐ $rating',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.w900,
                            color: Colors.grey.shade800,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}