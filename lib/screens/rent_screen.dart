import 'package:flutter/material.dart';
import 'package:shutterhouse/components/category_list.dart';
import 'package:shutterhouse/components/clipped_header.dart';
import 'package:shutterhouse/components/rounded_button.dart';
import 'package:shutterhouse/components/text_input_decoration.dart';
import 'package:shutterhouse/utilities/constants.dart';

class RentScreen extends StatefulWidget {
  @override
  _RentScreenState createState() => _RentScreenState();

  static final String id = 'rent_screen';
}

class _RentScreenState extends State<RentScreen> {

  String _selectedCategory = 'category_photo';

  @override
  Widget build(BuildContext context) {

    return Material(
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
                          //TODO:CODE
                        },
                        decoration: textInputDecoration(color: kColorRed, hint: 'Enter product name', showError: false,icon: Icons.title),//TODO
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        onChanged: (value){
                          //TODO:CODE
                        },
                        textAlignVertical: TextAlignVertical.center,
                        decoration: textInputDecoration(color: kColorRed, hint: 'Enter product description', showError: false,icon: Icons.description),//TODO
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        onChanged: (value){
                          //TODO:CODE
                        },
                        keyboardType: TextInputType.numberWithOptions(),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: textInputDecoration(color: kColorRed, hint: 'Enter rent per day', showError: false,icon: Icons.attach_money),//TODO
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
                      Container(
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
                          child: IconButton(
                            onPressed: (){
                              // TODO : Code
                            },
                            icon: Icon(
                              Icons.add,
                              color: kColorRed,
                            ),
                          )
                        ),
                      ),
                      SizedBox(
                        height:25,
                      ),
                      RoundedButton(
                        color: kColorRed,
                        text: 'Continue',
                        onPressed: (){
                          // TODO : code
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
