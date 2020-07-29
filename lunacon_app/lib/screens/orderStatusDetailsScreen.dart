import 'package:flutter/material.dart';
import 'package:lunacon_app/data/status_module.dart';
// import 'package:lunacon_app/models/product_order.dart';
import 'package:lunacon_app/models/order.dart';

class OrderStatusDetailsScreen extends StatelessWidget {
  final Order myOrder;

  OrderStatusDetailsScreen(this.myOrder);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Order Details'),
      ),
      body: FutureBuilder(
        future: filterProductOrders(myOrder),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                print(snapshot.data);

                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        snapshot.data[index].myProduct.name,
                      ),
                      subtitle: Text(snapshot
                          .data[index].myProduct.priceEstimate
                          .toString()),
                      trailing:
                          Text(snapshot.data[index].myQuantity.toString()),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
