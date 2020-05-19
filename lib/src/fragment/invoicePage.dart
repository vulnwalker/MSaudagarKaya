import 'package:SaudagarKaya/database/DatabaseHelper.dart';
import 'package:SaudagarKaya/ui/widgets/common_scaffold.dart';
/**
 * Author: Sudip Thapa  
 * profile: https://github.com/sudeepthapa
  */

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class InvoicePage extends StatefulWidget {
  InvoicePage({Key key}) : super(key: key);
  static final String path = "lib/src/pages/lists/list2.dart";

  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);
  final scaffoldKey = GlobalKey<ScaffoldState>();
    ConfigClass configClass = new ConfigClass();
  var databaseHelper = new  DatabaseHelper() ;
  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  var db = new DatabaseHelper();
  final TextStyle whiteText = TextStyle(color: Colors.white);



  @override
  Widget build(BuildContext context) {

    return CommonScaffold(
      scaffoldKey: scaffoldKey,
      appTitle: "Invoice",
      showDrawer: true,
      showFAB: false,
      actionFirstIcon: Icons.shopping_cart,
      bodyData: FutureBuilder(
              future: getDataInvoice(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return bodyData(snapshot.data);
                } else {
                  return Center (
                      child: CircularProgressIndicator()
                  );
                }
              },
            ),
    );
    
  }

  Widget bodyData(Container listInvoice){

  return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              listInvoice, 
            ],
          ),
        ),
      );
}

  Future<Widget> getDataInvoice() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var dbClient = await db.db;
     var listWidget = <Widget>[];
      await http.post(configClass.invoiceList(), body: {"email" : prefs.getString('sessionEmail').toString()}).then((response) {
        // print(response.body);
        var extractdata = JSON.jsonDecode(response.body);
        List dataResult;
        String err,cek;
        dataResult = extractdata["result"];
        List<dynamic> dataContent = dataResult[0]["content"];
        var warnaStatus = Colors.orangeAccent;
        for (var i = 0; i < dataContent.length; i++) {
          if(dataContent[i]['status'].toString() == "BELUM BAYAR"){
            warnaStatus = Colors.redAccent;
          }else if(dataContent[i]['status'].toString() == "TERKONFIRMASI"){
            warnaStatus = Colors.greenAccent;
          }else if(dataContent[i]['status'].toString() == "SELESAI"){
            warnaStatus = Colors.blueAccent;
          }
          listWidget.add(
            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          height: 110,
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  // border: Border.all(width: 3, color: secondary),
                                   
                                ), 
                                child: Image.asset(
                                            'assets/shopping.png',
                                            fit: BoxFit.cover,
                                            width: 40,
                                            height: 40,
                                          ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      dataContent[i]['nama_pembeli'],
                                      style: TextStyle(
                                          color: primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(dataContent[i]['tanggal'],
                                            style: TextStyle(
                                                color: primary, fontSize: 13, letterSpacing: .3)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(4.0),
                                          height: 20.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4.0),
                                            color: warnaStatus
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text(
                                                dataContent[i]['status'],
                                                style:
                                                    whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 10.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Align(
                                                alignment: Alignment.centerRight,
                                                child: Container(
                                                  child: Text(
                                                      "#"+dataContent[i]['id'],
                                                     textAlign: TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                         
                                      ]
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
          );
        }
       } );
     
    return Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: ListView(
                  children: listWidget,
                )
              )
    ;
  
}

}