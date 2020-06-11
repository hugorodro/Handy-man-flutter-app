import 'package:flutter/material.dart';
import 'package:lunacon_app/models/jobsite.dart';
import 'package:lunacon_app/models/order.dart';
import 'package:lunacon_app/data/network.dart';

class SupplyStatusScreen extends StatefulWidget {
  @override
  _SupplyStatusScreenState createState() => _SupplyStatusScreenState();
}

class _SupplyStatusScreenState extends State<SupplyStatusScreen> {
  final Future<List<Order>> myOrders = fetchMyOrders();
  List<JobSite> myJobSites;
  String name;

  @override
  void initState() {
    super.initState();
    myJobSites = [];
    getJobSites();
  }

  void getJobSites() async {
    myJobSites = await fetchJobSites();
  }

  Future<String> getJobSiteName(index) async {
    for (int i = 0; i < myJobSites.length; i++) {
      if (myJobSites[i].id == index) {
        return myJobSites[i].name;
      }
    }
    return '';
  }

  // String getJobSite(int index) {
  //     for (int i = 0; i < myJobSites; i++) {
  //       if (myJobSites[i].id == index){
  //         return myJobSites[i].name;
  //       }
  //     }
  //     return "";
  // }

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
                  Navigator.pop(context, '/supply');
                },
              ),
              Expanded(
                child: Container(
                    child: Text(
                  'Supply status',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.book,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
        body: FutureBuilder(
            future: myOrders,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(snapshot.data[index].date.toString()),
                          // subtitle: Text(getJobSite(snapshot.data[index])),
                          trailing: Text(snapshot.data[index].getStatus()),
                        ),
                        Divider(
                          color: Colors.grey,
                        )
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
            }));
  }
}
