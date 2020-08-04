import 'dart:ui';
import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:lunacon_app/data/cart_module.dart';
import 'package:lunacon_app/main.dart';
import 'package:lunacon_app/components/misc.dart';

class HomeScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    setScreenDimensions(context);
    return Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(image: bgImage, fit: BoxFit.fill),
      ),
      child: ClipRRect(
        // make sure we apply clip it properly
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(0.1),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text("Home"),
              ),
              drawer: _homeDrawer(context),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buttonLayout(context),
                  SizedBox(
                    height: 100,
                    width: 200,
                    child: Text("Tap on a blue card to start.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _homeDrawer(context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: screenHeight * .3,
            child: DrawerHeader(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: ExactAssetImage('images/LoginLogo.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      authToken.firstName + ' ' + authToken.lastName,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.schedule),
            title: Text("Check office supply status?"),
            onTap: () {
              Navigator.popAndPushNamed(context, '/supplyStatus');
            },
          ),
          divider(context),
          ListTile(
            leading: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: Icon(
                Icons.exit_to_app,
              ),
            ),
            title: Text('Logout'),
            onTap: () {
              clearCart();
              authToken = null;
              Navigator.pushNamed(context, '/login');
            },
          ),
          divider(context),
        ],
      ),
    );
  }

  Widget _buttonLayout(context) {
    // if (index == 1) {
    return Container(
      width: (MediaQuery.of(context).size.width),
      height: (MediaQuery.of(context).size.width),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _homeButton(context, 'Order Office Supple', '/supply'),
              _homeButton(context, 'Track Equipment', null)
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _homeButton(context, 'Log Events', null),
                _homeButton(context, 'Manage Certifications', null)
              ])
        ],
      ),
    );
  }

  Widget _homeButton(BuildContext context, String label, String route) {
    return Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey],
          begin: Alignment(-2.0, -4.0),
          end: Alignment(0, 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[900].withOpacity(0.50),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(1, 3), // changes position of shadow
          ),
        ],
      ),
      child: FlatButton(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * .01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.card_membership,
              size: 30,
              color: Colors.white,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * .01,
            ),
            Text('label',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ],
        ),
        onPressed: () {
          if (route != null) {
            Navigator.pushNamed(context, route);
          } else {
            return;
          }
        },
      ),
    );
  }
}
