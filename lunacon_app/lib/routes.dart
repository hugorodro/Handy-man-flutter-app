import 'package:flutter/material.dart';
import 'package:lunacon_app/screens/cartScreen.dart';
import 'screens/homeScreen.dart';
import 'screens/osScreen.dart';
import 'screens/welcomeScreen.dart';

final routes = {
  '/welcome': (BuildContext context) => new WelcomeScreen(),
  '/home': (BuildContext context) => new HomeScreen(),
  '/equipment': (BuildContext context) => new CartScreen(),
  '/supply': (BuildContext context) => new OfficeSupplyScreen(),
};


