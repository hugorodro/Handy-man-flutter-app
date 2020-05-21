// import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lunacon_app/main.dart';
import 'package:lunacon_app/screens/cartScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:lunacon_app/models/product.dart';
import 'dart:convert';

// Future<Product> futureProduct;
Future<List<Product>> futureProductList;
List<Product> loadedProducts;
List<Product> selectedProducts = [];
List<int> listofProductIndecies = [];

class OfficeSupplyScreen extends StatefulWidget {
  OfficeSupplyScreen({Key key}) : super(key: key);

  @override
  _OfficeSupplyScreenState createState() => _OfficeSupplyScreenState();
}

class _OfficeSupplyScreenState extends State<OfficeSupplyScreen> {
  @override
  void initState() {
    super.initState();
    // futureProduct = fetchProduct();
    futureProductList = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white12,
        leading: IconButton(iconSize: 40,
          icon: Icon(Icons.arrow_back, color: cobaltColor,),
          onPressed: () {
            Navigator.pop(context, '/home');
          },
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                width: 550,
                child: _myListView(context),
              ),
            ),
            Container(
                width: 200,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: FlatButton(
                  child: Text("Want something else? Request approval here",
                      style: TextStyle(fontSize: 15)),
                  onPressed: _launchURL,
                )),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
              width: 250,
              child: Card(
                color: cobaltColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: FlatButton(
                  child: Text('Add Quantity',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  onPressed: () {
                    if (selectedProducts.length != 0) {
                      return Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => new CartScreen(
                            selectedProducts: selectedProducts,
                          ),
                          // Pass the arguments as part of the RouteSettings. The
                          // DetailScreen reads the arguments from these settings.
                        ),
                      );
                    } else {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Oops!'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                      "You can't go on unless you choose a product."),
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
            ),
          ],
        ),
      ),
    );
  }
}

Widget _myListView(BuildContext context) {
  return FutureBuilder<List<Product>>(
      future: futureProductList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          loadedProducts = snapshot.data;
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child:
                    ProductCard(aProduct: snapshot.data[index], index: index),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      });
}

class ProductCard extends StatefulWidget {
  final Product aProduct;
  final int index;

  ProductCard({@required this.aProduct, this.index});

  @override
  _ProductCardState createState() => _ProductCardState(theProduct: aProduct);
}

class _ProductCardState extends State<ProductCard> {
  final Product theProduct;
  _ProductCardState({@required this.theProduct});

  bool isSelected;
  Color aCardColor;
  Color aTextColor;

  @override
  void initState() {
    super.initState();
    isSelected = false;
    aCardColor = Colors.white;
    aTextColor = cobaltColor;
  }

  void _toggleSelection() {
    setState(() {
      if (isSelected == false) {
        isSelected = true;
        aCardColor = cobaltColor;
        aTextColor = Colors.white;
        selectedProducts.add(theProduct);
        print(selectedProducts);
      } else {
        isSelected = false;
        aCardColor = Colors.white;
        aTextColor = cobaltColor;
        selectedProducts.remove(theProduct);
        print(selectedProducts);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: aCardColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: cobaltColor, width: 2)),
      child: FlatButton(
        child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            title: Text(widget.aProduct.name,
                style: TextStyle(color: aTextColor, fontSize: 20)),
            subtitle: Container(
              child: Row(
                children: <Widget>[
                  Text(
                      widget.aProduct.specs +
                          ', # in Pack ' +
                          widget.aProduct.numInPack.toString(),
                      style: TextStyle(color: aTextColor, fontSize: 10)),
                ],
              ),
            ),
            trailing: Text(widget.aProduct.price,
                style: TextStyle(color: aTextColor, fontSize: 15))),
        onPressed: _toggleSelection,
      ),
    );
  }
}

Future<List<Product>> fetchProducts() async {
  final productsListAPIUrl = productsAPIstr;
  final response = await http.get(
    productsListAPIUrl,
    headers: {HttpHeaders.authorizationHeader: "Token " + authToken.tokenStr},
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    print(jsonResponse);
    print('yes');
    print(jsonResponse.length);
    return jsonResponse.map((job) => new Product.fromJson(job)).toList();
  } else {
    print('meh');
    throw Exception('Failed to load jobs from API');
  }
}

_launchURL() async {
  const url =
      'https://forms.office.com/Pages/ResponsePage.aspx?id=d5b8boJWQEe7CgaWFyi5oRfYc-naQEZAmEhCmNQzUFNUQkZRMjRLNDNVNlo4QzVSWjZDSEtZTDgxNS4u';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
