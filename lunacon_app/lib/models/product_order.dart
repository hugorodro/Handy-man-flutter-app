import 'package:lunacon_app/data/catalogue.dart';
import 'package:lunacon_app/models/product.dart';

class ProductOrder {
  Product myProduct;
  int myQuantity;
  int myOrder;

  ProductOrder(this.myProduct, [this.myQuantity = 1]);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["quantity"] = myQuantity;
    map["product"] = myProduct.id;
    map["order"] = myOrder;

    return map;
  }

  ProductOrder.fromJson(Map<String, dynamic> json)
      : myProduct = getProductFromCatalogue(json['product']),
        myOrder = json['order'],
        myQuantity = json['quantity'];
  

  void add() {
    myQuantity += 1;
  }

  void remove() {
    if (myQuantity > 0) {
      myQuantity -= 1;
    }
  }

  double getCost() {
    return (double.parse(myProduct.priceEstimate) * myQuantity);
  }
}
