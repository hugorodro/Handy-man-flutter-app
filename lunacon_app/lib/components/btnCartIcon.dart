import 'package:flutter/material.dart';
import 'package:lunacon_app/data/cart_module.dart';
import 'package:lunacon_app/screens/cartScreen.dart';
import 'package:lunacon_app/components/dialogueGeneric.dart';

class CartIconButton extends StatelessWidget {
  final String myCartIndicator;

  CartIconButton({this.myCartIndicator});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              if (cartSize() != 0) {
                return Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartScreen()))
                    .then((value) {});
              } else {
                return showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return GenericAlert(
                      aTitle: 'Oops',
                      aMsg: 'Select at least one product',
                      btnText: 'OK',
                    );
                  },
                );
              }
            },
          ),
        ),
        Positioned(
          width: 15,
          height: 15,
          top: 5,
          right: 5,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              myCartIndicator,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
