import 'package:flutter/material.dart';
import 'package:lunacon_app/data/cart_module.dart';
import 'package:lunacon_app/main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Home"),
          backgroundColor: Colors.blue,
        ),
        //   bottomNavigationBar: BottomNavigationBar(

        //    currentIndex: 0, // this will be set when a new tab is tapped
        //    items: [
        //      BottomNavigationBarItem(
        //        icon: new Icon(Icons.build),
        //        title: new Text('Tools'),
        //      ),
        //      BottomNavigationBarItem(
        //        icon: new Icon(Icons.network_check),
        //        title: new Text('Status'),
        //      ),
        //      BottomNavigationBarItem(
        //        icon: Icon(Icons.note),
        //        title: Text('History')
        //      )
        //    ],
        //  ),
        body: Center(
          child: Container(
            alignment: Alignment.center,
            height: 500,
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                HomeMenuCard(aCaption: 'Purchasing', aRoute: '/supply'),
                // HomeMenuCard(aCaption: 'Office Supply', aRoute:'osScreen'),
                // HomeMenuCard(aCaption: 'Office Supply', aRoute:'osScreen'),
                // HomeMenuCard(aCaption: 'Office Supply', aRoute:'osScreen'),
                Expanded(flex: 1, child: Container()),
                Container(
                    height: 100,
                    width: 300,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: FlatButton(
                        child: Text("Logout"),
                        onPressed: () {
                          authToken = null;
                          Navigator.pushNamed(context, '/');
                        })),
              ],
            ),
          ),
        ));
  }
}

class HomeMenuCard extends StatelessWidget {
  final String aCaption;
  final String aRoute;

  HomeMenuCard({@required this.aCaption, this.aRoute});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      height: 200,
      width: 350,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: cobaltColor,
        child: FlatButton(
          padding: EdgeInsets.all(15),
          child: Text(aCaption,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: labelSize, color: Colors.white)),
          onPressed: () {
            clearCart();
            Navigator.pushNamed(context, aRoute);
          },
        ),
      ),
    );
  }
}
