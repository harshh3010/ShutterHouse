
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shutterhouse/components/alert_box.dart';
import 'package:shutterhouse/components/category_list.dart';
import 'package:shutterhouse/components/menu_option.dart';
import 'package:shutterhouse/components/product_card.dart';
import 'package:shutterhouse/components/rounded_button.dart';
import 'package:shutterhouse/components/text_input_decoration.dart';
import 'package:shutterhouse/model/product.dart';
import 'package:shutterhouse/screens/product_bookings_screen.dart';
import 'package:shutterhouse/screens/rent_screen.dart';
import 'package:shutterhouse/utilities/constants.dart';
import 'package:shutterhouse/utilities/user_api.dart';

class RentPage extends StatefulWidget {
  @override
  _RentPageState createState() => _RentPageState();
}


class _RentPageState extends State<RentPage> {

  List<String> _address;
  UserApi userApi = UserApi.instance;
  var _count = 0;
  var _tapPosition;
  bool _loading = false;
  double _discount = 0;
  List<Widget> myProducts = [
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

  Future<void> addDiscount(Product product) async{
    await Firestore.instance.collection('Products')
        .document('${product.city},${product.country}')
        .collection(product.category)
        .document(product.id)
        .updateData({'discount':_discount}).then((value){
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Discount added!'),
              duration: Duration(seconds: 3),
            ),
          );
    }).catchError((error){
      AlertBox.showErrorBox(context, error.message);
    });
  }

  Future<void> removeProduct(Product product) async {
    await Firestore.instance.collection('Products')
        .document('${_address[2]},${_address[4]}')
        .collection(product.category)
        .document(product.id)
        .delete().then((value){
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Product removed successfully.'),
          ));
    }).catchError((error){
      AlertBox.showErrorBox(context, error.message);
    });
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }
  
  void displayMenu(Product product){

    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    showMenu(
      context: context,
      position:  RelativeRect.fromRect(
          _tapPosition & Size(40, 40), // smaller rect, the touch area
          Offset.zero & overlay.size   // Bigger rect, the entire screen
      ),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'item_discount',
          child: MenuOption(
            label: 'Add Discount',
            icon: Icons.local_offer,
          ),
        ),
        PopupMenuItem<String>(
          value: 'item_remove',
          child: MenuOption(
            label: 'Remove Product',
            icon: Icons.delete,
          ),
        ),
      ],
    ).then((value) async {
      switch(value){
        case 'item_discount' :
          showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                padding: EdgeInsets.all(30),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Add a discount',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Proxima Nova',
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextField(
                      keyboardType: TextInputType.numberWithOptions(),
                      onChanged: (value){
                        _discount = double.parse(value);
                      },
                      decoration: textInputDecoration(
                          color: kColorRed,
                          hint: 'Enter discount (%)',
                          showError: false,
                          icon: Icons.local_offer),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RoundedButton(
                      color: kColorRed,
                      text: 'Submit',
                      onPressed: () async {
                        Navigator.pop(context);
                        setState(() {
                          _loading = true;
                        });
                        await addDiscount(product);
                        setState(() {
                          _loading = false;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          );
          break;
        case 'item_remove' :
          setState(() {
            _loading = true;
          });
          await removeProduct(product);
          setState(() {
            _loading = false;
          });
      }
    });
  }

  Future<void> loadUserProducts() async {
    List<Widget> myList = [];

    for(var category in CategoryList.getCategories()){
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection('Products')
          .document('${_address[2]},${_address[4]}')
          .collection(category.id)
          .where('ownerEmail',isEqualTo: userApi.email)
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

        myList.add(
            GestureDetector(
              onTapDown: _storePosition,
              child: ProductCard(
                product: product,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductBookingsScreen(product: product,),
                    ),
                  );
                },
                onLongPressed: (){
                  displayMenu(product);
                },
              ),
            ),
        );
      }
    }

    setState(() {
      myProducts = myList;
    });

  }

  @override
  void initState() {
    super.initState();
    _address = (userApi.address).split(',').toList();
    loadUserProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      color: Colors.white,
      opacity: .5,
      progressIndicator: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(kColorRed),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: RefreshIndicator(
          onRefresh: loadUserProducts,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10),
                child: Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'On Rent',
                      style: TextStyle(
                        color: kColorRed,
                        fontSize: 36,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        Navigator.pushNamed(context,RentScreen.id);
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: kColorRed,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: myProducts,
              ),
            ],
          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



