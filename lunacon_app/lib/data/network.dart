import 'package:lunacon_app/main.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'package:lunacon_app/models/token.dart';
import 'package:lunacon_app/models/product.dart';
import 'package:lunacon_app/models/product_order.dart';
import 'package:lunacon_app/models/order.dart';
import 'package:lunacon_app/models/jobsite.dart';

// request auth token
Future<Token> fetchToken(String aUserName, String aPassword) async {
  final http.Response response = await http.post(
    tokenRequestStr,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'username': aUserName, 'password': aPassword}),
  );

  if (response.statusCode == 200) {
    print('login successful');

    return Token.fromJson(json.decode(response.body));
  } else {
    print(response.statusCode);
    return null;
  }
}

// Future<String> fetchName(int userId) async {
//   final http.Response response = await http.get(
//     nameRequestStr,
//     headers: <String, String>{
//       HttpHeaders.authorizationHeader: "Token " + authToken.tokenStr
//     },
//   );

//   if (response.statusCode == 200) {
//     print('login successful');
//     return json.decode(response.body);
//   } else {
//     print(nameRequestStr + userId.toString() + '/');
//     print(response.body);
//     print(response.statusCode);
//     return null;
//   }
// }

Future<List<Order>> fetchMyOrders() async {
  final orederListAPIUrl = ordersAPIstr;
  final response = await http.get(
    orederListAPIUrl,
    headers: {HttpHeaders.authorizationHeader: "Token " + authToken.tokenStr},
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    print(jsonResponse);
    print('yes');
    print(jsonResponse.length);
    return jsonResponse.map((job) => new Order.fromJson(job)).where(
      (element) {
        if (element.user == authToken.userId) {
          return true;
        } else
          return false;
      },
    ).toList();
  } else {
    print('meh');
    throw Exception('Failed to load jobs from API');
  }
}

// request catalogue
Future<List<Product>> fetchProducts() async {
  final productsListAPIUrl = productsAPIstr;
  final response = await http.get(
    productsListAPIUrl,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Token " + authToken.tokenStr
    },
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    print(jsonResponse);
    print('yes');
    print(jsonResponse.length);
    return jsonResponse.map((job) => new Product.fromJson(job)).toList();
  } else {
    print('meh');
    throw Exception('Failed to load products from API');
  }
}

// send product order
Future<List<ProductOrder>> fetchProductOrders() async {
  final String apiURL = productOrdersAPIstr;
  final response = await http.get(
    apiURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Token " + authToken.tokenStr,
    },
    // body: jsonEncode(<String, dynamic>{
    //   'order': anOrder.id,
    // }),
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    print(jsonResponse);
    print('yes');
    print(jsonResponse.length);
    return jsonResponse.map((job) => new ProductOrder.fromJson(job)).toList();
  } else {
    print('meh');
    throw Exception('Failed to load jobs from API');
  }
}

Future<String> sendProductOrders(ProductOrder productOrder) async {
  final productsListAPIUrl = productOrdersAPIstr;
  final response = await http.post(productsListAPIUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Token " + authToken.tokenStr,
      },
      body: jsonEncode(<String, dynamic>{
        'quantity': productOrder.myQuantity.toString(),
        'product': productOrder.myProduct.id,
        'order': productOrder.myOrder.toString(),
      }));

  if (response.statusCode == 201) {
    print(response.body.length);
    print(response.body);
    print("order placed");
    return ("placed.");
  } else {
    print(response.statusCode);
    print("order not placed");
    return ("not placed.");
  }
}

// launce product request form
launchURL() async {
  const url =
      'https://forms.office.com/Pages/ResponsePage.aspx?id=d5b8boJWQEe7CgaWFyi5oRfYc-naQEZAmEhCmNQzUFNUQkZRMjRLNDNVNlo4QzVSWjZDSEtZTDgxNS4u';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//create an order
Future<Order> createOrder(int aJobSiteID) async {
  final http.Response response = await http.post(
    ordersAPIstr,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Token " + authToken.tokenStr,
    },
    body: jsonEncode(<String, dynamic>{
      'fulfilled': 'false',
      'user': authToken.userId.toString(),
      'jobSite': aJobSiteID.toString(),
    }),
  );

  if (response.statusCode == 201) {
    print('order was created ');

    return Order.fromJson(json.decode(response.body));
  } else {
    print('try again bih');
    throw Exception('Failed to create order.');
  }
}

Future<List<JobSite>> fetchJobSites() async {
  final response = await http.get(
    jobSiteAPIstr,
    headers: {HttpHeaders.authorizationHeader: "Token " + authToken.tokenStr},
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    print(jsonResponse);
    print('yes');
    print(jsonResponse.length);
    return jsonResponse.map((job) => new JobSite.fromJson(job)).toList();
  } else {
    print('meh');
    throw Exception('Failed to load jobs from API');
  }
}

Future<List<JobSite>> fetchAJobSiteName(int index) async {
  final response = await http.get(
    jobSiteAPIstr,
    headers: {HttpHeaders.authorizationHeader: "Token " + authToken.tokenStr},
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    print(jsonResponse);
    print('yes');
    print(jsonResponse.length);
    return jsonResponse.map((job) => new JobSite.fromJson(job));
  } else {
    print('meh');
    throw Exception('Failed to load jobs from API');
  }
}
