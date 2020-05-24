import 'package:flutter/material.dart';
import 'package:lunacon_app/models/jobsite.dart';
import 'package:lunacon_app/models/order.dart';

class ConfirmationScreen extends StatelessWidget {
  final List<Order> anOrderList;
  final JobSite aJS;

  ConfirmationScreen({this.aJS, this.anOrderList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.white, width: 2)),
            child: Column(
              children: <Widget>[
                Text('wass good')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
