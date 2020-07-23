class Product{

  String id;
  String name;
  String description;
  double cost;
  String category;
  String imageURL;
  double discount;
  int rents;
  int reviews;
  double rating;
  String city;
  String country;
  String ownerName;
  String ownerEmail;

  Product({this.id,this.name, this.description, this.cost, this.category, this.imageURL,
      this.discount, this.rents, this.reviews, this.rating, this.city,
      this.country, this.ownerName, this.ownerEmail});

  Map<String,Object> getProductData(){
    return {
      'name' : name,
      'description' : description,
      'cost' : cost,
      'category' : category,
      'imageUrl' : imageURL,
      'discount' : discount,
      'rents' : rents,
      'reviews' : reviews,
      'rating' : rating,
      'city' : city,
      'country' : country,
      'ownerName' : ownerName,
      'ownerEmail' : ownerEmail,
    };
  }


}