import 'package:flutter/material.dart';
import 'package:lunacon_app/screens/homeScreen.dart';
import 'screens/osScreen.dart';
import 'screens/welcomeScreen.dart';
import 'screens/authScreen.dart';
import 'screens/cartScreen.dart';
import 'package:lunacon_app/models/token.dart';

final routes = {
  '/welcome': (BuildContext context) => WelcomeScreen(),
  '/home': (BuildContext context) => HomeScreen(),
  '/supply': (BuildContext context) => OfficeSupplyScreen(),
  '/auth': (BuildContext context) => AuthScreen(),
  '/cart': (BuildContext context) => CartScreen(),
};

void main() {
  runApp(
    MaterialApp(
      title: 'Lunacon App',
      routes: routes,
      initialRoute: '/welcome',
    ),
  );
}

// const cobaltColor = const Color(0xFF0B1D6F);
const cobaltColor = Colors.blue;
const titleSize = 40.0;
const labelSize = 20.0;
const subLabelSize = 10.0;

const restAPIstr = 'http://lunaconweb-project-env-env.eba-p2nat3yd.us-west-2.elasticbeanstalk.com/';
const productsAPIstr = restAPIstr+'products/';
const ordersAPIstr = restAPIstr+'orders/';
const jobSiteAPIstr = restAPIstr+'jobsite/';
const tokenRequestStr = restAPIstr + 'login/';

Future<Token> futureAuthToken ;
Token authToken ;