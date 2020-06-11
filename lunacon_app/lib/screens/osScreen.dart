import 'package:flutter/material.dart';
import 'package:lunacon_app/screens/cartScreen.dart';
import 'package:lunacon_app/data/network.dart';
import 'package:lunacon_app/models/product.dart';
import 'package:lunacon_app/components/dialogueGeneric.dart';
import 'package:lunacon_app/data/cart_module.dart';
import 'dart:math';

// Future<Product> futureProduct;
Future<List<Product>> futureProductList;
List<Product> loadedProducts;

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
                  clearCart();
                  Navigator.pop(context, '/home');
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
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: _myListView(context),
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
                    color: Colors.amber,
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
                              builder: (context) => new CartScreen(),
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
    // GRID TILES RELATIVE SO SCREEN SIZE
    var size = MediaQuery.of(context).size;
    final double cSquared = sqrt(pow(size.width, 2) + pow(size.width, 2)) ; 
    print("the ratio is: " + cSquared.toStringAsFixed(2));
    int itemsInRow;

    final double itemHeight =
        (size.height - 5 * AppBar().preferredSize.height) / 2;
    final double itemWidth = size.width / 2;



    if (cSquared<1000){
      itemsInRow = 2;
    }else if (cSquared > 1000){
      itemsInRow = 3;
    }

    return FutureBuilder<List<Product>>(
        future: futureProductList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            loadedProducts = snapshot.data;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: itemsInRow,
                childAspectRatio:  (itemWidth / itemHeight),
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ProductCard(
                    aProduct: snapshot.data[index], index: index);
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
  Color aBtnColor;

  @override
  void initState() {
    super.initState();
    isSelected = false;
    aCardColor = Colors.white;
    aTextColor = Colors.grey[900];
    aBtnColor = Colors.grey;
  }

  void resetBtnColors() {
    setState(() {
      aBtnColor = Colors.grey;
    });
  }

  void _toggleSelection() {
    setState(() {
      if (isSelected == false) {
        isSelected = true;
        aBtnColor = Colors.blue;
        addToCart(theProduct);
      } else {
        isSelected = false;
        aBtnColor = Colors.grey;
        removeFromCart(theProduct);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Card(
            elevation: 5,
            color: aCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                          'Amount: ' + widget.aProduct.numInPack.toString(),
                          style: TextStyle(color: aTextColor, fontSize: 12)),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 75, 0),
                      child: Divider(
                        color: Colors.grey,
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    alignment: Alignment.centerLeft,
                    child: Text(r"$" + widget.aProduct.priceEstimate,
                        style: TextStyle(color: aTextColor, fontSize: 15)),
                  ),
                  SizedBox(
                    height: 3,
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 15,
          width: 50,
          height: 50,
          child: checkButton(context),
        ),
      ],
    );
  }

  Widget checkButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: aBtnColor,
      child: Icon(
        Icons.check,
        size: 20,
      ),
      onPressed: _toggleSelection,
    );
  }
}
