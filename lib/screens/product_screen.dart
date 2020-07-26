import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shutterhouse/components/number_label.dart';
import 'package:shutterhouse/components/price_card.dart';
import 'package:shutterhouse/components/rents_button.dart';
import 'package:shutterhouse/model/product.dart';
import 'package:shutterhouse/screens/booking_screen.dart';
import 'package:shutterhouse/utilities/constants.dart';

enum Selection { Reviews, Price }

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();

  final Product product;
  final Image image;
  ProductScreen({@required this.product,@required this.image});
}

class _ProductScreenState extends State<ProductScreen> {

  Selection selectedButton = Selection.Reviews;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {

    final DateFormat formatter = DateFormat('MMMM, d, yyyy');

    Widget cardToDisplay;
    if(selectedButton == Selection.Reviews){
      cardToDisplay = Container(color: kColorRed,width: 150,height: 150,);
    }else{
      cardToDisplay = PriceCard(
        cost: widget.product.cost,
        discount: widget.product.discount,
      );
    }
    
    void checkAvailability() async {

      setState(() {
        _loading = true;
      });

     QuerySnapshot querySnapshot = await Firestore.instance.collection('Bookings')
          .document('${widget.product.city},${widget.product.country}')
          .collection(widget.product.category)
          .where('productId',isEqualTo: widget.product.id)
          .getDocuments();

     if(querySnapshot.documents.length != 0){
       String bookingStatus = "";
       List<Map<String,int>> bookedSlots = [];

       for(var snapshot in querySnapshot.documents){
         if(snapshot.data['endTimestamp'] < DateTime.now().millisecondsSinceEpoch){
           Navigator.push(context,MaterialPageRoute(builder: (context) => BookingScreen(product: widget.product,bookedSlots: [],)));
         }else{
            var startDate = formatter.format(DateTime.fromMillisecondsSinceEpoch(snapshot.data['startTimestamp']));
            var endDate = formatter.format(DateTime.fromMillisecondsSinceEpoch(snapshot.data['endTimestamp']));

            bookedSlots.add({
              'startTimestamp' : snapshot.data['startTimestamp'],
              'endTimestamp' : snapshot.data['endTimestamp'],
            });

            bookingStatus = bookingStatus + "\t-> $startDate to $endDate\n";
         }
       }
       Alert(
         context: context,
         type: AlertType.warning,
         title: "Product Availability",
         desc: "The product you have selected is not available on following dates\n\n$bookingStatus",
         buttons: [
           DialogButton(
             child: Text(
               "Okay",
               style: TextStyle(color: Colors.white, fontSize: 20),
             ),
             onPressed: (){
               Navigator.pop(context);
               Navigator.push(context,MaterialPageRoute(builder: (context) => BookingScreen(product: widget.product,bookedSlots: bookedSlots,)));
               },
             color: kColorRed,
             width: 120,
           )
         ],
       ).show();
     }else{
       Navigator.push(context,MaterialPageRoute(builder: (context) => BookingScreen(product: widget.product,bookedSlots: [],)));
     }

      setState(() {
        _loading = false;
      });
    }

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
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 30.0),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 60.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.zero,
                                topRight: Radius.zero,
                                bottomLeft: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          NumberLabel(
                                            value: '${widget.product.rents}',
                                            label: 'RENTS',
                                            valueColor: Colors.grey.shade800,
                                            labelColor: Colors.grey.shade400,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          NumberLabel(
                                            value: '${widget.product.reviews}',
                                            label: 'REVIEWS',
                                            valueColor: Colors.grey.shade800,
                                            labelColor: Colors.grey.shade400,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                                        child: Hero(
                                          tag: '${widget.product.id}',
                                          child: widget.image,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                                  child: Hero(
                                    tag: '${widget.product.id}--NAME',
                                    child: Text(
                                      widget.product.name,
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontFamily: 'Proxima Nova',
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                                  child: Text(
                                    widget.product.description,
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontFamily: 'Proxima Nova',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 30.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width - 60.0,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 5.0,
                                      ),
                                    ]),
                                child: Row(
                                  children: <Widget>[
                                    RentsButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedButton = Selection.Reviews;
                                        });
                                      },
                                      label: 'Reviews',
                                      isActive: selectedButton == Selection.Reviews ,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    RentsButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedButton = Selection.Price;
                                        });
                                      },
                                      label: 'Price',
                                      isActive: selectedButton == Selection.Price,
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    cardToDisplay,
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: GestureDetector(
            onTap: (){
            checkAvailability();
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
                  'CHECK AVAILABILITY',
                  style: TextStyle(
                    fontFamily: 'Proxima Nova',
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
