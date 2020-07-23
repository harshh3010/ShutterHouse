import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shutterhouse/components/product_card.dart';
import 'package:shutterhouse/components/search_box.dart';
import 'package:shutterhouse/utilities/constants.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();

  final String category;
  CategoryScreen({@required this.category});
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          '${widget.category}',
          style: TextStyle(
            fontFamily: 'Proxima Nova',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            SearchBox(
              hint: 'Search for a product',
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              child: Text(
                  'Your Options',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 30,
                  fontFamily: 'Proxima Nova',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ProductCard(
                    photoUrl: 'https://pluspng.com/img-png/nikon-png-black-nikon-black-nikon-camera-png-image-260.jpg',
                    price: 1500,
                    rating: 4.7,
                    name: 'Product Name',
                  ),
                  ProductCard(
                    photoUrl: 'https://pluspng.com/img-png/nikon-png-black-nikon-black-nikon-camera-png-image-260.jpg',
                    price: 1500,
                    rating: 4.7,
                    name: 'Product Name',
                  ),
                  ProductCard(
                    photoUrl: 'https://pluspng.com/img-png/nikon-png-black-nikon-black-nikon-camera-png-image-260.jpg',
                    price: 1500,
                    rating: 4.7,
                    name: 'Product Name',
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}