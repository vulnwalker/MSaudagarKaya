import 'dart:async';
import 'dart:convert' as JSON;
import 'package:SaudagarKaya/config.dart';
import 'package:SaudagarKaya/database/DatabaseHelper.dart';
import 'package:http/http.dart' as http;
import 'package:SaudagarKaya/model/ProdukModel.dart';

class ProdukListBloc {
  final produkListController = StreamController<List<ProdukModel>>();
  Stream<List<ProdukModel>> get produkListItems => produkListController.stream;
  ConfigClass configClass = new ConfigClass();
  var databaseHelper = new  DatabaseHelper();
  String email = "dndini@gmail.com";
  // void getDataAccount() async{
  //   var dbClient = await databaseHelper.db;
  //       List<Map> list = await dbClient.rawQuery('SELECT * FROM tabel_account');
  //       email = list[0]["email"];
  // }
  ProdukListBloc() {
      List dataResult;
      List dataContent;
      List<ProdukModel> kolom = [];
      // getDataAccount();

      (() async {
        await http.post(configClass.produkList(), body: {"email":email}).then((response) {
            kolom = [];
            var extractdata = JSON.jsonDecode(response.body);
            dataResult = extractdata["result"];
            dataContent = dataResult[0]["content"];
            for (var i = 0; i < dataContent.length; i++) {
               kolom.add( 
                  ProdukModel(
                          id_produk: dataContent[i]['id'],
                          nama_produk: dataContent[i]['nama_produk'],
                          price: dataContent[i]['harga'],
                          description: dataContent[i]['deskripsi'],
                          image:dataContent[i]['main_image'],
                          profit: dataContent[i]['profit'],
                      )
                );     
              
            }
          
          
        });
        getTukarPoints()  => kolom;
        produkListController.add(getTukarPoints());

      })();
     
      
  }
}
