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
      backgroundColor: Colors.blue,
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                child: Text('Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, color: Colors.white))),
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.all(5),
              width: 350,
              child: Text(
                'Email',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              height: 65,
              width: 350,
              child: Card(
                color: Colors.blue,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 200,
                      child: TextField(
                        textAlign: TextAlign.left,
                        controller: _userNameController,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            hintStyle:
                                TextStyle(fontSize: 15, color: Colors.white),
                            border: InputBorder.none,
                            hintText: 'Enter your username'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              padding: EdgeInsets.all(5),
              width: 350,
              child: Text(
                'Password',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              height: 65,
              width: 350,
              child: Card(
                color: Colors.blue,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 200,
                      child: TextField(
                        textAlign: TextAlign.left,
                        controller: _passwordController,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            hintStyle:
                                TextStyle(fontSize: 15, color: Colors.white),
                            border: InputBorder.none,
                            hintText: 'Enter your password'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              message,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25),
            Container(
              height: 50,
              width: 275,
              child: Card(
                elevation: 5,
                color: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: FlatButton(
                  child: Text('Login',
                      style: TextStyle(
                          fontSize: labelSize, color: Colors.grey[900])),
                  onPressed: () async {
                    authToken = await fetchToken(
                        _userNameController.text, _passwordController.text);
                    if (authToken != null) {
                      _userNameController.text = "";
                      _passwordController.text = "";
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
