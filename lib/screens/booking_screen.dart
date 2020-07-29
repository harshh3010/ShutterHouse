import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shutterhouse/components/alert_box.dart';
import 'package:shutterhouse/components/rounded_button.dart';
import 'package:shutterhouse/model/booking.dart';
import 'package:shutterhouse/model/product.dart';
import 'package:shutterhouse/utilities/constants.dart';
import 'package:shutterhouse/utilities/user_api.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();

  final Product product;
  final List<Map<String,int>> bookedSlots;
  BookingScreen({@required this.product,@required this.bookedSlots});
}

class _BookingScreenState extends State<BookingScreen> {
  
  int _startTimestamp,_endTimestamp;
  String _startDate,_endDate;
  final DateFormat formatter = DateFormat('MMMM, d, yyyy');
  UserApi userApi = UserApi.instance;
  bool _loading = false;
  
  Future<void> confirmBooking() async {

    setState(() {
      _loading = true;
    });

    Booking booking = Booking(
      category: widget.product.category,
      city: widget.product.city,
      country: widget.product.country,
      cost: widget.product.cost - widget.product.cost*widget.product.discount/100,
      customerEmail: userApi.email,
      ownerEmail: widget.product.ownerEmail,
      imageUrl: widget.product.imageURL,
      endTimestamp: _endTimestamp,
      startTimestamp: _startTimestamp,
      productId: widget.product.id,
      productName: widget.product.name,
      contactNo: userApi.phoneNo,
    );

    DocumentReference documentReference = await Firestore.instance.collection('Bookings')
        .document('${widget.product.city},${widget.product.country}')
        .collection(widget.product.category)
        .document();

    booking.setId(documentReference.documentID);

    documentReference.setData(booking.getBookingData()).then((value){
      Navigator.pop(context);
    }).catchError((error){
      AlertBox.showErrorBox(context, error.message);
    });

    setState(() {
      _loading = false;
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
          ),
          body: Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 0,
                      ),
                      child: Text(
                        'Book Now',
                        style: TextStyle(
                          color: kColorRed,
                          fontFamily: 'Proxima Nova',
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      child: Text(
                        'From',
                        style: TextStyle(
                          color: kColorRed,
                          fontFamily: 'Proxima Nova',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          ).then((value) {
                            if(value.day == DateTime.now().day && value.month == DateTime.now().month && value.year == DateTime.now().year){
                              AlertBox.showErrorBox(context, 'You cannot select today\'s date');
                            }else{
                              setState(() {
                                _startTimestamp = value.millisecondsSinceEpoch;
                                _startDate = formatter.format(value);
                                _endDate = null;
                                _endTimestamp = null;
                              });
                            }
                          });
                        },
                        child: Text(
                          _startTimestamp == null ? 'Choose a Date' : '$_startDate',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontFamily: 'Proxima Nova',
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      child: Text(
                        'To',
                        style: TextStyle(
                          color: kColorRed,
                          fontFamily: 'Proxima Nova',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if(_startTimestamp != null){
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100),
                            ).then((value) {
                             if(value.millisecondsSinceEpoch > _startTimestamp + 1000*60*60*23){
                               setState(() {
                                 _endTimestamp = value.millisecondsSinceEpoch;
                                 _endDate = formatter.format(value);
                               });
                             }else{
                               AlertBox.showErrorBox(context, 'Please select a date after start date');
                             }
                            });
                          }else{
                            AlertBox.showErrorBox(context, 'Please select a starting date first.');
                          }
                        },
                        child: Text(
                          _endTimestamp == null ? 'Choose a Date' : '$_endDate',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontFamily: 'Proxima Nova',
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: RoundedButton(
                        color: kColorRed,
                        text: 'Confirm Booking',
                        onPressed: () async {
                          if(_endTimestamp != null){

                            if(_endTimestamp - _startTimestamp > 1000*60*60*24*19){
                              AlertBox.showErrorBox(context, 'You cannot book a product for more than 20 days');
                            }else{
                              bool canBook = true;
                              for(var booking in widget.bookedSlots){
                                if((_startTimestamp < booking['startTimestamp'] && _endTimestamp < booking['startTimestamp'])
                                    || _startTimestamp > booking['endTimestamp']){
                                  continue;
                                }else{
                                  canBook = false;
                                }
                              }
                              if(canBook){
                                await confirmBooking();
                              }else{
                                AlertBox.showErrorBox(context, 'The product is not available during the selected time period.');
                              }
                            }
//
                          }else{
                            AlertBox.showErrorBox(context, 'Please select a duration first.');
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
