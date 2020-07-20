import 'package:flutter/material.dart';
import 'package:shutterhouse/components/rents_button.dart';
import 'package:shutterhouse/utilities/constants.dart';
import 'number_label.dart';

enum Rents{
  Schedule,
  History
}

class UserProfileCard extends StatefulWidget {
  @override
  _UserProfileCardState createState() => _UserProfileCardState();

  final String dpUrl,name,city,country;
  final double rating;
  final int reviews,rents;

  UserProfileCard({@required this.dpUrl,@required this.name,@required this.city,@required this.country,@required this.rating,@required this.reviews,@required this.rents});
}

class _UserProfileCardState extends State<UserProfileCard> {

  Rents selectedButton = Rents.Schedule;

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
                      image: NetworkImage(widget.dpUrl),
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
                  widget.name,
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
                      '${widget.city}, ${widget.country}',
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
                    NumberLabel(
                      value: '⭐ ${widget.rating}',
                      label: 'RATING',
                    ),
                    NumberLabel(
                      value: '${widget.reviews}',
                      label: 'REVIEWS',
                    ),
                    NumberLabel(
                      value: '${widget.rents}',
                      label: 'RENTS',
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
                    RentsButton(
                      onPressed: (){
                        setState(() {
                          selectedButton = Rents.Schedule;
                        });
                      },
                      label: 'Schedule',
                      isActive: selectedButton == Rents.Schedule,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    RentsButton(
                      onPressed: (){
                        setState(() {
                          selectedButton = Rents.History;
                        });
                      },
                      label: 'History',
                      isActive: selectedButton == Rents.History,
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
