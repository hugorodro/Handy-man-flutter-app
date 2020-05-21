
import 'package:flutter/material.dart';
import 'package:lunacon_app/main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(flex:1, child: Container(),),
            Container(color: Colors.blue,
              // child: Image.asset('images/backArrow.png'),
              width: 300,
              height: 300,
            ),
                        Expanded(flex:1, child: Container(),),

            Container(
              width: 250,
              height: 50,
              child: Card(
                shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: cobaltColor, width: 2)),
                color: cobaltColor,
                child: FlatButton(
                  child: Text('Welcome',
                      style:
                          TextStyle(fontSize: labelSize, color: Colors.white)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/auth');
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 500,
              ),
            ),
          ],
        ),
      ),
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
      child: Container(
        width: 500,
      ),
    );
  }
}
