import 'package:progress_hud/progress_hud.dart';
import 'package:flutter/material.dart';
class ConfigClass {
  String app_name = "SaudagarKaya";
  String hostName ;
  
  String getHostName(){
    this.hostName = "https://api.saudagarkaya.com/";
    return this.hostName;
  }
  String auth(){
    return getHostName()+"auth";
  }
  String syncData(){
    return getHostName()+"member/info";
  }
  String memberCommision(){
    return getHostName()+"member/membership";
  }
  String produkList(){
    return getHostName()+"produk";
  }
  String produkDetail(){
    return getHostName()+"produk/detail";
  }
  String copyWritingList(){
    return getHostName()+"copyWriting";
  }
  String leadList(){
    return getHostName()+"leads";
  }
  String register(){
    return getHostName()+"member/add";
  }
  String profile(){
    return getHostName()+"member/sync";
  }
  String getProvinsi(){
    return getHostName()+"ongkir/getProvinsi";
  }
  String getKota(){
    return getHostName()+"ongkir/getKota";
  }
  String getService(){
    return getHostName()+"ongkir/getService";
  }
  String getWeight(){
    return getHostName()+"produk/getWeight";
  }
  String checkout(){
    return getHostName()+"checkout";
  }
  String invoiceList(){
    return getHostName()+"checkout/invoiceList";
  }
  String getDashboard(){
    return getHostName()+"member/dashboard";
  }

  
  var loadingScreen = new ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.white,
      containerColor: Colors.blue,
      borderRadius: 5.0,
      text: 'Loading...',
  );
  void showLoading(context){
    showDialog(
              context: context,
              child: this.loadingScreen
    );
  }
  void closeLoading(context){
      Navigator.pop(context);
  }




  // static Database databaseHelper;
  // Future<Database> get db async {
  //   if (databaseHelper != null) return databaseHelper;
  //   databaseHelper = await initDb();
  //   return databaseHelper;
  // }
  // initDb() async {
  //   io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   String path = join(documentsDirectory.path, "test.db");
  //   var theDb = await openDatabase(path, version: 1, onCreate: databaseSetup);
  //   return theDb;
  // }
  // void databaseSetup(Database db, int version) async{
  //   // When creating the db, create the table
  //   await db.execute("CREATE TABLE account (email text,nama text,saldo int(11),status int(11))");
  //   print("Created tables");
  // }
  // void sqlQuery(String query){
  //    databaseHelper.execute(query);
  // }


}