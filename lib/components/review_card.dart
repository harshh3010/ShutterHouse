import 'package:flutter/material.dart';
import 'package:shutterhouse/utilities/constants.dart';

class ReviewCard extends StatelessWidget {

  final String name,text,imageUrl;
  ReviewCard({@required this.name,@required this.text,@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: new Border.all(
                width: 2.0,
                color: kColorRed,
              ),
              image: DecorationImage(
                image: NetworkImage(
                    imageUrl
                ),
                fit: BoxFit.cover,
              ),
            ),
            height: 50,
            width: 50,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}