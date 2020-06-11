import 'package:lunacon_app/models/product.dart';

class ProductOrder {
  final Product myProduct;
  int myQuantity;
  int myOrder;

  ProductOrder(this.myProduct, [this.myQuantity = 0]);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["quantity"] = myQuantity;
    map["product"] = myProduct.id;
    map["order"]= myOrder;

    return map;
  }

  void add() {
    myQuantity += 1;
  }

  void remove() {
    if (myQuantity > 0) {
      myQuantity -= 1;
    }
  }

  double getCost() {
    return double.parse(myProduct.priceEstimate) * myQuantity;
  }

}
