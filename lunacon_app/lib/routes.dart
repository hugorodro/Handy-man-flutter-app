import 'package:flutter/material.dart';
import 'package:lunacon_app/screens/cartScreen.dart';
import 'screens/homeScreen.dart';
import 'screens/osScreen.dart';
import 'screens/loginScreen.dart';

final routes = {
  '/login': (BuildContext context) => new LoginScreen(),
  '/home': (BuildContext context) => new HomeScreen(),
  '/equipment': (BuildContext context) => new CartScreen(),
  '/supply': (BuildContext context) => new OfficeSupplyScreen(),
};


