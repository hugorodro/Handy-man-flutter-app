import 'package:flutter/material.dart';
import 'package:lunacon_app/data/status_module.dart';
import 'orderStatusDetailsScreen.dart';
import 'package:lunacon_app/data/jobSite_module.dart';
import 'package:lunacon_app/models/order.dart';

class OrderStatusScreen extends StatefulWidget {
  @override
  _OrderStatusScreenState createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  @override
  void initState() {
    super.initState();
    loadProductOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context, '/Order');
              },
            ),
            Expanded(
              child: Container(
                  child: Text(
                'Order status',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              )),
            ),
            SizedBox(
              width: 35,
            ),
            // Icon(
            //   Icons.book,
            //   color: Colors.white,
            // ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: getOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Order anOrder = snapshot.data[index];
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(anOrder.date.toString()),
                      subtitle: Column(
                        children: <Widget>[
                          Text(getJS(anOrder.jobSite).name),
                        ],
                      ),
                      trailing: Text(snapshot.data[index].getStatus()),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrderStatusDetailsScreen(snapshot.data[index]),
                          ),
                        );
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Container(
            height: 60.0,
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
