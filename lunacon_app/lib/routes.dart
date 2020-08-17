import 'package:flutter/material.dart';
import 'package:lunacon_app/screens/cartScreen.dart';
// import 'package:lunacon_app/screens/cartScreen.dart';
import 'screens/homeScreen.dart';
import 'screens/catalogScreen.dart';
import 'screens/authScreen.dart';
import 'screens/orderStatusScreen.dart';

// import 'screens/welcomeScreen.dart';

final routes = {
  // '/welcome': (BuildContext context) => new WelcomeScreen(),
  '/login': (BuildContext context) => new LoginScreen(),
  '/home': (BuildContext context) => new HomeScreen(),
  '/cart': (BuildContext context) => new CartScreen(),
  '/catalog': (BuildContext context) => new CatalogScreen(),
  '/orderStatus': (BuildContext context) => new OrderStatusScreen(),
};
