import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flushbar/flushbar.dart';

import 'package:lunacon_app/main.dart';

//Models
import 'package:lunacon_app/models/product.dart';

//Data
import 'package:lunacon_app/data/network.dart';
import 'package:lunacon_app/data/catalogue.dart';
import 'package:lunacon_app/data/cart_module.dart';

//Screens
import 'package:lunacon_app/screens/cartScreen.dart';

//Components
import 'package:lunacon_app/components/productInfo.dart';
import 'package:lunacon_app/components/dialogueGeneric.dart';
import 'package:lunacon_app/components/btnCartIcon.dart';

class CatalogScreen extends StatefulWidget {
  CatalogScreen({Key key}) : super(key: key);

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final TextEditingController _searchInput = TextEditingController();
  Future<List<Product>> futureProductList;
  bool isSorted;
  String _cartIndicator;

  @override
  void initState() {
    super.initState();
    _cartIndicator = numItemsInCart();
    isSorted = false;
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

  void _selectProduct(Product aProduct) {
    setState(() {
      addToCart(aProduct);
      _cartIndicator = numItemsInCart();
    });
  }

  void removeProductFromScreen(Product aProduct) {
    setState(() {
      removeFromCart(aProduct);
      _cartIndicator = numItemsInCart();
    });
  }

  void showFlushBar(BuildContext context, Product aProduct) {
    Flushbar(
      margin:
          EdgeInsets.fromLTRB(10, 10, 10, 2 * AppBar().preferredSize.height),
      padding: EdgeInsets.all(15),
      maxWidth: 300,
      borderRadius: 10,
      message: "One " + aProduct.name + " to your cart!",
      mainButton: FlatButton(
        child: Text(
          'Undo',
          style: TextStyle(color: Colors.blueAccent),
        ),
        onPressed: () {
          removeProductFromScreen(aProduct);
        },
      ),
      duration: Duration(seconds: 3),

      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    )..show(context);
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
            CartIconButton(
              myCartIndicator: _cartIndicator,
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
                  child: _searchBar(context),
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
                _btnRequest(context),
                SizedBox(width: 10),
                _btnCart(context),
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

    final double cSquared = sqrt(pow(screenWidth, 2) + pow(screenHeight, 2));
    print("the ratio is: " + cSquared.toStringAsFixed(2));
    print("screen width: " + screenWidth.toString());
    print("screen height: " + screenHeight.toString());

    int itemsInRow;
    double itemHeight;
    double itemWidth;
    // ios
    // phone
    if (screenWidth < 500) {
      // small phone
      if (screenHeight < 700) {
        itemsInRow = 1;
        itemWidth = screenWidth;
        itemHeight = (screenHeight - 2 * AppBar().preferredSize.height) / 3;

        // large phone
      } else {
        itemsInRow = 1;
        itemWidth = screenWidth / 1;
        itemHeight = (screenHeight - 2 * AppBar().preferredSize.height) / 3.5;
      }
      // tablet
    } else {
      itemsInRow = 2;
      itemWidth = screenWidth / 2;
      itemHeight = (screenHeight - 2 * AppBar().preferredSize.height) / 5;
    }

    return FutureBuilder<List<Product>>(
        future: fetchFutureList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: itemsInRow,
                childAspectRatio: ((itemWidth) / itemHeight),
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    _buildProductCard(
                      context,
                      snapshot.data[index],
                      snapshot.data[index].id,
                    ),
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

  Widget _buildProductCard(
    BuildContext context,
    Product aProduct,
    int anIndex,
  ) {
    Color aCardColor = Colors.white;
    double imageRadius = 40;
    Image anImage = Image.asset('images/LoginLogo.png');

    return Expanded(
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
              Expanded(
                child: Container(
                  child: ProductInfo(
                    myImage: anImage,
                    myProduct: aProduct,
                    myImageRadius: imageRadius,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Card(
                  elevation: 5,
                  color: Colors.blue,
                  child: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    color: Colors.white,
                    onPressed: () {
                      _selectProduct(aProduct);
                      showFlushBar(context, aProduct);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return Container(
      height: 60,
      width: 300,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
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
    );
  }

  Widget _btnRequest(BuildContext context) {
    return Container(
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
            style: TextStyle(fontSize: 13, color: Colors.grey[900]),
          ),
          onPressed: launchURL,
        ),
      ),
    );
  }

  Widget _btnCart(BuildContext context) {
    return Container(
      width: 150,
      child: Card(
        elevation: 5,
        color: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: FlatButton(
          child: Text('Cart',
              style: TextStyle(color: Colors.grey[900], fontSize: 20)),
          onPressed: () {
            if (cartSize() != 0) {
              return Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()))
                  .then((value) {
                setState(() {
                  // refresh state of Page1
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
    );
  }
}
