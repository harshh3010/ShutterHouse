import 'package:flutter/material.dart';
import 'package:shutterhouse/model/product.dart';
import 'package:shutterhouse/screens/product_screen.dart';
import 'package:shutterhouse/utilities/constants.dart';

class ProductCard extends StatelessWidget {

  final Product product;
  final Function onPressed;
  final Function onLongPressed;
  ProductCard({@required this.product,this.onPressed,this.onLongPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: GestureDetector(
        onLongPress: onLongPressed,
        onTap: onPressed,
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
              Hero(
                tag: '${product.id}',
                child: Image(
                  image: NetworkImage(product.imageURL),
                  width: 100,
                ),
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
                      Hero(
                        tag: '${product.id}--NAME',
                        child: Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.w900,
                            color: Colors.grey.shade800,
                              decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Rs. ${product.cost}',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w900,
                              color: kColorRed,
                            ),
                          ),
                          Text(
                            '${product.discount}% off',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w900,
                              color: kColorRed,
                            ),
                          ),
                          Text(
                            '⭐ ${product.rating}',
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
      ),
    );
  }
}