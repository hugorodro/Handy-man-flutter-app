import 'package:lunacon_app/models/product.dart';
import 'package:lunacon_app/data/network.dart';
import 'package:lunacon_app/models/order.dart';
import 'package:lunacon_app/models/product_order.dart';


List<ProductOrder> _cart = [];
Order order;

void addToCart(Product value) {
  ProductOrder aPO = ProductOrder(value);
  _cart.add(aPO);
  print(_cart);
}

void removeFromCart(Product value) {
  for (int i = 0; i < _cart.length; i++) {
    if (_cart[i].myProduct == value) {
      _cart.remove(_cart[i]);
    }
  }
  print(_cart);
}

ProductOrder getPO(int index) {
  return _cart[index];
}

Product getProduct(int index) {
  return _cart[index].myProduct;
}

void clearCart() {
  _cart.clear();
}

int cartSize() {
  return _cart.length;
}

double cartCost() {
  double sum = 0;
  for (int i = 0; i < _cart.length; i++) {
    sum += _cart[i].getCost();
  }
  return sum;
}

void createAndSetOrder(int aJS) async {
  order = await createOrder(aJS);
  for (int i = 0; i < _cart.length; i++) {
    _cart[i].myOrder = order.id;
    sendProductOrders(_cart[i]);
    print("attempt at order product");
  }
  
}


