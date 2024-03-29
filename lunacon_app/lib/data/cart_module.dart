import 'package:lunacon_app/models/product.dart';
import 'package:lunacon_app/data/network.dart';
import 'package:lunacon_app/models/order.dart';
import 'package:lunacon_app/models/product_order.dart';
import 'status_module.dart';

List<ProductOrder> _cart = [];
Order _order;

void addToCart(Product value) {
  bool isInCart = false;
  _cart.forEach((element) {
    if (element.myProduct == value) {
      element.myQuantity += 1;
      isInCart = true;
    }
  });

  if (isInCart == false) {
    ProductOrder aPO = ProductOrder(value);
    _cart.add(aPO);
    print(_cart);
  }
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

String numItemsInCart() {
  int sum = 0;
  _cart.forEach((element) {
    sum += element.myQuantity;
  });
  return sum.toString();
}

double cartCost() {
  double sum = 0;
  for (int i = 0; i < _cart.length; i++) {
    sum += _cart[i].getCost();
  }
  return sum;
}

Future<List<String>> createAndSetOrder(int aJS) async {
  List<String> _requestStatus = [];
  _order = await createOrder(aJS);
  for (int i = 0; i < _cart.length; i++) {
    if (_cart[i].myQuantity > 0) {
      _cart[i].myOrder = _order.id;
      _requestStatus.add(_cart[i].myQuantity.toString() +
          " order of " +
          _cart[i].myProduct.name +
          " was " +
          await sendProductOrders(_cart[i]));
      print("attempt at order product");
    }
  }
  communicatedOrderPlacement();
  return _requestStatus;
}

bool allPOsHaveQuantities() {
  for (int i = 0; i < _cart.length; i++) {
    if (_cart[i].myQuantity == 0) {
      return false;
    }
  }
  return true;
}
