import 'package:flutter/material.dart';
import 'package:lunacon_app/main.dart';
import 'package:lunacon_app/screens/cartScreen.dart';
import 'package:lunacon_app/network.dart';
import 'package:lunacon_app/models/product.dart';
import 'package:lunacon_app/components/dialogueGeneric.dart';

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
      body: Column(
        children: <Widget>[
          Expanded(flex: 1, child: Container()),
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              iconSize: 40,
              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
              icon: Icon(
                Icons.arrow_back,
                color: cobaltColor,
              ),
              onPressed: () {
                Navigator.pop(context, '/home');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: _myListView(context),
            ),
          ),
          Container(
              height: 220.0,
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
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(40.0),
                    topRight: const Radius.circular(40.0),
                  )),
              child: Column(
                children: <Widget>[
                  Expanded(flex: 1, child: Container()),
                  Container(
                      width: 200,
                      child: FlatButton(
                        child: Text(
                          "Want something else? Request approval here",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[900]),
                        ),
                        onPressed: launchURL,
                      )),
                  SizedBox(height: 10),
                  Container(
                    width: 250,
                    child: Card(
                      elevation: 5,
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: FlatButton(
                        child: Text('Add Quantity',
                            style: TextStyle(
                                color: Colors.grey[900], fontSize: 20)),
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
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return GenericAlert(
                                  aTitle: 'Oops',
                                  aMsg: 'Select at least one product',
                                  btnText: 'OK',
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(flex: 3, child: Container()),
                ],
              )),
        ],
      ),
    );
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
                return Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      child: ProductCard(
                          aProduct: snapshot.data[index], index: index),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return CircularProgressIndicator();
        });
  }
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
      elevation: 5,
      color: aCardColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: cobaltColor, width: 2)),
      child: FlatButton(
        child: ListTile(
            title: Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.aProduct.name,
                      style: TextStyle(
                          color: aTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(widget.aProduct.specs,
                      style: TextStyle(color: aTextColor, fontSize: 13)),
                  Text('# in Pack ' + widget.aProduct.numInPack.toString(),
                      style: TextStyle(color: aTextColor, fontSize: 13)),
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
