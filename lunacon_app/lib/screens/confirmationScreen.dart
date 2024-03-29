import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lunacon_app/main.dart';
import 'package:lunacon_app/models/jobsite.dart';
import 'package:lunacon_app/data/cart_module.dart';

class ConfirmationScreen extends StatefulWidget {
  final JobSite aJS;

  ConfirmationScreen({this.aJS});

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  double total = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(image: bgImage, fit: BoxFit.fill),
      ),
      child: ClipRRect(
        // make sure we apply clip it properly
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(0.1),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.blue,
                centerTitle: true,
                title: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context, '/supply');
                      },
                    ),
                    Expanded(
                      child: Container(
                          child: Text(
                        'Review',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )),
                    ),
                    SizedBox(
                      width: 45,
                    ),
                  ],
                ),
              ),
              body: Column(
                children: <Widget>[
                  Spacer(),
                  Container(
                    height: screenHeight * .5,
                    width: screenWidth * .9,
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.white, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: <Widget>[
                            _receiptHeader(context),
                            Container(height: 1, color: Colors.blue),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: _myReceipt(context),
                                )),
                            Container(height: 1, color: Colors.blue),
                            _receiptFooter(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 2 * AppBar().preferredSize.height,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.65),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: _btnOrder(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _receiptHeader(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            alignment: Alignment.centerLeft,
            child: Text(authToken.firstName + ' ' + authToken.lastName,
                style: TextStyle(color: Colors.grey[900], fontSize: 20))),
        SizedBox(
          height: 5,
        ),
        Container(
            alignment: Alignment.centerLeft,
            child: Text(widget.aJS.code + " | " + widget.aJS.name,
                style: TextStyle(fontSize: 13))),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget _receiptFooter(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 25,
        ),
        Row(
          children: <Widget>[
            Container(alignment: Alignment.centerLeft, child: Text('Total')),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Container(
                alignment: Alignment.centerRight,
                child: Text(
                  (r"$" + cartCost().toStringAsFixed(2)),
                ))
          ],
        ),
      ],
    );
  }

  Widget _btnOrder(BuildContext context) {
    return Container(
      width: 250,
      child: Card(
        color: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: FlatButton(
          child: Text('Order',
              style: TextStyle(color: Colors.grey[900], fontSize: 20)),
          onPressed: () {
            return _showOrderRequest(widget.aJS.id);
          },
        ),
      ),
    );
  }

  Widget _myReceipt(BuildContext context) {
    return ListView.builder(
      itemCount: cartSize(),
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(getPO(index).myProduct.name),
              subtitle: Text(
                getProduct(index).priceEstimate +
                    ' x ' +
                    getPO(index).myQuantity.toString(),
              ),
              trailing: Text(getPO(index).getCost().toStringAsFixed(2)),
            ),
          ],
        );
      },
    );
  }

  calcSingleCost(int quantity, double price) {
    double cost = 0;
    cost = quantity * price;
    return cost;
  }

  Future<void> _showOrderRequest(int aJS) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confim status in home menu'),
          content: Container(
            height: 200,
            width: 100,
            child: FutureBuilder(
              future: createAndSetOrder(aJS),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data[index]),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Container(
                  height: 60.0,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home', (Route<dynamic> route) => false);
                clearCart();
              },
            ),
          ],
        );
      },
    );
  }
}
