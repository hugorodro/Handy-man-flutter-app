import 'package:flutter/material.dart';
import 'package:lunacon_app/screens/homeScreen.dart';
import 'screens/osScreen.dart';
import 'screens/loginScreen.dart';
import 'screens/authScreen.dart';
import 'screens/cartScreen.dart';
import 'package:lunacon_app/models/token.dart';




final routes = {
  '/login': (BuildContext context) => LoginScreen(),
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
      initialRoute: '/login',
    ),
  );
}

const cobaltColor = const Color(0xFF0B1D6F);
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


// extension HexColor on Color {
//   /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
//   static Color fromHex(String hexString) {
//     final buffer = StringBuffer();
//     if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
//     buffer.write(hexString.replaceFirst('#', ''));
//     return Color(int.parse(buffer.toString(), radix: 16));
//   }

//   /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
//   String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
//       '${alpha.toRadixString(16).padLeft(2, '0')}'
//       '${red.toRadixString(16).padLeft(2, '0')}'
//       '${green.toRadixString(16).padLeft(2, '0')}'
//       '${blue.toRadixString(16).padLeft(2, '0')}';
// }