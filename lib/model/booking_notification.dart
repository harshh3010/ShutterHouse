class BookingNotification{
  String customerEmail;
  String ownerEmail;
  String timeStamp;
  String productName;

  BookingNotification({this.customerEmail, this.ownerEmail, this.timeStamp,
      this.productName});

  Map<String,Object> getNotificationData(){
    return {
      'customerEmail' : this.customerEmail,
      'ownerEmail' : this.ownerEmail,
      'productName' : this.productName,
      'timeStamp' : this.timeStamp,
    };
  }
}