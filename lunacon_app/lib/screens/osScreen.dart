import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// import 'package:lunacon_app/screens/cartScreen.dart';
import 'package:lunacon_app/data/network.dart';
import 'package:lunacon_app/models/product.dart';
import 'package:lunacon_app/components/dialogueGeneric.dart';
import 'package:lunacon_app/data/catalogue.dart';
import 'package:lunacon_app/data/cart_module.dart';
import 'package:lunacon_app/screens/cartScreen.dart';

// Future<Product> futureProduct;

class OfficeSupplyScreen extends StatefulWidget {
  OfficeSupplyScreen({Key key}) : super(key: key);

  @override
  _OfficeSupplyScreenState createState() => _OfficeSupplyScreenState();
}

class _OfficeSupplyScreenState extends State<OfficeSupplyScreen> {
  final TextEditingController _searchInput = TextEditingController();
  Future<List<Product>> futureProductList;
  bool isSorted;
  String cartIndicator;

  @override
  void initState() {
    super.initState();
    // futureProduct = fetchProduct();
    isSorted = false;
    cartIndicator = numItemsInCart();
  }

  Future<List<Product>> fetchFutureList() async {
    if (isSorted == false) {
      return getAlpha();
    } else {
      return searchSort(_searchInput.text);
    }
  }

  

  void searchCatalogue() {
    if (_searchInput.text.length > 0) {
      setState(() {
        isSorted = true;
      });
    } else {
      setState(() {
        isSorted = false;
      });
    }
  }

  void updateCartIndicator() {
    setState(() {
      cartIndicator = numItemsInCart();
    });
  }

  void _selectProduct(Product aProduct) {
    addToCart(aProduct);
    updateCartIndicator();
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
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              iconSize: 25,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Container(
                  child: Text(
                'Catalog',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              )),
            ),
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (cartSize() != 0) {
                        return Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartScreen()))
                            .then((value) {
                          setState(() {
                            // refresh state of Page1
                            updateCartIndicator();
                          });
                        });
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
                Positioned(
                  width: 15,
                  height: 15,
                  top: 5,
                  right: 5,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cartIndicator,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: _myListView(context, futureProductList),
                ),
                Positioned(
                  bottom: 15 + MediaQuery.of(context).viewInsets.bottom * .7,
                  left: (MediaQuery.of(context).size.width * .5) - 150,
                  child: Container(
                    height: 60,
                    width: 300,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            width: 200,
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(30, 0, 15, 0),
                            child: TextField(
                              controller: _searchInput,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[900],
                              ),
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                border: InputBorder.none,
                                hintText: 'Search here',
                                hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 15,
                                ),
                              ),
                              onChanged: (value) {
                                searchCatalogue();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: VerticalDivider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                searchCatalogue();
                              },
                              icon: Icon(
                                Icons.search,
                                color: Colors.blue,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 2 * AppBar().preferredSize.height,
            decoration: BoxDecoration(
              color: Colors.blue,
              // gradient: LinearGradient(
              //     begin: Alignment.bottomCenter,
              //     end: Alignment.topCenter,
              //     colors: [Colors.blue, Colors.blue[100]]),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.65),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // cfhanges position of shadow
                ),
              ],
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
                        color: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
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
                    color: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FlatButton(
                      child: Text('Cart',
                          style:
                              TextStyle(color: Colors.grey[900], fontSize: 20)),
                      onPressed: () {
                        if (cartSize() != 0) {
                          return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartScreen()))
                              .then((value) {
                            setState(() {
                              // refresh state of Page1
                              updateCartIndicator();
                            });
                          });
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

  Widget _myListView(BuildContext context, Future<List<Product>> alist) {
    // GRID TILES RELATIVE SO SCREEN SIZE

    var size = MediaQuery.of(context).size;
    final double cSquared = sqrt(pow(size.width, 2) + pow(size.width, 2));
    print("the ratio is: " + cSquared.toStringAsFixed(2));
    int itemsInRow;

    double itemHeight = (size.height - 5 * AppBar().preferredSize.height) / 3;
    double itemWidth = size.width / 2;

    print("screen width: " + size.width.toString());
    print("screen height: " + size.height.toString());

    // ios
    // phone
    if (size.width < 500) {
      // small phone
      if (size.height < 700) {
        itemsInRow = 1;
        itemWidth = size.width;
        itemHeight = (size.height - 5 * AppBar().preferredSize.height) / 2;

        // large phone
      } else {
        itemsInRow = 1;
        itemWidth = size.width / 1;
        itemHeight = (size.height - 5 * AppBar().preferredSize.height) / 2.8;
      }
      // tablet
    } else {
      itemsInRow = 2;
      itemWidth = size.width / 2;
      itemHeight = (size.height - 5 * AppBar().preferredSize.height) / 5;
    }

    return FutureBuilder<List<Product>>(
        future: fetchFutureList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: itemsInRow,
                childAspectRatio: (itemWidth / itemHeight),
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    buildProductCard(
                        context, snapshot.data[index], snapshot.data[index].id),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Container(
            height: 60.0,
            child: Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget buildProductCard(BuildContext context, Product aProduct, int anIndex) {
    Color aCardColor = Colors.white;
    Color aTextColor = Colors.grey[900];
    double imageRadius = 40;

    return Container(
      height: 175,
      child: Card(
        elevation: 0,
        color: aCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: CircleAvatar(
                  radius: imageRadius + 2,
                  backgroundColor: Colors.blueGrey[300],
                  child: CircleAvatar(
                      radius: imageRadius,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.asset(
                          'images/LoginLogo.png',
                        ),
                      )),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text(aProduct.name,
                          style: TextStyle(
                              color: aTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text(aProduct.specs,
                          style: TextStyle(color: aTextColor, fontSize: 12)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text('Amount: ' + aProduct.numInPack.toString(),
                          style: TextStyle(color: aTextColor, fontSize: 12)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text(r"$" + aProduct.priceEstimate,
                          style: TextStyle(color: aTextColor, fontSize: 15)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Card(
                  color: Colors.blue,
                  child: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    color: Colors.white,
                    onPressed: () => _selectProduct(aProduct),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class MyGridView extends StatefulWidget {
//   @override
//   _MyGridViewState createState() => _MyGridViewState();
// }

// class _MyGridViewState {
//   Future<List<Product>> alist;

//   @override
//   void initState() {
//     super.initState();
//     alist = alphaSort();

//   }
// }
