import 'package:flutter/material.dart';

class GenericAlert extends StatelessWidget {
  final String aTitle;
  final String aMsg;
  final String btnText;
  GenericAlert({this.aTitle, this.aMsg, this.btnText});
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(aTitle),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(aMsg),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(btnText),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
