import 'package:flutter/material.dart';
import 'package:shutterhouse/utilities/constants.dart';

class SearchBox extends StatelessWidget {

  final String hint;
  final Function onChanged;
  SearchBox({@required this.hint,@required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 30.0, vertical: 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
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
                child: TextField(
                  onChanged: onChanged,
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: kColorRed,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade800,
                    ),
                    hintText: hint,
                    hintStyle: TextStyle(
                      fontFamily: 'Proxima Nova',
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.bold,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: kColorRed,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 3.0,
                  ),
                ]),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  //TODO : code
                },
                child: Icon(
                  Icons.tune,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}