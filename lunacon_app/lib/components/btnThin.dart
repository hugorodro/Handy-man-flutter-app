import 'package:flutter/material.dart';
import 'package:lunacon_app/main.dart';

class ThinButton extends StatelessWidget {
  final String aText;
  final String aRoute;

  ThinButton({this.aText, this.aRoute});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: cobaltColor, width: 2)),
        color: cobaltColor,
        child: FlatButton(
          child: Text(aText,
              style: TextStyle(fontSize: labelSize, color: Colors.white)),
          onPressed: () {
            Navigator.pushNamed(context, aRoute);
          },
        ),
      ),
    );
  }
}
