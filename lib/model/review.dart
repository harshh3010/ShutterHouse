class Review{

  String message;
  String customerEmail;
  String ownerEmail;
  String productId;
  String city;
  String country;
  String category;
  String name;
  String imageUrl;


  Review({this.message, this.customerEmail, this.productId, this.city,
      this.country, this.category, this.name, this.imageUrl,this.ownerEmail});

  Map<String,Object> getReviewData(){
    return {
      'message' : this.message,
      'customerEmail' : this.customerEmail,
      'productId' : this.productId,
      'city' : this.city,
      'country' : this.country,
      'category' : this.category,
      'name' : this.name,
      'imageUrl' : this.imageUrl,
      'ownerEmail' : this.ownerEmail,
    };
  }

}