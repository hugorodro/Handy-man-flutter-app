import 'package:flutter/material.dart';
import 'package:lunacon_app/screens/cartScreen.dart';
// import 'package:lunacon_app/screens/cartScreen.dart';
import 'screens/homeScreen.dart';
import 'screens/osScreen.dart';
import 'screens/authScreen.dart';
import 'screens/supplyStatusScreen.dart';

// import 'screens/welcomeScreen.dart';

final routes = {
  // '/welcome': (BuildContext context) => new WelcomeScreen(),
  '/login': (BuildContext context) => new LoginScreen(),
  '/home': (BuildContext context) => new HomeScreen(),
  '/cart': (BuildContext context) => new CartScreen(),
  '/supply': (BuildContext context) => new OfficeSupplyScreen(),
  '/supplyStatus': (BuildContext context) => new SupplyStatusScreen(),
  
};
