import 'package:flutter/material.dart';
import 'package:lunacon_app/models/jobsite.dart';
import 'package:lunacon_app/models/product.dart';
// import 'package:lunacon_app/models/order.dart';
import 'package:lunacon_app/screens/confirmationScreen.dart';
import 'package:lunacon_app/data/network.dart';
import 'package:lunacon_app/data/cart_module.dart';

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
  // List<Order> orderList = [];

  @override
  void initState() {
    super.initState();
    btnLocationtxt = "Loaction";
    futureJobSiteList = fetchJobSites();
    selectedJS = 0;
  }

  // confirmOrders() {
  //   for (var i = 0; i < quantityList.length; i++) {
  //     Order anOrder = new Order(
  //         product: selectedProducts[i].id,
  //         quantity: quantityList[i],
  //         date: DateTime.now().toString());
  //     orderList.add(anOrder);
  //   }
  // }

  setSelectedJS(int value) {
    setState(() {
      isJSselected = true;
      selectedJS = value;
      btnLocationtxt = aJobSiteList[value - 1].name;
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
    return new Scaffold(
        backgroundColor: Colors.grey[300],
        resizeToAvoidBottomInset: false,
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
                  'Cart',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 70,
            ),
            Expanded(child: _myCartView(context)),
            Container(
              child: FlatButton(
                child: Text('Clear cart'),
                onPressed: () {
                  setState(() {
                    clearCart();
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
                  Expanded(flex: 1, child: Container()),
                  Container(
                    width: 150,
                    child: Card(
                      elevation: 5,
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: FlatButton(
                        child: Text('Order',
                            style: TextStyle(
                                color: Colors.grey[900], fontSize: 20)),
                        onPressed: () {
                          if (isJSselected == true) {
                            // sendOrders();
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
                                      child: Text('Try agian',),
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
                  Expanded(flex: 1, child: Container()),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _myCartView(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: cartSize(),
      itemBuilder: (context, index) {
        return Row(
          children: <Widget>[
            SizedBox(
              width: 25,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ProductCard(anIndex: index, aProduct: getProduct(index)),
              ],
            ),
          ],
        );
      },
    );
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
  String quantityStr;

  _ProductCardState({@required this.indexForQuantityChanges});

  @override
  void initState() {
    super.initState();
    quantityStr = getPO(indexForQuantityChanges).myQuantity.toString();
  }

  void _addtoOrder() {
    setState(() {
      getPO(indexForQuantityChanges).add();
      quantityStr = getPO(indexForQuantityChanges).myQuantity.toString();
    });
  }

  void _subtractFromOrder() {
    setState(() {
      getPO(indexForQuantityChanges).remove();
      quantityStr = getPO(indexForQuantityChanges).myQuantity.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 400,
              width: 300,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          height: 150,
                          child: Image.asset('images/LoginLogo.png')),

                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          alignment: Alignment.bottomLeft,
                          child: Text(widget.aProduct.name,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(widget.aProduct.specs,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15)),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              'Amount: ' + widget.aProduct.numInPack.toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15)),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(r'$' + widget.aProduct.priceEstimate,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15)),
                        ),
                      ),
                      SizedBox(
                        width: 115,
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Counter: ' + quantityStr,
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                            ),
                          )),

                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Container(
                      //         height: 40,
                      //         width: 40,
                      //         child: TextFormField(
                      //           textAlign: TextAlign.center,
                      //           // controller: _controller,

                      //           keyboardType: TextInputType.number,
                      //           inputFormatters: <TextInputFormatter>[
                      //             WhitelistingTextInputFormatter.digitsOnly
                      //           ],
                      //           onChanged: (value) {
                      //             changeQuantity(int.parse(value),
                      //                 indexForQuantityChanges);
                      //           },
                      //           maxLength: 2,
                      //           style: TextStyle(fontSize: 20),
                      //           decoration: InputDecoration(
                      //               border: InputBorder.none,
                      //               hintText: '0',
                      //               fillColor: cobaltColor,
                      //               counterText: ''),
                      //         ),
                      //       ),
                      //       Container(
                      //         color: Colors.blue,
                      //         height: 1,
                      //         width: 25,
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
        Positioned(
          bottom: 25,
          right: 0,
          height: 100,
          width: 145,
          child: Row(
            children: <Widget>[
              FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.remove,
                  size: 20,
                ),
                onPressed: () {
                  _subtractFromOrder();
                  print("subtract");
                },
              ),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.add,
                    size: 20,
                  ),
                  onPressed: () {
                    _addtoOrder();
                    print("add");
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
