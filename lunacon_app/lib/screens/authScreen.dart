import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lunacon_app/main.dart';
// import 'package:lunacon_app/models/token.dart';
// import 'package:lunacon_app/screens/homeScreen.dart';
import 'package:lunacon_app/data/network.dart';

// import 'package:lunacon_app/models/product.dart/';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool authstatus;
  String message;

  @override
  void initState() {
    super.initState();
    authstatus = false;
    message = '';
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                alignment: Alignment.centerLeft,
                child: Text('Welcome',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: titleSize, color: cobaltColor))),
            SizedBox(height: 50),
            Container(
              child: TextField(
                controller: _userNameController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Username'),
              ),
            ),
            Container(child: Divider(color: Colors.grey)),
            SizedBox(height: 10),
            Container(
              child: TextField(
                controller: _passwordController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Password'),
              ),
            ),
            Container(child: Divider(color: Colors.grey)),
            SizedBox(height: 50),
            Text(
              message,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 50),
            Container(
              height: 50,
              width: 250,
              child: Card(
                elevation: 5,
                color: cobaltColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: cobaltColor, width: 2)),
                child: FlatButton(
                  child: Text('Login',
                      style:
                          TextStyle(fontSize: labelSize, color: Colors.white)),
                  onPressed: () async {
                    authToken = await fetchToken(
                        _userNameController.text, _passwordController.text);
                    if (authToken != null) {
                      Navigator.pushNamed(context, '/home');
                    } else {
                      setState(() {
                        message = "Try again.";
                      });
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  //
}
