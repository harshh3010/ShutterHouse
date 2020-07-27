import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shutterhouse/components/alert_box.dart';
import 'package:shutterhouse/components/rounded_button.dart';
import 'package:shutterhouse/components/text_input_decoration.dart';
import 'package:shutterhouse/model/product.dart';
import 'package:shutterhouse/model/rating.dart';
import 'package:shutterhouse/model/review.dart';
import 'package:shutterhouse/utilities/constants.dart';
import 'package:shutterhouse/utilities/user_api.dart';

class AllReviewsScreen extends StatefulWidget {
  @override
  _AllReviewsScreenState createState() => _AllReviewsScreenState();

  final Product product;
  AllReviewsScreen({@required this.product});

}

class _AllReviewsScreenState extends State<AllReviewsScreen> {

  UserApi userApi = UserApi.instance;
  TextEditingController _messageController = TextEditingController();
  double _rating = 3;
  bool _loading = false;

  Future<void> submitReview() async {

    Review review = Review(
      category: widget.product.category,
      city: widget.product.city,
      country: widget.product.country,
      customerEmail: userApi.email,
      productId: widget.product.id,
      message: _messageController.text,
    );

    await Firestore.instance.collection('Reviews and Rating')
        .document('${widget.product.city},${widget.product.country}')
        .collection(widget.product.category)
        .document(widget.product.id)
        .collection('Reviews')
        .document(userApi.email)
        .setData(review.getReviewData()).catchError((error){
      AlertBox().showErrorBox(context, error.message);
    });

  }

  Future<void> submitRating() async {

    Rating rating = Rating(
      category: widget.product.category,
      city: widget.product.city,
      country: widget.product.country,
      customerEmail: userApi.email,
      productId: widget.product.id,
      value : _rating,
    );

    await Firestore.instance.collection('Reviews and Rating')
        .document('${widget.product.city},${widget.product.country}')
        .collection(widget.product.category)
        .document(widget.product.id)
        .collection('Rating')
        .document(userApi.email)
        .setData(rating.getRatingData()).catchError((error){
      AlertBox().showErrorBox(context, error.message);
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ModalProgressHUD(
        inAsyncCall: _loading,
        color: Colors.white,
        opacity: .5,
        progressIndicator: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(kColorRed),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            title: Text(
              'Reviews',
              style: TextStyle(
                color: Colors.grey.shade800,
                fontFamily: 'Proxima Nova',
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    padding: EdgeInsets.all(30),
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Rate & Review Product',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Proxima Nova',
                            fontSize: 16,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextField(
                          controller: _messageController,
                          maxLines: 5,
                          decoration: textInputDecoration(
                              color: kColorRed,
                              hint: 'Write your review here',
                              showError: false,
                              icon: Icons.edit),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        RatingBar(
                          itemSize: 30,
                          initialRating: _rating,
                          minRating: 1,
                          maxRating: 5,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: kColorRed,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              _rating = rating;
                            });
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        RoundedButton(
                          color: kColorRed,
                          text: 'Submit',
                          onPressed: () async {
                            //TODO : update rating and review in product and check for previous rating
                            Navigator.pop(context);
                            setState(() {
                              _loading = true;
                            });

                            if(_messageController.text.isEmpty){
                              await submitRating();
                            }else{
                              await submitReview();
                              await submitRating();
                            }

                            setState(() {
                              _loading = false;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: kColorRed,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.zero,
                  bottomLeft: Radius.zero,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              height: 80,
              child: Center(
                child: Text(
                  'RATE & REVIEW',
                  style: TextStyle(
                      fontFamily: 'Proxima Nova',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
