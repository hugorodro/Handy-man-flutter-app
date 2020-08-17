import 'package:lunacon_app/models/product_order.dart';
import 'package:lunacon_app/models/order.dart';
import 'package:lunacon_app/data/network.dart';

List<ProductOrder> _allProductOrders = [];

void loadProductOrders() async {
  if (_allProductOrders.length < 1) {
    _allProductOrders = await fetchProductOrders();
  }
}

Future<List<ProductOrder>> filterProductOrders(Order anOrder) async {
  List<ProductOrder> _filteredProductOrders = [];
  _allProductOrders.forEach((element) {
    if (element.myOrder == anOrder.id) {
      _filteredProductOrders.add(element);
    }
  });
  print(_filteredProductOrders.length);
  return _filteredProductOrders;
}

// Sets variables responsive for holding order infomation
bool _newOrderPlaced;
List<Order> _myOrders = [];

// Controls flow of network request to make sure it doesnt happen to often
Future<List<Order>> getOrders() async {
  if (_myOrders.length < 1) {
    _newOrderPlaced = false;
    _myOrders = await fetchMyOrders();
    return _myOrders;
  } else if (_newOrderPlaced == true) {
    _newOrderPlaced = false;
    _myOrders = await fetchMyOrders();
    return _myOrders;
  } else {
    return _myOrders;
  }
}

// after an order has been placed, this will set the variable to true
// thus informing a new http request should be made
void communicatedOrderPlacement() {
  _newOrderPlaced = true;
}
