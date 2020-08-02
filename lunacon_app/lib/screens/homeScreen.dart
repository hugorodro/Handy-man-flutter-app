import 'package:flutter/material.dart';
import 'package:lunacon_app/data/cart_module.dart';
import 'package:lunacon_app/main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int _selectedIndex;
  String _instructions;

  @override
  void initState() {
    super.initState();
    // _selectedIndex = 1;
    _instructions = "Tap on a card to start.";
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text("Home"),
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Extras',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text("Check office supply status?"),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/supplyStatus');
                },
              ),
              Divider(
                color: Colors.grey[300],
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () {
                  clearCart();
                  authToken = null;
                  Navigator.pushNamed(context, '/login');
                },
              ),
              Divider(
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: buildTable(context),
            ),
            SizedBox(
              width: 200,
              child: Text(_instructions,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.grey[900])),
            ),
          ],
        ));
  }
}

Widget buildTable(
  context,
) {
  // if (index == 1) {
  return Table(children: <TableRow>[
    TableRow(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(30),
          height: (MediaQuery.of(context).size.width * .4),
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.blue,
            child: FlatButton(
              padding: EdgeInsets.all(45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.local_shipping,
                    size: 40,
                    color: Colors.white,
                  ),
                  Text('Order Office Supply',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                ],
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/supply');
              },
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(30),
          height: (MediaQuery.of(context).size.width * .4),
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.grey,
            child: FlatButton(
              padding: EdgeInsets.all(45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.local_shipping,
                    size: 40,
                    color: Colors.white,
                  ),
                  Text('Track Equipment',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                ],
              ),
              onPressed: () {
                return;
              },
            ),
          ),
        )
      ],
    ),
    TableRow(children: <Widget>[
      Container(
        padding: EdgeInsets.all(30),
        height: (MediaQuery.of(context).size.width * .4),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.grey,
          child: FlatButton(
            padding: EdgeInsets.all(45),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.note_add,
                  size: 40,
                  color: Colors.white,
                ),
                Text('Log Events',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, color: Colors.white)),
              ],
            ),
            onPressed: () {
              return;
            },
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.all(30),
        height: (MediaQuery.of(context).size.width * .4),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.grey,
          child: FlatButton(
            padding: EdgeInsets.all(45),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.local_shipping,
                  size: 40,
                  color: Colors.white,
                ),
                Text('Manage Cretifications',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, color: Colors.white)),
              ],
            ),
            onPressed: () {
              return;
            },
          ),
        ),
      )
    ])
  ]);
}
