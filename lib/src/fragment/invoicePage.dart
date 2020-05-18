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

  final List<Map> InvoicePages = [
    {
      "name": "Edgewick Scchol",
      "location": "572 Statan NY, 12483",
      "type": "Higher Secondary School",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/03/16/21/18/logo-2150297_960_720.png"
    },
    {
      "name": "Xaviers International",
      "location": "234 Road Kathmandu, Nepal",
      "type": "Higher Secondary School",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/01/31/13/14/animal-2023924_960_720.png"
    },
    {
      "name": "Kinder Garden",
      "location": "572 Statan NY, 12483",
      "type": "Play Group School",
      "logoText":
          "https://cdn.pixabay.com/photo/2016/06/09/18/36/logo-1446293_960_720.png"
    },
    {
      "name": "WilingTon Cambridge",
      "location": "Kasai Pantan NY, 12483",
      "type": "Lower Secondary School",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/01/13/01/22/rocket-1976107_960_720.png"
    },
    {
      "name": "Fredik Panlon",
      "location": "572 Statan NY, 12483",
      "type": "Higher Secondary School",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/03/16/21/18/logo-2150297_960_720.png"
    },
    {
      "name": "Whitehouse International",
      "location": "234 Road Kathmandu, Nepal",
      "type": "Higher Secondary School",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/01/31/13/14/animal-2023924_960_720.png"
    },
    {
      "name": "Haward Play",
      "location": "572 Statan NY, 12483",
      "type": "Play Group School",
      "logoText":
          "https://cdn.pixabay.com/photo/2016/06/09/18/36/logo-1446293_960_720.png"
    },
    {
      "name": "Campare Handeson",
      "location": "Kasai Pantan NY, 12483",
      "type": "Lower Secondary School",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/01/13/01/22/rocket-1976107_960_720.png"
    },
  ];

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
        for (var i = 0; i < dataContent.length; i++) {
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
                                  border: Border.all(width: 3, color: secondary),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider("https://cdn.pixabay.com/photo/2017/03/16/21/18/logo-2150297_960_720.png"),
                                      fit: BoxFit.fill),
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
                                        Icon(
                                          Icons.location_on,
                                          color: secondary,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Lokasi",
                                            style: TextStyle(
                                                color: primary, fontSize: 13, letterSpacing: .3)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.school,
                                          color: secondary,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Type",
                                            style: TextStyle(
                                                color: primary, fontSize: 13, letterSpacing: .3)),
                                      ],
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
                // padding: EdgeInsets.only(top: 145),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: ListView(
                  children: listWidget,
                )
              )
    ;
  
}

}