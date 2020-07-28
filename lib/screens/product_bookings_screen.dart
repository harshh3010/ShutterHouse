import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shutterhouse/components/booking_card.dart';
import 'package:shutterhouse/components/category_list.dart';
import 'package:shutterhouse/model/booking.dart';
import 'package:shutterhouse/model/product.dart';
import 'package:shutterhouse/utilities/constants.dart';

class ProductBookingsScreen extends StatefulWidget {
  @override
  _ProductBookingsScreenState createState() => _ProductBookingsScreenState();

  final Product product;
  ProductBookingsScreen({@required this.product});
}


class _ProductBookingsScreenState extends State<ProductBookingsScreen> {
  List<Widget> productBookingCards = [
    Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        strokeWidth: 4,
      ),
    ),
  ];

  Future<void> loadBookings() async {
    List<BookingCard> myList = [];

    for (var category in CategoryList.getCategories()) {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection('Bookings')
          .document('${widget.product.city},${widget.product.country}')
          .collection(category.id)
          .where('productId', isEqualTo: widget.product.id)
          .getDocuments();
      for (var snapshot in querySnapshot.documents) {
        Booking booking = Booking(
          id: snapshot.data['id'],
          productName: snapshot.data['productName'],
          productId: snapshot.data['productId'],
          startTimestamp: snapshot.data['startTimestamp'],
          endTimestamp: snapshot.data['endTimestamp'],
          imageUrl: snapshot.data['imageUrl'],
          ownerEmail: snapshot.data['ownerEmail'],
          customerEmail: snapshot.data['customerEmail'],
          cost: snapshot.data['cost'],
          country: snapshot.data['country'],
          city: snapshot.data['city'],
          category: snapshot.data['category'],
          contactNo: snapshot.data['contactNo'],
        );
        myList.add(BookingCard(
          booking: booking,
          onPressed: () {
            Alert(
              context: context,
              title: 'Booking Details',
              desc: 'Booked by - ${booking.customerEmail}\nContact number - ${booking.contactNo}',
              buttons: [
                DialogButton(
                  color: kColorRed,
                  child: Text(
                    'Okay',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ]
            ).show();
          },
          icon: Icons.more_vert,
        ));
      }
    }
    setState(() {
      productBookingCards = myList;
    });
  }

  @override
  void initState() {
    super.initState();
    loadBookings();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
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
          centerTitle: true,
          title: Text(
            'Product Bookings',
            style: TextStyle(
              fontFamily: 'Proxima Nova',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0,vertical: 30),
          child: RefreshIndicator(
            onRefresh: loadBookings,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: productBookingCards,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
