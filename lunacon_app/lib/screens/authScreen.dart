import 'package:flutter/material.dart';
import 'package:lunacon_app/main.dart';

// import 'package:lunacon_app/models/product.dart/';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('images/backarrow.png'),
          onPressed: () {
            Navigator.pop(context, '/home');
          },
        ),
      ),
      body: Center(
          child: Row(
        children: <Widget>[
          Spacer(
            aFlex: 1,
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: <Widget>[
                Spacer(aFlex: 1),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Login',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: titleSize, color: cobaltColor))),
                Spacer(aFlex: 3),
                Container(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter a search term'),
                  ),
                ),
                Spacer(aFlex: 2),
                Container(
                    child: Divider(
                  color: Colors.grey,
                )),
                Spacer(aFlex: 2),
                Container(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter a search term'),
                  ),
                ),
                Spacer(aFlex: 2),
                Container(
                    child: Divider(
                  color: Colors.grey,
                )),
                Spacer(aFlex: 2),
                Container(
                  height: 50,
                  width: 250,
                  child: Card(
                    color: cobaltColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: cobaltColor, width: 2)),
                    child: FlatButton(
                      child: Text('Login',
                          style: TextStyle(
                              fontSize: labelSize, color: Colors.white)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                  ),
                ),
                Spacer(aFlex: 3),
              ],
            ),
          ),
          Spacer(aFlex: 1),
        ],
      )),
    );
  }
}

class Spacer extends StatelessWidget {
  final int aFlex;
  Spacer({@required this.aFlex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: aFlex,
      child: Container(),
    );
  }
}
