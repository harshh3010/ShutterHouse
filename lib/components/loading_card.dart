import 'package:flutter/material.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 116,
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
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 4,
          ),
        ),
      ),
    );
  }
}