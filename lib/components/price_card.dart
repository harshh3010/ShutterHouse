import 'package:flutter/material.dart';
import 'package:shutterhouse/components/number_label.dart';
import 'package:shutterhouse/utilities/constants.dart';

class PriceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
            child: Text(
              'Price Details',
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 30,
                fontFamily: 'Proxima Nova',
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 3.0,
                              ),
                            ]),
                        child: NumberLabel(label:'Weekday', value: 'Rs 1200', labelColor: Colors.grey.shade400, valueColor: Colors.grey.shade800),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 3.0,
                              ),
                            ]),
                        child: NumberLabel(label:'Discount', value: '0%', labelColor: Colors.grey.shade400, valueColor: kColorRed),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
