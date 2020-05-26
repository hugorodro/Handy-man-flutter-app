import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunacon_app/main.dart';
import 'package:lunacon_app/models/jobsite.dart';
import 'package:lunacon_app/models/product.dart';
// import 'package:lunacon_app/models/order.dart';
import 'package:lunacon_app/screens/confirmationScreen.dart';
import 'package:lunacon_app/network.dart';
import 'package:lunacon_app/screens/osScreen.dart';

List<int> quantityList;
Future<List<JobSite>> futureJobSiteList;
List<JobSite> aJobSiteList = [];
List<Product> productReceiptlist = [];

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
  // List<Order> orderList = [];

  @override
  void initState() {
    super.initState();
    quantityList = new List();
    for (var i = 0; i < productsList.length; i++) {
      quantityList.add(0);
      print(quantityList);
    }
    futureJobSiteList = fetchJobSites();
    productReceiptlist = productsList;
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
    return widget.selectedProducts == null
        ? new OfficeSupplyScreen()
        : new Scaffold(
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
                  child: _myCartView(context),
                ),
              ),
              Container(
                height: 150.0,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.blue, Colors.blue[100]]),
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
                      height: 50,
                      child: Card(
                        color: Colors.blueGrey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: FlatButton(
                          child: Text(
                            'Location',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[900], fontSize: 15),
                          ),
                          onPressed: () {
                            displayJobSites();
                          },
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                    Container(
                      width: 250,
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
                                    receiptQuantities: quantityList,
                                    receiptProducts: productReceiptlist,
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
                    Expanded(flex: 2, child: Container()),
                  ],
                ),
              ),
            ],
          ));
  }

  Widget _myCartView(BuildContext context) {
    return ListView.builder(
      itemCount: widget.selectedProducts.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Container(
                height: 100,
                child: ProductCard(
                    anIndex: index, aProduct: widget.selectedProducts[index])),
            SizedBox(
              height: 10,
            )
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

  _ProductCardState({@required this.indexForQuantityChanges});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: cobaltColor, width: 2)),
      child: ListTile(
        title: Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.aProduct.name,
                  style: TextStyle(
                      color: cobaltColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 5,
              ),
              Text(widget.aProduct.specs,
                  style: TextStyle(color: Colors.blue, fontSize: 12)),
              Text(
                  '# in Pack ' +
                      widget.aProduct.numInPack.toString() +
                      ', ' +
                      widget.aProduct.price,
                  style: TextStyle(color: Colors.blue, fontSize: 12)),
            ],
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
          child: Column(
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                child: TextFormField(
                  textAlign: TextAlign.center,
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
              Container(
                color: Colors.blue,
                height: 1,
                width: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
