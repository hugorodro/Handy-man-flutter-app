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

  // void switchTab(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //     if (_selectedIndex == 0) {
  //       clearCart();
  //       authToken = null;
  //       Navigator.pushNamed(context, '/login');
  //     } else if (_selectedIndex == 1) {
  //       _title = "Tools View";
  //       _instructions =
  //           "Click on the enabled cards to access the available tools.";
  //     } else {
  //       _title = "History View";
  //       _instructions =
  //           "Click on the enabled cards below to check your history and current statuses.";
  //     }
  //   });
  // }

  buildTable(
    context,
  ) {
    // if (index == 1) {
    return Table(children: <TableRow>[
      TableRow(children: <Widget>[
        HomeMenuCard(
            aCaption: 'Order Office Supply Here',
            aRoute: '/supply',
            isDisabled: false),
      ])
    ]);
    // TableRow(children: <Widget>[
    //   HomeMenuCard(
    //       aCaption: 'Certifications', aRoute: '', isDisabled: true),
    //   HomeMenuCard(aCaption: 'Materials', aRoute: '', isDisabled: true),
    // ])
    //   ]);
    // } else {
    //   return Table(children: <TableRow>[
    //     TableRow(children: <Widget>[
    //       HomeMenuCard(
    //         aCaption: 'Office supply',
    //         aRoute: '/supplyStatus',
    //         isDisabled: false,
    //       ),
    //       // HomeMenuCard(
    //       //   aCaption: 'Equipment',
    //       //   aRoute: '',
    //       //   isDisabled: true,
    //       // ),
    //     ]),
    //     // TableRow(children: <Widget>[
    //     //   HomeMenuCard(
    //     //       aCaption: 'Certifications', aRoute: '', isDisabled: true),
    //     //   HomeMenuCard(
    //     //     aCaption: 'Materials',
    //     //     aRoute: '',
    //     //     isDisabled: true,
    //     //   ),
    //     // ])
    //   ]);
    // }
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
                child: Text(
                  'Extras',
                  style: TextStyle(fontSize: 30, color: Colors.white),
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
              ListTile(
                title: Text('Logout'),
                onTap: () {
                  clearCart();
                  authToken = null;
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: buildTable(context),
              ),
            ),
            SizedBox(
              width: 200,
              child: Text(_instructions,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.grey[900])),
            ),
            SizedBox(
              height: 200,
            ),
          ],
        ));
  }
}

class HomeMenuCard extends StatelessWidget {
  final String aCaption;
  final String aRoute;
  final bool isDisabled;
  final String message = ", example";

  HomeMenuCard({@required this.aCaption, this.aRoute, this.isDisabled});

  String _getCaption() {
    if (isDisabled == true) {
      return aCaption + message;
    } else {
      return aCaption;
    }
  }

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      height: (MediaQuery.of(context).size.height * .125),
      padding: EdgeInsets.all(5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: cobaltColor,
        child: FlatButton(
          padding: EdgeInsets.all(15),
          child: Text(_getCaption(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onPressed: () {
            if (isDisabled == false) {
              clearCart();
              print(aRoute);
              Navigator.pushNamed(context, aRoute);
            }
          },
        ),
      ),
    );
  }
}
