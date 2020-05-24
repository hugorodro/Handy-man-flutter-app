import 'package:flutter/material.dart';
import 'package:lunacon_app/components/btnThin.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Card(
                child: Image(height: 200,
                  image: AssetImage('images/LoginLogo.png'),
                ),
                elevation: 30,
              ),
              width: 350,
            ),
            SizedBox(
              height: 100,
            ),
            ThinButton(
              aRoute: '/auth',
              aText: 'Welcome',
            ),
          ],
        ),
      ),
    );
  }
}
