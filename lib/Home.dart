import 'package:flutter/material.dart';
import 'package:flutternaaniz/widget/ReusableScreen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutternaaniz/widget/loading.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  String data;

  Future getdata() async
  {
    data = await rootBundle.loadString('assets/order.json');
    print(data);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState;
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: new AppBar(
            backgroundColor: Colors.red[700],
            title: new Text("Home",
              style: new TextStyle(color: Colors.white),
            ),
          ),
          body: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) =>
                          ReusableScreen(screenTitle: "Pickup",
                            data: data,
                          )));
                },
                child: Text("Pickup"),

              ), RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) =>
                          ReusableScreen(screenTitle: "Delivery",
                            data: data,
                          )));
                },
                child: Text("Delivery"),
              ), RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) =>
                          ReusableScreen(screenTitle: "Track",
                            data: data,
                          )));
                },
                child: Text("Track"),
              ),
            ],
          ))
      );
    }
    else {
return Loading();
    }
  }
}
