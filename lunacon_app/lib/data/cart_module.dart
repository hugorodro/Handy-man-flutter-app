import 'package:lunacon_app/models/Product_Order.dart';
import 'package:lunacon_app/models/product.dart';
import 'package:lunacon_app/data/network.dart';
import 'package:lunacon_app/main.dart';

List<ProductOrder> _cart = [];

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

void sendOrders(int aJS) {
    for (var i = 0; i < _cart.length; i++) {
      createOrder(_cart[i].myProduct.id, _cart[i].myQuantity, aJS, authToken.id);
    }
    _cart.clear();
  }


