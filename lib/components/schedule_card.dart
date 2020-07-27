import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shutterhouse/components/alert_box.dart';
import 'package:shutterhouse/components/booking_card.dart';
import 'package:shutterhouse/model/booking.dart';
import 'package:shutterhouse/utilities/constants.dart';
import 'package:shutterhouse/utilities/user_api.dart';

class ScheduleCard extends StatefulWidget {
  @override
  _ScheduleCardState createState() => _ScheduleCardState();

  final List<Booking> bookings;
  ScheduleCard({@required this.bookings});
}

class _ScheduleCardState extends State<ScheduleCard> {

  UserApi userApi = UserApi.instance;
  List<Booking> bookings;
  bool _loading = false;
  List<Widget> myBookings = [
    Center(
      child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: CircularProgressIndicator(
            strokeWidth: 4,
          )
      ),
    ),
  ];

  Future<void> cancelBooking(Booking booking) async {
    await Firestore.instance.collection('Bookings')
        .document('${booking.city},${booking.country}')
        .collection(booking.category)
        .document(booking.id)
        .delete().then((value){
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Booking cancelled!'),
              duration: Duration(seconds: 3),
            )
          );
    }).catchError((error){
      AlertBox().showErrorBox(context, error.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    bookings = widget.bookings;
    bookings.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));
    List<BookingCard> myList = [];
    for (var booking in bookings) {
      if(booking.endTimestamp > DateTime.now().millisecondsSinceEpoch){
        myList.add(
            BookingCard(
              booking: booking,
              icon: Icons.cancel,
              onPressed: (){
                Alert(
                  context: context,
                  title: 'Cancel Booking',
                  type: AlertType.warning,
                  desc: 'Are you sure?',
                  buttons: <DialogButton>[
                    DialogButton(
                      color: kColorRed,
                      child: Text(
                          'Yes',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async{
                        Navigator.pop(context);
                        setState(() {
                          _loading = true;
                        });
                        await cancelBooking(booking);
                        setState(() {
                          _loading = false;
                        });
                      },
                    ),
                    DialogButton(
                      color: kColorRed,
                      child: Text(
                        'No',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    )
                  ]
                ).show();
              },
            ),
        );
        setState(() {
          myBookings = myList;
        });
      }else{
        continue;
      }
    }

    if(myList.isEmpty){
      setState(() {
        myBookings = [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'Nothing to show',
                style: TextStyle(
                    fontFamily: 'Proxima Nova',
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
              ),
            ),
          ),
        ];
      });
    }else{
      setState(() {
        myBookings = myList;
      });
    }

    return Expanded(
      child: ModalProgressHUD(
        inAsyncCall: _loading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: myBookings,
        ),
      ),
    );
  }
}
