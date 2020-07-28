class Booking{
  String id;
  String productId;
  int startTimestamp;
  int endTimestamp;
  String ownerEmail;
  String customerEmail;
  double cost;
  String imageUrl;
  String city;
  String country;
  String productName;
  String category;
  String contactNo;


  Booking({this.id, this.productId, this.startTimestamp, this.endTimestamp,
      this.ownerEmail, this.customerEmail, this.cost, this.imageUrl, this.city,
      this.country, this.productName, this.category,this.contactNo});

  Map<String,Object> getBookingData(){
    return {
      'id' : id,
      'productId' : productId,
      'startTimestamp' : startTimestamp,
      'endTimestamp' : endTimestamp,
      'ownerEmail' : ownerEmail,
      'customerEmail' : customerEmail,
      'cost' : cost,
      'imageUrl' : imageUrl,
      'city' : city,
      'country' : country,
      'productName' : productName,
      'category' : category,
      'contactNo' : contactNo,
    };
  }

  void setId(String id){
    this.id = id;
  }

}