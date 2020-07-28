import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shutterhouse/components/category_card.dart';
import 'package:shutterhouse/components/category_list.dart';
import 'package:shutterhouse/components/loading_card.dart';
import 'package:shutterhouse/components/product_card.dart';
import 'package:shutterhouse/components/search_box.dart';
import 'package:shutterhouse/model/category.dart';
import 'package:shutterhouse/model/product.dart';
import 'package:shutterhouse/screens/best_offers_screen.dart';
import 'package:shutterhouse/screens/category_screen.dart';
import 'package:shutterhouse/screens/product_screen.dart';
import 'package:shutterhouse/utilities/constants.dart';
import 'package:shutterhouse/utilities/user_api.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<String> _address;
  UserApi userApi = UserApi.instance;
  List<Widget> categoryCards;
  List<Category> availableCategories = [];
  List<Product> offerProducts = [];
  Widget bestOffer = Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.white,
      strokeWidth: 4,
    ),
  );
  List<Widget> displayedCategories;
  String filter;


  Future<void> loadData() async{
    loadCategories();
    loadOffers();
  }

  Future<void> loadOffers() async{
    for(var category in CategoryList.getCategories()){
      QuerySnapshot querySnapshot = await Firestore.instance.collection('Products')
          .document('${_address[2]},${_address[4]}')
          .collection(category.id)
          .where('discount',isGreaterThan: 0)
          .getDocuments();
      for(var snapshot in querySnapshot.documents){
        Product product = Product(
          id: snapshot.data['id'],
          name: snapshot.data['name'],
          description: snapshot.data['description'],
          cost: snapshot.data['cost'],
          category: snapshot.data['category'],
          city: snapshot.data['city'],
          country: snapshot.data['country'],
          discount: snapshot.data['discount'],
          imageURL: snapshot.data['imageUrl'],
          ownerEmail: snapshot.data['ownerEmail'],
          ownerName: snapshot.data['ownerName'],
          rating: snapshot.data['rating'],
          reviews: snapshot.data['reviews'],
          rents: snapshot.data['rents'],
        );
        offerProducts.add(product);
      }
    }

    offerProducts.sort( (a,b) => b.discount.compareTo(a.discount) );

    setState(() {
      bestOffer = ProductCard(
        product: offerProducts[0],
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductScreen(
                    product: offerProducts[0],
                    image: Image.network(offerProducts[0].imageURL),
                  )));
        },
      );
    });
  }

  Future<void> loadCategories() async{
    categoryCards = [
      SizedBox(width: 30.0,),
      LoadingCard(),
      LoadingCard(),
      LoadingCard(),
      LoadingCard(),
    ];
    List<Widget> myList = [];
    myList.add(SizedBox(width: 30.0));

    for(var category in CategoryList.getCategories() ){
     var snapshot = await Firestore.instance.collection('Products').document('${_address[2]},${_address[4]}').collection('${category.id}').getDocuments();
     if(snapshot.documents.length == 0){
       continue;
     }else{
       availableCategories.add(category);
       myList.add(CategoryCard(
         category: category.name,
         imagePath: 'images/${category.id}.png',
         onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen(category: category.name,category_id: category.id,)));
         },
       ));
     }
    }
    setState(() {
      categoryCards = myList;
    });
  }

  @override
  void initState() {
    super.initState();

    _address = (userApi.address).split(',').toList();
    loadData();
  }

  @override
  Widget build(BuildContext context) {

    if(filter == null){
      displayedCategories = categoryCards;
    }

    return Container(
        width: double.infinity,
        height: double.infinity,
        child: RefreshIndicator(
          onRefresh: loadData,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 0),
                      child: Text(
                        'Hello,',
                        style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w900,
                          color: kColorRed,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 0),
                      child: Text(
                        'What equipment are you looking for?',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Proxima Nova',
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SearchBox(
                      hint: 'Try Lens',
                      onChanged: (value){
                        if(value.toString().trim().isEmpty){
                          setState(() {
                            filter = null;
                          });
                        }else{
                          filter = value.toString().toLowerCase();
                          List<Category> filteredList = availableCategories.where((category) => category.name.toLowerCase().contains(filter)).toList();
                          List<Widget> myList = [SizedBox(width: 30.0,),];
                          for(var category in filteredList){
                            myList.add(
                              CategoryCard(
                                category: category.name,
                                imagePath: 'images/${category.id}.png',
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen(category: category.name,category_id: category.id,)));
                                },
                              ),
                            );
                          }
                          setState(() {
                            displayedCategories = myList;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: displayedCategories,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36.0, vertical: 0),
                      child: Row(
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Best offers',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 30,
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BestOffersScreen(offerList: offerProducts,),
                                ),
                              );
                            },
                            child: Text(
                              'View All',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 20,
                                fontFamily: 'Proxima Nova',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: Container(
                        child: bestOffer,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}