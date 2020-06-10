import 'package:lunacon_app/models/product.dart';

class ProductOrder {
  final Product myProduct;
  int myQuantity;

  ProductOrder(this.myProduct, [this.myQuantity = 0]);

  void add() {
    myQuantity += 1;
  }

  void remove() {
    if (myQuantity > 0) {
      myQuantity -= 1;
    }
  }

  double getCost() {
    return double.parse(myProduct.price) * myQuantity;
  }
}
