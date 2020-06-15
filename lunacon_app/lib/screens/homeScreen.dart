import 'package:flutter/material.dart';
import 'package:lunacon_app/data/cart_module.dart';
import 'package:lunacon_app/main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int _selectedIndex;
  String _title;
  String _instructions;

  @override
  void initState() {
    super.initState();
    // _selectedIndex = 1;
    _title = "Tools";
    _instructions =
        "Click on the enabled cards below for access.";
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

  buildTable(context,) {
    // if (index == 1) {
      return Table(children: <TableRow>[
        TableRow(children: <Widget>[
          HomeMenuCard(
              aCaption: 'Office Supply', aRoute: '/supply', isDisabled: false),
          HomeMenuCard(aCaption: 'Order Status', aRoute: '/supplyStatus', isDisabled: false),
        ])]);
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
        // bottomNavigationBar: BottomNavigationBar(
        //   backgroundColor: Colors.white, elevation: 5,
        //   currentIndex:
        //       _selectedIndex, // this will be set when a new tab is tapped
        //   onTap: (index) {
        //     switchTab(index);
        //   },
        //   selectedItemColor: Colors.blue,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.lock),
        //       title: Text('Logout'),
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.build),
        //       title: Text('Tools'),
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.book),
        //       title: Text('History'),
        //     ),
        //   ],
        // ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Text(
                      _title,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Text(_instructions,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: buildTable(context),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Card(color: Colors.grey, elevation: 5,
                          child: FlatButton(
                  child: Text("Logout"),
                  onPressed: () {
                    clearCart();
                    authToken = null;
                    Navigator.pushNamed(context, '/login');
                  }),
            ),
            SizedBox(
              height: 50,
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
      height: MediaQuery.of(context).size.width / 4,
      width: MediaQuery.of(context).size.width / 2,
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
