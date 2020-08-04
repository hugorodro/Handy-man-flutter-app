import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lunacon_app/data/catalogue.dart';
import 'package:lunacon_app/main.dart';
// import 'package:lunacon_app/models/token.dart';
// import 'package:lunacon_app/screens/homeScreen.dart';
import 'package:lunacon_app/data/network.dart';

// import 'package:lunacon_app/models/product.dart/';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    startCashing(context);

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: 400,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Text('Sign In',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30, color: Colors.white))),
                Column(
                  children: <Widget>[
                    _inputLabel(context, 'Username'),
                    _usernameInput(context),
                  ],
                ),
                Column(
                  children: <Widget>[
                    _inputLabel(context, 'Password'),
                    _passwordInput(context),
                  ],
                ),
                Text(
                  message,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                _loginButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputLabel(BuildContext context, String label) {
    return Container(
      padding: EdgeInsets.all(5),
      width: 300,
      child: Text(
        label,
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _usernameInput(BuildContext context) {
    return Container(
      height: 65,
      width: 300,
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
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(fontSize: 15, color: Colors.white),
                    border: InputBorder.none,
                    hintText: 'Enter your username'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _passwordInput(BuildContext context) {
    return Container(
      height: 65,
      width: 300,
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
                cursorColor: Colors.white,
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(fontSize: 15, color: Colors.white),
                    border: InputBorder.none,
                    hintText: 'Enter your password'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Container(
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
              style: TextStyle(fontSize: labelSize, color: Colors.grey[900])),
          onPressed: () async {
            authToken = await fetchToken(
                _userNameController.text, _passwordController.text);
            if (authToken != null) {
              alphaSort();
              _userNameController.text = "";
              _passwordController.text = "";
              Navigator.pushNamed(context, '/home');
              // userInfoName = await fetchName(authToken.userId);
            } else {
              setState(() {
                message = "Try again.";
              });
            }
          },
        ),
      ),
    );
  }
}
