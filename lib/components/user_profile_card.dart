import 'package:flutter/material.dart';
import 'package:shutterhouse/utilities/constants.dart';

class UserProfileCard extends StatelessWidget {

  final String dpUrl,name,city,country;
  final double rating;
  final int reviews,rents;
  UserProfileCard({@required this.dpUrl,@required this.name,@required this.city,@required this.country,@required this.rating,@required this.reviews,@required this.rents});

@override
Widget build(BuildContext context) {
  return Stack(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(bottom: 30.0),
        child: Container(
          padding: EdgeInsets.fromLTRB(0,10, 0, 80.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: kColorBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.zero,
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(dpUrl),
                    fit: BoxFit.cover,
                  ),
                  border: new Border.all(
                    width: 5.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: 'Proxima Nova',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Colors.blueGrey.shade400,
                    size: 16.0,
                  ),
                  Text(
                    '$city, $country',
                    style: TextStyle(
                      fontFamily: 'Proxima Nova',
                      color: Colors.blueGrey.shade400,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 36,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '⭐ $rating',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'RATING',
                        style: TextStyle(
                          fontFamily: 'Proxima Nova',
                          color: Colors.blueGrey.shade400,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$reviews',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'REVIEWS',
                        style: TextStyle(
                          fontFamily: 'Proxima Nova',
                          color: Colors.blueGrey.shade400,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$rents',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'RENTS',
                        style: TextStyle(
                          fontFamily: 'Proxima Nova',
                          color: Colors.blueGrey.shade400,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 10,
        left: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 30.0),
          child: Container(
              width: MediaQuery.of(context).size.width - 60.0,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  boxShadow: [ BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5.0,
                  ),]
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: kColorRed,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Center(
                        child: Text(
                          'Schedule',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Center(
                        child: Text(
                          'History',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 20,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    ],
  );
}
}