import 'package:flutter/material.dart';
import 'package:lunacon_app/components/btnThin.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Container(
              child: Image(
                image: AssetImage('images/LoginLogo.png'),
              ),
              width: 350,
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            ThinButton(
              aRoute: '/auth',
              aText: 'Welcome',
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

