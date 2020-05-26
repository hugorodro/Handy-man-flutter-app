import 'package:flutter/material.dart';
import 'package:lunacon_app/main.dart';
import 'package:lunacon_app/models/jobsite.dart';
import 'package:lunacon_app/models/product.dart';
import 'package:lunacon_app/network.dart';

class ConfirmationScreen extends StatefulWidget {
  final JobSite aJS;
  final List<Product> receiptProducts;
  final List<int> receiptQuantities;

  ConfirmationScreen({this.aJS, this.receiptQuantities, this.receiptProducts});

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  double total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue[50],
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                color: Colors.blue,
                iconSize: 40,
                padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context, '/home');
                },
              ),
            ),
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 10,
              child: Container(
                width: 350,
                height: 500,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.blue, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text('Hugo Rodriguez')),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Container(
                                alignment: Alignment.centerRight,
                                child: Text(widget.aJS.name)),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(height: 1, color: Colors.blue),
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: _myReceipt(context),
                            )),
                        Container(height: 1, color: Colors.blue),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text('Total')),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Container(
                                alignment: Alignment.centerRight,
                                child: Text(addCosttoTotal(
                                    widget.receiptQuantities,
                                    widget.receiptProducts))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(flex: 1, child: Container()),
            Container(
              height: 150.0,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.blue, Colors.blue[100]]),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.65),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(40.0),
                    topRight: const Radius.circular(40.0),
                  )),
              child: Center(
                child: Container(
                    width: 250,
                    child: Card(
                      elevation: 5,
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: FlatButton(
                        child: Text('Confirm',
                            style: TextStyle(
                                color: Colors.grey[900], fontSize: 20)),
                        onPressed: () {
                          sendOrders(widget.receiptQuantities,
                              widget.receiptProducts, widget.aJS.id);
                          print('what');
                          widget.receiptProducts.clear();
                          widget.receiptQuantities.clear();
                          Navigator.pushNamed(context, '/home');
                        },
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _myReceipt(BuildContext context) {
    return ListView.builder(
      itemCount: widget.receiptProducts.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(widget.receiptProducts[index].name),
              subtitle: Text(
                widget.receiptProducts[index].price +
                    ' x ' +
                    widget.receiptQuantities[index].toString(),
              ),
              trailing: Text(calcSingleCost(widget.receiptQuantities[index],
                      double.parse(widget.receiptProducts[index].price))
                  .toString()),
            ),
          ],
        );
      },
    );
  }

  addCosttoTotal(List<int> aQuantityList, List<Product> aProductList) {
    for (var i = 0; i < aQuantityList.length; i++) {
      total = total +
          calcSingleCost(aQuantityList[i], double.parse(aProductList[i].price));
    }
    return total.toStringAsFixed(2);
  }

  calcSingleCost(int quantity, double price) {
    double cost = 0;
    cost = quantity * price;
    return cost;
  }

  sendOrders(aQuantityList, aProductList, aJS) {
    for (var i = 0; i < aQuantityList.length; i++) {
      createOrder(aProductList[i].id, aQuantityList[i], aJS, authToken.id);
    }
  }
}
