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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context, '/home');
                  selectedProducts.clear();
                  listofProductIndecies.clear();
                },
              ),
            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
            Container(
              width: 200,
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Products',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
            IconButton(
              onPressed: () {
                print("search");
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: _myListView(context),
            ),
          ),
          Container(
            height: 120.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              // gradient: LinearGradient(
              //     begin: Alignment.bottomCenter,
              //     end: Alignment.topCenter,
              //     colors: [Colors.blue, Colors.blue[100]]),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.65),
              //     spreadRadius: 5,
              //     blurRadius: 7,
              //     offset: Offset(0, 3), // cfhanges position of shadow
              //   ),
              // ],
              // borderRadius: BorderRadius.only(
              //   topLeft: const Radius.circular(40.0),
              //   topRight: const Radius.circular(40.0),
              // )
            ),
            child: Row(
              children: <Widget>[
                Expanded(flex: 1, child: Container()),
                Container(
                    width: 150,
                    child: Card(
                        elevation: 5,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: FlatButton(
                          child: Text(
                            "Want something else?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[900]),
                          ),
                          onPressed: launchURL,
                        ))),
                SizedBox(width: 10),
                Container(
                  width: 150,
                  child: Card(
                    elevation: 5,
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FlatButton(
                      child: Text('Cart',
                          style:
                              TextStyle(color: Colors.grey[900], fontSize: 20)),
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
                Expanded(flex: 1, child: Container()),
              ],
            ),
          ),
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
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.9)),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: 175,
                      child: ProductCard(
                          aProduct: snapshot.data[index], index: index),
                    ),
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
    aTextColor = Colors.grey[900];
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
        aTextColor = Colors.grey[900];
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
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: FlatButton(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.aProduct.name,
                      style: TextStyle(
                          color: aTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.aProduct.specs,
                      style: TextStyle(color: aTextColor, fontSize: 12)),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      '# in Pack ' + widget.aProduct.numInPack.toString(),
                      style: TextStyle(color: aTextColor, fontSize: 12)),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(widget.aProduct.price,
                    style: TextStyle(color: aTextColor, fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.all(5),
              )
            ],
          ),
        ),
        onPressed: _toggleSelection,
      ),
    );
  }
}
