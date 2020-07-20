import 'package:flutter/material.dart';
import 'package:shutterhouse/components/best_offer_card.dart';
import 'package:shutterhouse/components/category_card.dart';
import 'package:shutterhouse/utilities/constants.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 0),
            child: Text(
              'Hello,',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Proxima Nova',
                fontWeight: FontWeight.w900,
                color: kColorRed,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 0),
            child: Text(
              'What equipment are you looking for?',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Proxima Nova',
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [ BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 3.0,
                        ),]
                    ),
                    child: Center(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: kColorRed,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey.shade800,
                          ),
                          hintText: 'Try lens',
                          hintStyle: TextStyle(
                            fontFamily: 'Proxima Nova',
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: kColorRed,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [ BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 3.0,
                      ),]
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: (){
                        //TODO : code
                      },
                      child: Icon(
                        Icons.tune,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  CategoryCard(
                    category: 'Photo',
                    url: 'https://pluspng.com/img-png/nikon-png-black-nikon-black-nikon-camera-png-image-260.jpg',
                  ),
                  CategoryCard(
                    category: 'Video',
                    url: 'https://pluspng.com/img-png/nikon-png-black-nikon-black-nikon-camera-png-image-260.jpg',
                  ),
                  CategoryCard(
                    category: 'Go Pro',
                    url: 'https://pluspng.com/img-png/nikon-png-black-nikon-black-nikon-camera-png-image-260.jpg',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0,vertical: 0),
            child: Row(
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Best offers',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 30,
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'View All',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 20,
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          BestOfferCard(
            name: 'Name of the product',
            cost: 2000,
            discount: .5,
            url: 'https://pluspng.com/img-png/nikon-png-black-nikon-black-nikon-camera-png-image-260.jpg',
          ),
        ],
      ),
    );
  }
}
