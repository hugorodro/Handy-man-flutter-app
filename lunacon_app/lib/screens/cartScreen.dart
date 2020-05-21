import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunacon_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:lunacon_app/models/jobsite.dart';
import 'dart:convert';
import 'package:lunacon_app/models/product.dart';
import 'package:lunacon_app/models/order.dart';
import 'package:lunacon_app/screens/osScreen.dart';

List<int> quantityList;
Future<List<JobSite>> futureJobSiteList;

changeQuantity(aQuantity, index) {
  quantityList[index] = aQuantity;
}

class CartScreen extends StatefulWidget {
  CartScreen({this.selectedProducts});
  final List<Product> selectedProducts;
  @override
  _CartScreenState createState() =>
      _CartScreenState(productsList: selectedProducts);
}

class _CartScreenState extends State<CartScreen> {
  final List<Product> productsList;
  _CartScreenState({@required this.productsList});

  int selectedJS;
  bool isJSselected = false;

  @override
  void initState() {
    super.initState();
    quantityList = new List(productsList.length);
    for (var i = 0; i < productsList.length; i++) {
      quantityList[i] = 0;
      print(quantityList);
    }
    futureJobSiteList = fetchJobSites();
    selectedJS = 0;
  }

  sendOrders() {
    for (var i = 0; i < quantityList.length; i++) {
      createOrder(selectedProducts[i].id, quantityList[i], selectedJS, authToken.id);
    }
  }

  setSelectedJS(int value) {
    setState(() {
      isJSselected = true;
      selectedJS = value;
    });
  }

  displayJobSites() {
    showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Jobsite'),
          content: Container(
            height: 150,
            width: 100,
            child: FutureBuilder<List<JobSite>>(
                future: futureJobSiteList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          title: Text(snapshot.data[index].name),
                          value: index + 1,
                          groupValue: selectedJS,
                          onChanged: (value) {
                            setSelectedJS(value);
                            Navigator.of(context).pop();
                            displayJobSites();
                            print(selectedJS);
                          },
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return widget.selectedProducts == null
        ? new OfficeSupplyScreen()
        : new Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white10,
              leading: IconButton(
                icon: Image.asset('images/backarrow.png'),
                onPressed: () {
                  Navigator.pop(context, '/home');
                },
              ),
            ),
            body: Center(
              child: Container(
                width: 550,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: ListView.builder(
                          itemCount: widget.selectedProducts.length,
                          itemBuilder: (context, index) {
                            return Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: ProductCard(
                                    anIndex: index,
                                    aProduct: widget.selectedProducts[index]));
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 100,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                      decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius:
                              BorderRadius.all(const Radius.circular(15.0)),
                          border: Border.all(color: cobaltColor)),
                      child: FlatButton(
                        child: Text(
                          'Select Location',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: cobaltColor, fontSize: 15),
                        ),
                        onPressed: () {
                          displayJobSites();
                        },
                      ),
                      // child: TextField(
                      //   textAlign: TextAlign.center,
                      //   decoration: InputDecoration(hintText: 'Site/Dept #'),
                      // ),
                    ),
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        color: cobaltColor,
                        borderRadius:
                            BorderRadius.all(const Radius.circular(15.0)),
                      ),
                      child: FlatButton(
                        child: Text('Order',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        onPressed: () {
                          if (isJSselected == true) {
                            sendOrders();
                            widget.selectedProducts.clear();
                            Navigator.pushNamed(context, '/home');
                          } else {
                            showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Oops!'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            "You can't go on unless you select a location."),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Try agian'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}

Future<List<JobSite>> fetchJobSites() async {
  final response = await http.get(
    jobSiteAPIstr,
    headers: {HttpHeaders.authorizationHeader: "Token " + authToken.tokenStr},
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    print(jsonResponse);
    print('yes');
    print(jsonResponse.length);
    return jsonResponse.map((job) => new JobSite.fromJson(job)).toList();
  } else {
    print('meh');
    throw Exception('Failed to load jobs from API');
  }
}

Future<Order> createOrder(int aProductID, int aQuantity, int aJobSiteID, dynamic aUserID) async {
  final http.Response response = await http.post(
    ordersAPIstr,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Token " + authToken.tokenStr,
    },
    body: jsonEncode(<String, dynamic>{
      'quantity': aQuantity.toString(),
      'date': DateTime.now().toString(),
      'fulfilled': 'false',
      'user': aUserID.toString(),
      'product': aProductID.toString(),
      'jobSite': aJobSiteID.toString(),
    }),
  );

  if (response.statusCode == 201) {
    print('order was sent');
    return Order.fromJson(json.decode(response.body));
  } else {
    print('try again bih');
    throw Exception('Failed to create order.');
  }
}

class ProductCard extends StatefulWidget {
  final Product aProduct;
  final int anIndex;

  ProductCard({@required this.aProduct, this.anIndex});

  @override
  _ProductCardState createState() =>
      _ProductCardState(indexForQuantityChanges: anIndex);
}

class _ProductCardState extends State<ProductCard> {
  // final TextEditingController _controller = TextEditingController();
  final int indexForQuantityChanges;

  _ProductCardState({@required this.indexForQuantityChanges});

  // @override
  // void initState() {
  //   super.initState();
  //   _controller.addListener(() {
  //     int parserdQuantity = int.parse(_controller.text);
  //     changeQuantity(parserdQuantity, indexForQuantityChanges);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: cobaltColor, width: 2)),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        title: Text(widget.aProduct.name,
            style: TextStyle(color: cobaltColor, fontSize: 20)),
        subtitle: Container(
          child: Row(
            children: <Widget>[
              Text(
                  widget.aProduct.specs +
                      ', Amount ' +
                      widget.aProduct.numInPack.toString() +
                      widget.aProduct.price,
                  style: TextStyle(color: cobaltColor, fontSize: 10)),
            ],
          ),
        ),
        trailing: Container(
          height: 40,
          width: 40,
          padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
          child: TextFormField(
            // controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              changeQuantity(int.parse(value), indexForQuantityChanges);
            },
            maxLength: 2,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '0',
                fillColor: cobaltColor,
                counterText: ''),
          ),
        ),
      ),
    );
  }
}

class Spacer extends StatelessWidget {
  final int aFlex;
  Spacer({@required this.aFlex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: aFlex,
      child: Container(
        width: 500,
      ),
    );
  }
}
