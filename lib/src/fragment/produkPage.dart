import 'package:SaudagarKaya/src/fragment/detailProdukPage.dart';
import 'package:flutter/material.dart';
import 'package:SaudagarKaya/logic/bloc/ProdukBloc.dart';
import 'package:SaudagarKaya/model/ProdukModel.dart';
import 'package:SaudagarKaya/ui/widgets/common_scaffold.dart';
import 'package:flushbar/flushbar.dart';
import 'package:SaudagarKaya/config.dart';
import 'package:SaudagarKaya/utils/uidata.dart';
import 'package:http/http.dart' as http;
import 'package:SaudagarKaya/database/DatabaseHelper.dart';
import 'dart:convert' as JSON;
import 'package:SaudagarKaya/database/model/account.dart';
import 'package:firebase_admob/firebase_admob.dart';
const APP_ID = "<Put in your Device ID>";
class ProdukPage extends StatefulWidget {
  @override
  ProdukPageState createState() {
    return new ProdukPageState();
  }
}

class ProdukPageState extends State<ProdukPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Size deviceSize;
  String email,password,passwordConfirm,nama,nomorTelepon = "";
  String oldEmail ;
  String publicAdsName ;
  int saldoMember;
  ConfigClass configClass = new ConfigClass();
  var databaseHelper = new  DatabaseHelper() ;
  


  @override
  void initState() {
    super.initState();
    (() async {
      // var asu = await getDataAccount();
      setState(() {
      });
    })();

  
  }

  
  // void getDataAccount() async{
  //   var dbClient = await databaseHelper.db;
  //       List<Map> list = await dbClient.rawQuery('SELECT * FROM tabel_account');
  //       email = list[0]["email"];
  //       nama = list[0]["nama"];
  //       oldEmail = list[0]["email"];
  //       password = list[0]["password"];
  //       passwordConfirm = list[0]["password"];
  //       nomorTelepon = list[0]["nomor_telepon"]; 
  //       saldoMember = list[0]["saldo"]; 
  // }
  //stack1
  Widget imageStack(String img) => Image.network(
        img,
        fit: BoxFit.fill,
      );

  //stack2
  Widget descStack(ProdukModel produkModel) => Positioned(
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    produkModel.nama_produk,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text(produkModel.price,
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      );
  Widget namaProdukStack(ProdukModel produkModel) => Positioned(
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    produkModel.nama_produk,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                // Text(produkModel.price,
                //     style: TextStyle(
                //         color: Colors.yellow,
                //         fontSize: 10.0,
                //         fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      );

  //stack3
  Widget ratingStack(String rating) => Positioned(
        top: 0.0,
        left: 0.0,
        child: Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.star,
                color: Colors.cyanAccent,
                size: 10.0,
              ),
              SizedBox(
                width: 2.0,
              ),
              Text(
                rating.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              )
            ],
          ),
        ),
      );
  Widget priceStack(String rating) => Positioned(
        top: 0.0,
        left: 0.0,
        child: Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))),
          child: Row(
            children: <Widget>[
              // Icon(
              //   Icons.attach_money,
              //   color: Colors.cyanAccent,
              //   size: 10.0,
              // ),
              Text(
                "Harga",
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              ),
              SizedBox(
                width: 2.0,
              ),
              Text(
                rating.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              )
            ],
          ),
        ),
      );
  Widget profitStack(String rating) => Positioned(
        top: 0.0,
        right: 0.0,
        child: Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0))),
          child: Row(
            children: <Widget>[
              // Icon(
              //   Icons.attach_money,
              //   color: Colors.cyanAccent,
              //   size: 10.0,
              // ),
              Text(
                "Profit",
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              ),
              SizedBox(
                width: 2.0,
              ),
              Text(
                rating.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              )
            ],
          ),
        ),
      );

  Widget produkListGrid(List<ProdukModel> produkModelModels,context) => GridView.count(
        crossAxisCount: 1,
        shrinkWrap: true,
        children: produkModelModels
            .map((produkModel) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    splashColor: Colors.yellow,
                    onTap: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new DetailProdukPage(produkModel.id_produk),
                                )),
                    child: Material(
                      elevation: 2.0,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          imageStack(produkModel.image),
                          namaProdukStack(produkModel),
                          priceStack(produkModel.price),
                          profitStack(produkModel.profit),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      );

  Widget bodyData(context) {
    ProdukListBloc produkModelBloc = ProdukListBloc();
    return StreamBuilder<List<ProdukModel>>(
        stream: produkModelBloc.produkListItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? produkListGrid(snapshot.data,context)
              : Center(child: CircularProgressIndicator());
        });
  }


  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      scaffoldKey: scaffoldKey,
      appTitle: "Shop",
      showDrawer: true,
      showFAB: false,
      actionFirstIcon: Icons.shopping_cart,
      bodyData: bodyData(context),
    );
  }
  // Widget _scaffold() => CommonScaffold(
  //       appTitle: "Profile",
  //       bodyData: bodyData(context),
  //       showFAB: true,
  //       showDrawer: true,
  //       floatingIcon: Icons.edit,
  //       eventFloatButton: (){
  //         // AlertDialog dialog = new AlertDialog(
  //         //               content: new Text("Reload Activity")
  //         //             );
  //         // showDialog(context: context,child: dialog);
  //         Navigator.of(context).pushNamed(UIData.editProfileRoute);
  //       },
  //     );
  // @override
  // Widget build(BuildContext context) {
  //   // getDataAccount();
  //   deviceSize = MediaQuery.of(context).size;
  //   return _scaffold();
  // }
}
