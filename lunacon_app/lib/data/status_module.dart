import 'package:lunacon_app/models/product_order.dart';
import 'package:lunacon_app/models/order.dart';
import 'package:lunacon_app/data/network.dart';

List<ProductOrder> _allProductOrders = [];

void getProductOrders() async {
  _allProductOrders = await fetchProductOrders();
}

Future<List<ProductOrder>> filterProductOrders(Order anOrder) async {
  List<ProductOrder> _filteredProductOrders = [];
  _allProductOrders.forEach((element) {
    if (element.myOrder== anOrder.id) {
      _filteredProductOrders.add(element);
    }
  });
  print(_filteredProductOrders.length);
  return _filteredProductOrders;
}

