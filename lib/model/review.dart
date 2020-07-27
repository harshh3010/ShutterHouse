class Review{

  String message;
  String customerEmail;
  String productId;
  String city;
  String country;
  String category;

  Review({this.message, this.customerEmail, this.productId, this.city,
      this.country, this.category});

  Map<String,Object> getReviewData(){
    return {
      'message' : this.message,
      'customerEmail' : this.customerEmail,
      'productId' : this.productId,
      'city' : this.city,
      'country' : this.country,
      'category' : this.category,
    };
  }

}