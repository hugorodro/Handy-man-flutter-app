import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lunacon_app/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lunacon_app/models/token.dart';
import 'package:lunacon_app/screens/homeScreen.dart';

// import 'package:lunacon_app/models/product.dart/';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool authstatus ;

  @override
  void initState() {
    super.initState();
    authstatus = false;
  }
            
  attemptAuth(){
    if (authstatus == false){
      new AuthScreen();
    }
    else {
      new HomeScreen();
    }
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
                Spacer(aFlex: 2),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Login',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: titleSize, color: cobaltColor))),
                Spacer(aFlex: 3),
                Container(
                  child: TextField(
                    controller: _userNameController,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Username'),
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
                    controller: _passwordController,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Password'),
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
                        futureAuthToken = fetchToken(
                            _userNameController.text, _passwordController.text);
                        displayLoginStatus();
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
                  } else if (snapshot.hasError) {
                  }
                  return nextScreen(authstatus);
                });
      },
    );
  }
}

nextScreen(authstatus){
  if (authstatus==false){
    return new AuthScreen();
  }
  else{
    return new HomeScreen();
  }
}

Future<Token> fetchToken(String aUserName, String aPassword) async {
  final http.Response response = await http.post(
    tokenRequestStr,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'username': aUserName, 'password': aPassword}),
  );

  if (response.statusCode == 200) {
    print('login successful');
    return Token.fromJson(json.decode(response.body));
  } else {
    print('try again bih');
    throw Exception('Failed to login');
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
