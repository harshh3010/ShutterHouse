import 'package:flutter/material.dart';
import 'package:shutterhouse/utilities/constants.dart';

class BestOfferCard extends StatelessWidget {

  final String name,url;
  final double cost,discount;
  BestOfferCard({@required this.name,@required this.discount,@required this.url,@required this.cost});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: 36.0, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [ BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 3.0,
                  ),]
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image(
                        image: NetworkImage(url),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Text(
                            'Rs. $cost',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w900,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
          ),
          Positioned(
            top: 10,
            left: 36,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: kColorRed,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.zero,
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.circular(10.0),
                  )
              ),
              child: Text(
                '${discount*100}% off',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Proxima Nova',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
