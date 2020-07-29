import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shutterhouse/components/review_card.dart';
import 'package:shutterhouse/model/product.dart';
import 'package:shutterhouse/model/review.dart';
import 'package:shutterhouse/screens/all_reviews_screen.dart';

class ReviewsPage extends StatefulWidget {
  @override
  _ReviewsPageState createState() => _ReviewsPageState();

  final Product product;
  ReviewsPage({@required this.product});
}

class _ReviewsPageState extends State<ReviewsPage> {

  List<Widget> reviewsList = [
    Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        strokeWidth: 4,
      ),
    ),
  ];
  
  void loadReviews() async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection('Reviews and Rating')
        .document('${widget.product.city},${widget.product.country}')
        .collection(widget.product.category)
        .document(widget.product.id)
        .collection('Reviews')
        .getDocuments();

    List<ReviewCard> myList = [];
    int n = 0;

    for(var snapshot in querySnapshot.documents){
      Review review = Review(
        imageUrl: snapshot.data['imageUrl'],
        name: snapshot.data['name'],
        message: snapshot.data['message'],
        productId: snapshot.data['productId'],
        customerEmail: snapshot.data['customerEmail'],
        country: snapshot.data['country'],
        city: snapshot.data['city'],
        category: snapshot.data['category'],
        ownerEmail: snapshot.data['ownerEmail'],
      );
      myList.add(ReviewCard(review: review,));

      setState(() {
        reviewsList = myList;
      });

      n++;
      if(n==2){
        break;
      }
    }

    setState(() {
      reviewsList = myList;
    });
  }

  @override
  void initState() {
        super.initState();
        loadReviews();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0,horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'User Reviews',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Proxima Nova',
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => AllReviewsScreen(product: widget.product,)));
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontFamily: 'Proxima Nova',
                    color: Colors.grey.shade400,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: reviewsList,
          )
        ],
      ),
    );
  }
}