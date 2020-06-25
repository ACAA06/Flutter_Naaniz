import 'package:flutter/material.dart';
import 'package:flutternaaniz/widget/loading.dart';
import 'dart:convert' ;


class ReusableScreen extends StatefulWidget {
  final String screenTitle;
  final String data;

  ReusableScreen({
    @required this.screenTitle,
    @required this.data,
  });

  @override
  _ReusableScreenState createState() => _ReusableScreenState();
}

class _ReusableScreenState extends State<ReusableScreen> {
 bool isLoading=true;
 List parseddata,alldata;
 String ordercomplete;
 List<bool> condition;//Inner loop condition for Delivery and Pickup
  void builddata(String data){
    String myjson = data;
    alldata = jsonDecode(myjson);
    parseddata=[];
    condition=[];
    int j=0;
    if(widget.screenTitle=="Delivery"){
      ordercomplete="All current orders are Delivered!!!!";
    for(int i=0;i<alldata.length;i++) {
      if (!alldata[i]['delivered']&&alldata[i]['picked']) {
        parseddata.add(alldata[i]);
        condition.add(parseddata[j]['picked']&&!parseddata[j]['delivered']);
        j++;
      }
    }}
    else{
      if(widget.screenTitle=="Pickup")
        {
          ordercomplete="All current orders are picked!!!!";
          for(int i=0;i<alldata.length;i++) {
            if (!alldata[i]['picked']) {
              parseddata.add(alldata[i]);
              condition.add(!parseddata[j]['picked']);
              j++;
            }
          }
        }
    }
    setState(() {
      isLoading=false;
    });
  }
  @override
  void initState() {
    super.initState();
    builddata(widget.data);
  }
  @override
  Widget build(BuildContext context) {
    if(widget.data!=null){
      if(isLoading){ return Loading();}
      else{
        if(parseddata.length!=0)
        { return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: new AppBar(
              backgroundColor: Colors.red[700],
              title: new Text(widget.screenTitle,
                style: new TextStyle(color: Colors.white),
              ),
            ),
            body: ListView.builder
              (
                itemCount: parseddata.length ,
                itemBuilder: (BuildContext ctxt, int Index) {
                  if(condition[Index]) {
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.fromLTRB(10, 15, 10, 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(parseddata[Index]['itemname'],
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Open Sans',
                                    fontSize: 20),)
                            ],
                          ),
                          SizedBox(width: double.infinity,
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                child:
                                Text("Pickup Address",
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Open Sans',
                                      fontSize: 18),),),
                              GestureDetector(
                                  child: Text(
                                    parseddata[Index]['PickupAddress']['address'],
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'Open Sans',
                                        fontSize: 20),)),
                            ],
                          ),
                          SizedBox(width: double.infinity,
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('Contact',
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Open Sans',
                                    fontSize: 18),),
                              Text(parseddata[Index]['PickupAddress']['phonenumber']
                                  .toString(),
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Open Sans',
                                    fontSize: 20),)
                            ],
                          ),
                          SizedBox(width: double.infinity,
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.pin_drop),
                                  onPressed: () {
                                    setState(() {
                                      if(widget.screenTitle=="Pickup") {
                                        parseddata[Index]['picked'] = true;
                                        parseddata.removeAt(Index);
                                        condition.removeAt(Index);
                                        print(parseddata.length);
                                      }
                                      else{
                                        if(widget.screenTitle=="Delivery")
                                          {
                                            parseddata[Index]['delivered'] = true;
                                            parseddata.removeAt(Index);
                                            condition.removeAt(Index);

                                          }
                                      }
                                    });
                                  },
                                ),
                              ]
                          ),

                          SizedBox(width: double.infinity,
                            height: 30,
                          ),
                        ],
                      ),
                    );
                  }

                  else{
                    return Text("");
                  }
                }
            ));}
        else{
          return Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: new AppBar(
                backgroundColor: Colors.red[700],
                title: new Text("Pickup",
                  style: new TextStyle(color: Colors.white),
                ),
              ),
              body:Center(
                  child: Text(ordercomplete)));
        }
      }
    }
    else{
      return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: new AppBar(
          backgroundColor: Colors.red[700],
          title: new Text("Pickup",
            style: new TextStyle(color: Colors.white),
          ),
        ),
        body: Text("No data Available"),
      );
    }
  }

}

