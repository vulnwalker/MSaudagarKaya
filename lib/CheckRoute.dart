import 'package:flutter/material.dart';
import 'package:SaudagarKaya/config.dart';
import 'package:SaudagarKaya/utils/uidata.dart';
import 'package:SaudagarKaya/database/DatabaseHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:SaudagarKaya/database/model/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckRoute extends StatefulWidget {
  var databaseHelper = new  DatabaseHelper() ;
  @override
  _CheckRouteState createState() => _CheckRouteState();
}

class _CheckRouteState extends State<CheckRoute> {
  ConfigClass configClass = new ConfigClass();
  String emailMember = "test";
  var databaseHelper = new  DatabaseHelper() ;
  void getDataAccount() async{
    var dbClient = await databaseHelper.db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM tabel_account');
    emailMember = list[0]["email"];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    prefs.setString('sessionEmail',emailMember);
  }
  @override
  void initState(){
    super.initState();
    (() async {
      
      this.widget.databaseHelper.initDb();
      var statusLogin =  await this.widget.databaseHelper.accountRowCount() ;
      print("Row Count" + statusLogin.toString());
      if(statusLogin == 0){
        Navigator.of(context).pushReplacementNamed("welcomePage");
      }else{
        Navigator.of(context).pushReplacementNamed("mainPage");
        var dbClient = await databaseHelper.db;
        List<Map> list = await dbClient.rawQuery('SELECT * FROM tabel_account');
        emailMember = list[0]["email"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('sessionEmail',emailMember);
        await http.post(configClass.profile(), body: {"email" : emailMember}).then((response) {
          var extractdata = JSON.jsonDecode(response.body);
          List dataResult;
          dataResult = extractdata["result"];
          prefs.setString('sessionNama',dataResult[0]["content"][0]['nama'].toString());
          prefs.setString('sessionGambar',dataResult[0]["content"][0]['foto'].toString());
        });
       
      }
    })();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0,),
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(
                      backgroundColor: Colors.black,
                  ),
                  new Text("LOADING ..")
                ],
              )
                      
            ),

            
          ],
        ),
      )
    );
  }
}