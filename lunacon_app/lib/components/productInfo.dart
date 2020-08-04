import 'package:flutter/material.dart';
import 'package:lunacon_app/models/product.dart';

class ProductInfo extends StatelessWidget {
  final Image myImage;
  final Product myProduct;
  final double myImageRadius;

  ProductInfo({this.myImage, this.myProduct, this.myImageRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          _dispayImage(context),
          _displayInfo(context),
        ],
      ),
    );
  }

  Widget _dispayImage(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: CircleAvatar(
        radius: myImageRadius + 2,
        backgroundColor: Colors.blueGrey[300],
        child: CircleAvatar(
          radius: myImageRadius,
          backgroundColor: Colors.white,
          child: ClipOval(
            child: myImage,
          ),
        ),
      ),
    );
  }

  Widget _displayInfo(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(myProduct.name,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 5),
          Text(myProduct.specs,
              style: TextStyle(color: Colors.grey, fontSize: 15)),
          SizedBox(height: 5),
          Text('Amount: ' + myProduct.numInPack.toString(),
              style: TextStyle(color: Colors.grey, fontSize: 15)),
          SizedBox(height: 5),
          Text(r'$' + myProduct.priceEstimate,
              style: TextStyle(color: Colors.grey, fontSize: 15))
        ],
      ),
    );
  }
}
