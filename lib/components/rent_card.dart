import 'package:flutter/material.dart';

class RentCard extends StatelessWidget {

  final String startMonth,productName,productUrl,endMonth;
  final int startDay,endDay;
  RentCard({@required this.startMonth,@required this.startDay,@required this.endMonth,@required this.endDay,@required this.productName,@required this.productUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
          child: Text(
            '$startMonth, $startDay',
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
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      productName,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w900,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Icon(
                      //TODO : Add action
                      Icons.more_vert,
                      color: Colors.grey.shade800,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Image(
                      image: NetworkImage(productUrl),
                      width: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '$startMonth,$startDay - $endMonth,$endDay',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w900,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}