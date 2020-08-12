import 'package:flutter/material.dart';
import 'package:lunacon_app/models/jobsite.dart';
import 'package:lunacon_app/models/product.dart';
// import 'package:lunacon_app/models/order.dart';
import 'package:lunacon_app/screens/confirmationScreen.dart';
import 'package:lunacon_app/data/network.dart';
import 'package:lunacon_app/data/cart_module.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:lunacon_app/components/btnCartIcon.dart';

Future<List<JobSite>> futureJobSiteList;
List<JobSite> aJobSiteList = [];
List<Product> productReceiptlist = [];

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int selectedJS;
  bool isJSselected = false;
  String btnLocationtxt;
  String _cartIndicator;

  @override
  void initState() {
    super.initState();
    btnLocationtxt = "Location";
    futureJobSiteList = fetchJobSites();
    selectedJS = 0;
    _cartIndicator = numItemsInCart();
  }

  void updateCartIndicator() {
    setState(() {
      _cartIndicator = numItemsInCart();
    });
  }

  void setSelectedJS(int value) {
    setState(() {
      isJSselected = true;
      selectedJS = value;
      btnLocationtxt = aJobSiteList[value - 1].name;
    });
  }

  void removeProductFromScreen(Product aProduct) {
    setState(() {
      removeFromCart(aProduct);
    });
  }

  void displayJobSites() {
    showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Jobsite'),
          content: Container(
            height: 200,
            width: 100,
            child: FutureBuilder<List<JobSite>>(
                future: futureJobSiteList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    aJobSiteList = snapshot.data;
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
                  return SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator());
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

  void showError(String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Oops!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Try agian',
              ),
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
    return new Scaffold(
        backgroundColor: Colors.white,
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
                  'Cart',
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
            Expanded(child: _myListView(context)),
            SizedBox(
              height: 0,
            ),
            // Container(
            //   color: Colors.transparent,
            //   padding: EdgeInsets.all(15),
            //   height: 90,
            //   width: 330,
            //   child: Card(
            //     elevation: 0,
            //     color: Colors.grey[300],
            //     child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: <Widget>[
            //           Padding(
            //             padding: const EdgeInsets.all(5.0),
            //             child: Text('Total Cost:',
            //                 style: TextStyle(
            //                     color: Colors.grey[900],
            //                     fontSize: 18,
            //                     fontWeight: FontWeight.w500)),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.all(5.0),
            //             child: Text(cartCost().toString(),
            //                 style: TextStyle(
            //                     color: Colors.grey[900],
            //                     fontSize: 18,
            //                     fontWeight: FontWeight.w500)),
            //           ),
            //         ]),
            //   ),
            // ),
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
              child: Row(
                children: <Widget>[
                  Expanded(flex: 1, child: Container()),
                  Container(
                    width: 150,
                    child: Card(
                      elevation: 5,
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FlatButton(
                        child: Text(
                          btnLocationtxt,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.grey[900], fontSize: 15),
                        ),
                        onPressed: () {
                          displayJobSites();
                        },
                      ),
                    ),
                  ),
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
                        child: Text('Confirm',
                            style: TextStyle(
                                color: Colors.grey[900], fontSize: 20)),
                        onPressed: () {
                          if (isJSselected != true) {
                            showError(
                                "You can't go on unless you select a location.");
                          } else {
                            // sendOrders();
                            if (allPOsHaveQuantities() == true) {
                              int jsindex = selectedJS - 1;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => new ConfirmationScreen(
                                    aJS: aJobSiteList[jsindex],
                                  ),
                                ),
                              );
                            } else {
                              showError(
                                  "Make sure you aren't ordering something with a count of 0.");
                            }
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
        ));
  }

  // Widget _myCarouselView(BuildContext context) {
  //   return CarouselSlider.builder(
  //     options: CarouselOptions(
  //       height: MediaQuery.of(context).size.height * .6,
  //       enableInfiniteScroll: false,
  //     ),
  //     itemCount: cartSize(),
  //     itemBuilder: (context, index) {
  //       return CarouselCard(anIndex: index, aProduct: getProduct(index));
  //     },
  //   );
  // }

  Widget _myListView(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
      scrollDirection: Axis.vertical,
      itemCount: cartSize(),
      itemBuilder: (context, index) {
        if (MediaQuery.of(context).size.width > 500) {
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .005),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                            child: ProductCardInfo(
                                anIndex: index, aProduct: getProduct(index)),
                          )),
                      Expanded(
                          flex: 3, child: _cartInteractions(context, index))
                    ],
                  ),
                ),
                Divider(
                  height: 3,
                  color: Colors.grey[500],
                )
              ],
            ),
          );
        } else {
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .005),
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: ProductCardInfo(
                        anIndex: index, aProduct: getProduct(index))),
                Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: _cartInteractions(context, index)),
                Divider(
                  height: 3,
                  color: Colors.grey[500],
                )
              ],
            ),
          );
        }
      },
    );
  }

  Widget _cartInteractions(BuildContext context, int productIndex) {
    String quantityStr = getPO(productIndex).myQuantity.toString();

    void _addtoOrder() {
      setState(() {
        getPO(productIndex).add();
        quantityStr = getPO(productIndex).myQuantity.toString();
      });
    }

    void _subtractFromOrder() {
      setState(() {
        getPO(productIndex).remove();
        quantityStr = getPO(productIndex).myQuantity.toString();
      });
    }

    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: IconButton(
                    color: Colors.red,
                    icon: Icon(
                      Icons.remove,
                      size: 25,
                    ),
                    onPressed: () {
                      _subtractFromOrder();
                      updateCartIndicator();
                      print("subtract");
                    },
                  ),
                ),
                Container(
                  width: 60,
                  height: 45,
                  child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.grey[300],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          quantityStr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 20,
                          ),
                        ),
                      )),
                ),
                Container(
                  child: IconButton(
                      color: Colors.green,
                      icon: Icon(
                        Icons.add,
                        size: 25,
                      ),
                      onPressed: () {
                        _addtoOrder();
                        updateCartIndicator();
                        print("add");
                      }),
                ),
              ],
            ),
          ),
          Container(
              child: Text(
                  r'$' + getPO(productIndex).getCost().toStringAsFixed(2),
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 18,
                      fontWeight: FontWeight.w500))),
          Container(
            // alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.remove_shopping_cart),
              onPressed: () {
                removeProductFromScreen(getProduct(productIndex));
                updateCartIndicator();
                print('remove');
              },
            ),
          )
        ],
      ),
    );
  }
}

class ProductCardInfo extends StatelessWidget {
  final Product aProduct;
  final int anIndex;

  ProductCardInfo({@required this.aProduct, this.anIndex});
  @override
  Widget build(BuildContext context) {
    double imageRadius;

    if (MediaQuery.of(context).size.width > 500) {
      imageRadius = 50;
    } else {
      imageRadius = 35;
    }

    return Column(
      children: <Widget>[
        Container(
          height: 175,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                  child: CircleAvatar(
                    radius: imageRadius + 2,
                    backgroundColor: Colors.blueGrey[300],
                    child: CircleAvatar(
                        radius: imageRadius + 2,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: Image.asset(
                            'images/LoginLogo.png',
                          ),
                        )),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(aProduct.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 5),
                    Text(aProduct.specs,
                        style: TextStyle(color: Colors.grey, fontSize: 15)),
                    SizedBox(height: 5),
                    Text('Amount: ' + aProduct.numInPack.toString(),
                        style: TextStyle(color: Colors.grey, fontSize: 15)),
                    SizedBox(height: 5),
                    Text(r'$' + aProduct.priceEstimate,
                        style: TextStyle(color: Colors.grey, fontSize: 15))
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
