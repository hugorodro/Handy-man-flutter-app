import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lunacon_app/main.dart';
import 'package:lunacon_app/models/token.dart';
import 'package:lunacon_app/screens/homeScreen.dart';
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

  @override
  void initState() {
    super.initState();
    authstatus = false;
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
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(flex: 1, child: Container()),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Login',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: titleSize, color: cobaltColor))),
              Expanded(flex: 1, child: Container()),
              Container(
                child: TextField(
                  controller: _userNameController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Username'),
                ),
              ),
              Container(child: Divider(color: Colors.grey)),
              Container(
                child: TextField(
                  controller: _passwordController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Password'),
                ),
              ),
              Container(child: Divider(color: Colors.grey)),
              Expanded(flex: 1, child: Container()),
              Container(
                height: 50,
                width: 250,
                child: Card( elevation: 5,
                  color: cobaltColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: cobaltColor, width: 2)),
                  child: FlatButton(
                    child: Text('Login',
                        style: TextStyle(
                            fontSize: labelSize, color: Colors.white)),
                    onPressed: () {
                      futureAuthToken = fetchToken(
                          _userNameController.text, _passwordController.text);
                      displayLoginStatus();
                    },
                  ),
                ),
              ),
              Expanded(flex: 4, child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  displayLoginStatus() {
    showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return FutureBuilder<Token>(
            future: futureAuthToken,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                authToken = snapshot.data;
                authstatus = true;
              } else if (snapshot.hasError) {}
              return nextScreen(authstatus);
            });
      },
    );
  }

  nextScreen(authstatus) {
  if (authstatus == false) {
    return new AuthScreen();
  } else {
    
    return new HomeScreen();
  }
}
}




