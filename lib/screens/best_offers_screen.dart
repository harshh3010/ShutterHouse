import 'package:flutter/material.dart';
import 'package:shutterhouse/components/product_card.dart';
import 'package:shutterhouse/model/product.dart';
import 'package:shutterhouse/screens/product_screen.dart';

class BestOffersScreen extends StatefulWidget {
  static final String id = 'best_offers_screen';
  @override
  _BestOffersScreenState createState() => _BestOffersScreenState();

  final List<Product> offerList;
  BestOffersScreen({@required this.offerList});
}

class _BestOffersScreenState extends State<BestOffersScreen> {

  List<Widget> offerCards = [
    Expanded(
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          strokeWidth: 4,
        ),
      ),
    )
  ];

  void loadOfferList(){
    List<Widget> myList = [];
    for(var product in widget.offerList){
      myList.add(ProductCard(
        product: product,
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductScreen(
                    product: product,
                    image: Image.network(product.imageURL),
                  )));
        },
      ));
    }
    setState(() {
      offerCards = myList;
    });
  }

  @override
  void initState() {
    super.initState();
    loadOfferList();
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: Scaffold(
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
            'Offers',
            style: TextStyle(
              fontFamily: 'Proxima Nova',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: offerCards,
          ),
        ),
      ),
    );
  }
}
