import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shutterhouse/components/product_card.dart';
import 'package:shutterhouse/components/search_box.dart';
import 'package:shutterhouse/model/product.dart';
import 'package:shutterhouse/screens/product_screen.dart';
import 'package:shutterhouse/utilities/user_api.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();

  final String category, category_id;
  CategoryScreen({@required this.category, @required this.category_id});
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Widget> availableProducts = [
    Center(
      child: Padding(
        padding: const EdgeInsets.all(80.0),
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          strokeWidth: 4,
        ),
      ),
    ),
  ];
  UserApi userApi = UserApi.instance;
  List<String> _address;

  void loadProducts() async {
    List<ProductCard> myList = [];
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('Products')
        .document('${_address[2]},${_address[4]}')
        .collection(widget.category_id)
        .getDocuments();
    for (var snapshot in querySnapshot.documents) {
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

      myList.add(
        ProductCard(
          product: product,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductScreen(
                          product: product,
                          image: Image.network(product.imageURL),
                        )));
          },
        ),
      );
    }
    setState(() {
      availableProducts = myList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _address = (userApi.address).split(',').toList();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
            '${widget.category}',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              SearchBox(
                hint: 'Search for a product',
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  'Your Options',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 30,
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: availableProducts,
                ),
              )
            ],
          ),
        ));
  }
}
