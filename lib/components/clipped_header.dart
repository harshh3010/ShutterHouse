import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class ClippedHeader extends StatelessWidget {
  final Color color;
  ClippedHeader({@required this.color});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperOne(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 80.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/welcomebg.jpg'),
            fit: BoxFit.cover,
            colorFilter:
                ColorFilter.mode(color.withOpacity(0.85), BlendMode.srcATop),
          ),
        ),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Shutter House',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Proxima Nova',
                  fontWeight: FontWeight.w900,
                  fontSize: 35.0),
            )
          ],
        ),
      ),
    );
  }
}
