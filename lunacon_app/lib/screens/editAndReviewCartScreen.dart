import 'package:flutter/material.dart';
import 'package:lunacon_app/models/jobsite.dart';
import 'package:lunacon_app/models/product.dart';
import 'package:lunacon_app/data/network.dart';
import 'package:lunacon_app/data/cart_module.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'confirmationScreen.dart';

class EditAndReviewScreen extends StatefulWidget {
  @override
  _EditAndReviewScreenState createState() => _EditAndReviewScreenState();
}

class _EditAndReviewScreenState extends State<EditAndReviewScreen> {
  Future<List<JobSite>> futureJobSiteList;
  List<JobSite> aJobSiteList = [];
  List<Product> productReceiptlist = [];

  int selectedJS;
  bool isJSselected = false;
  String btnLocationtxt;
  // List<Order> orderList = [];

  @override
  void initState() {
    super.initState();
    btnLocationtxt = "Location";
    futureJobSiteList = fetchJobSites();
    selectedJS = 0;
  }

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

  showError(String message) {
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
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
              Icons.description,
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
          Container(
            height: MediaQuery.of(context).size.height * (.5),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Today's Overview",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[900],
                        ),
                      ),

                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: ListView.separated(
                        itemCount: 4,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              title: Text('Goal $index'),
                              trailing: Text('0' + "/" + "5"));
                        },
                      )),
                )
              ],
            ),
          ),
          SizedBox(height: 25),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                height: (MediaQuery.of(context).size.height * .25),
              ),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * (.2),
                          width: MediaQuery.of(context).size.width * (.67),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.5)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Goal',
                                  style: TextStyle(
                                    fontSize: 30,
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Text('0 / 5',
                                  style: TextStyle(
                                    fontSize: 40,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          left:
                              MediaQuery.of(context).size.width * (.67) * (.2),
                          height: 50,
                          child: IconButton(
                            color: Colors.red,
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              print("blah");
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          right:
                              MediaQuery.of(context).size.width * (.67) * (.2),
                          height: 50,
                          child: IconButton(
                            color: Colors.green,
                            icon: Icon(Icons.add),
                            onPressed: () {
                              print("blah");
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
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
                        style: TextStyle(color: Colors.grey[900], fontSize: 15),
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
                          style:
                              TextStyle(color: Colors.grey[900], fontSize: 20)),
                      onPressed: () {
                        if (isJSselected != true) {
                          showError(
                              "You can't go on unless you select a location.");
                        } else {
                          // sendOrders();
                          // if (allPOsHaveQuantities() == true) {
                          int jsindex = selectedJS - 1;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => new ConfirmationScreen(
                                aJS: aJobSiteList[jsindex],
                              ),
                            ),
                          );
                          // } else {
                          showError(
                              "Make sure you aren't ordering something with a count of 0.");
                          // }
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
}
