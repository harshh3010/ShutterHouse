class Rating{
  double value;
  String customerEmail;
  String ownerEmail;
  String productId;
  String city;
  String country;
  String category;


  Rating({this.value, this.customerEmail, this.productId, this.city,
      this.country, this.category,this.ownerEmail});

  Map<String,Object> getRatingData(){
    return {
      'value' : this.value,
      'customerEmail' : this.customerEmail,
      'productId' : this.productId,
      'city' : this.city,
      'country' : this.country,
      'category' : this.category,
      'ownerEmail' : this.ownerEmail,
    };
  }

}