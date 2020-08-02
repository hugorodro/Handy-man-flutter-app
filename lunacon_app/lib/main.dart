import 'package:flutter/material.dart';
import 'package:lunacon_app/models/token.dart';
import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Lunacon App',
        routes: routes,
        initialRoute: '/login',
      ),
    );
  }
}

// const cobaltColor = const Color(0xFF0B1D6F);
const cobaltColor = Colors.blue;
const titleSize = 40.0;
const labelSize = 20.0;
const subLabelSize = 10.0;

const restAPIstr =
    'http://127.0.0.1:8000/';
// const restAPIstr = 'http://ec2-54-225-124-210.compute-1.amazonaws.com/';
const productsAPIstr = restAPIstr + 'products/';
const productOrdersAPIstr = restAPIstr + 'productOrders/';
const ordersAPIstr = restAPIstr + 'orders/';
const jobSiteAPIstr = restAPIstr + 'jobsite/';
const tokenRequestStr = restAPIstr + 'login/';
const nameRequestStr = restAPIstr + 'users/3/';

Future<Token> futureAuthToken;
Token authToken;
// String userInfoName;
