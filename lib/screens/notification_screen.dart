import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shutterhouse/components/notification_card.dart';
import 'package:shutterhouse/model/booking_notification.dart';
import 'package:shutterhouse/utilities/user_api.dart';

class NotificationScreen extends StatefulWidget {
  static final String id = 'notification_screen';
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  UserApi userApi = UserApi.instance;
  List<Widget> notificationCards = [
    Expanded(
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          strokeWidth: 4,
        ),
      ),
    ),
  ];

  Future<void> getNotifications() async {
    List<Widget> myList = [];
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('Notifications')
        .document(userApi.email)
        .collection('Notifications')
        .getDocuments();
    for (var snapshot in querySnapshot.documents) {
      BookingNotification notification = BookingNotification(
          ownerEmail: snapshot.data['ownerEmail'],
          customerEmail: snapshot.data['customerEmail'],
          productName: snapshot.data['productName'],
          timeStamp: snapshot.data['timeStamp']);
      myList.add(
        NotificationCard(
          notification: notification,
        ),
      );
    }

    setState(() {
      notificationCards = myList;
    });
  }

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
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
          centerTitle: true,
          title: Text(
            'Notifications',
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
          color: Colors.white,
          child: RefreshIndicator(
            onRefresh: getNotifications,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: notificationCards,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
