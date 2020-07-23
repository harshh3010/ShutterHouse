import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shutterhouse/components/alert_box.dart';
import 'package:shutterhouse/components/category_list.dart';
import 'package:shutterhouse/components/clipped_header.dart';
import 'package:shutterhouse/components/rounded_button.dart';
import 'package:shutterhouse/components/text_input_decoration.dart';
import 'package:shutterhouse/model/product.dart';
import 'package:shutterhouse/utilities/constants.dart';
import 'package:shutterhouse/utilities/user_api.dart';

class RentScreen extends StatefulWidget {
  @override
  _RentScreenState createState() => _RentScreenState();

  static final String id = 'rent_screen';
}

class _RentScreenState extends State<RentScreen> {

  String _selectedCategory = 'category_photo';
  String _name,_description;
  double _cost;
  bool n = false,d = false,c = false,_loading = false;
  File _image;
  UserApi userApi = UserApi.instance;
  String _uploadedFileURL;
  List<String> _address;
  String timestamp;

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Products/${userApi.email}/${timestamp}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      addProduct(fileURL);
    });
  }

  void addProduct(String url) async {

    Product product = Product(
      id: null,
      name: _name,
      description:  _description,
      cost: _cost,
      category: _selectedCategory,
      imageURL: url,
      discount: 0,
      rents: 0,
      reviews: 0,
      rating: 0,
      city: '${_address[2]}',
      country: '${_address[4]}',
      ownerName: userApi.name,
      ownerEmail: userApi.email,
    );

    Firestore.instance.collection('Products').document('${product.city},${product.country}').setData(new Map<String,String>()).then((value) async {
      DocumentReference documentReference = Firestore.instance.collection('Products').document('${product.city},${product.country}')
          .collection('${product.category}').document();
      product.setId(documentReference.documentID);
      documentReference.setData(product.getProductData()).then((value){
        Navigator.pop(context);
      }).catchError((error){
        AlertBox().showErrorBox(context,error.message);
      });
    }).catchError((error){
      AlertBox().showErrorBox(context,'An error occurred');
    });
  }

  @override
  Widget build(BuildContext context) {

    _address = (userApi.address).split(',').toList();

    return ModalProgressHUD(
      inAsyncCall: _loading,
      color: Colors.white,
      opacity: .5,
      progressIndicator: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(kColorRed),
      ),
      child: Material(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClippedHeader(
                color: kColorRed,
                text: 'Rent a Product',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Enter product details',
                            style: TextStyle(
                              color: kColorRed,
                              fontSize: 30,
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          onChanged: (value){
                            _name = value;
                          },
                          decoration: textInputDecoration(color: kColorRed, hint: 'Enter product name', showError: n,icon: Icons.title),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          onChanged: (value){
                            _description = value;
                          },
                          textAlignVertical: TextAlignVertical.center,
                          decoration: textInputDecoration(color: kColorRed, hint: 'Enter product description', showError: d,icon: Icons.description),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          onChanged: (value){
                            _cost = double.parse(value);
                          },
                          keyboardType: TextInputType.numberWithOptions(),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: textInputDecoration(color: kColorRed, hint: 'Enter rent per day', showError: c,icon: Icons.attach_money),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Select a category',
                              style: TextStyle(
                                fontFamily: 'Proxima Nova',
                                color: kColorRed,
                                fontSize: 20,
                              ),
                            ),
                            DropdownButton(
                              value: _selectedCategory,
                              items: displayCategories(),
                              onChanged: (value){
                                setState(() {
                                  _selectedCategory = value;
                                });
                              },
                              focusColor: kColorRed,
                              style: TextStyle(
                                fontFamily: 'Proxima Nova',
                                color: Colors.grey.shade800,
                                fontSize: 20,
                              ),
                              underline: SizedBox(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Select an image for product',
                          style: TextStyle(
                            fontFamily: 'Proxima Nova',
                            color: kColorRed,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height:15,
                        ),
                        GestureDetector(
                          onTap: (){
                            chooseFile();
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 3.0,
                                  ),
                                ]),
                            child: Center(
                              child: _image == null ?
                              Icon(
                                Icons.add,
                                color: kColorRed,
                              ): Image(
                                image: FileImage(_image),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height:25,
                        ),
                        RoundedButton(
                          color: kColorRed,
                          text: 'Continue',
                          onPressed: () async {
                            setState(() {
                              _loading = true;
                            });
                            if(_name != null && _description != null && _cost != null && _image != null){
                              if(_cost<=0){
                                AlertBox().showErrorBox(context, 'Please enter a valid rent.');
                              }else{
                                timestamp = (DateTime.now()).toString();
                                await uploadFile();
                              }
                            }else{
                              if(_name == null)
                                setState(() {
                                  n = true;
                                });
                              if(_description == null)
                                setState(() {
                                  d = true;
                                });
                              if(_cost == null)
                                setState(() {
                                  c = true;
                                });
                              if(_image == null){
                                AlertBox().showErrorBox(context, 'Please select an image for the product.');
                              }
                            }
                            setState(() {
                              _loading = false;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<DropdownMenuItem<String>> displayCategories(){
  List<DropdownMenuItem<String>> myList = [];
  for(var category in CategoryList.getCategories()){
    myList.add(
        DropdownMenuItem<String>(
          value: category.id,
          child: Text(category.name),
        )
    );
  }
  return myList;
}
