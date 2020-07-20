import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {

  final String category,url;
  CategoryCard({@required this.category,@required this.url});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 150,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [ BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 3.0,
                ),]
            ),
            child: Center(
              child: Image(
                image: NetworkImage(url),
                width: 100,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Proxima Nova',
              fontWeight: FontWeight.w900,
              color: Colors.grey.shade800,
            ),
          ),
        )
      ],
    );
  }
}