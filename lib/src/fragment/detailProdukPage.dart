import 'dart:typed_data';

import 'package:SaudagarKaya/database/model/cart.dart';
import 'package:SaudagarKaya/model/product.dart';
import 'package:SaudagarKaya/src/fragment/cartPage.dart';
import 'package:SaudagarKaya/ui/widgets/custom_float.dart';
import 'package:SaudagarKaya/ui/widgets/label_icon.dart';
import 'package:SaudagarKaya/ui/widgets/login_background.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:SaudagarKaya/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show base64, jsonDecode, utf8;
import 'package:SaudagarKaya/database/DatabaseHelper.dart';
import 'package:SaudagarKaya/database/model/account.dart';
import 'package:SaudagarKaya/utils/uidata.dart';
import 'package:SaudagarKaya/ui/page/home_page.dart';
import 'dart:async';
import 'package:SaudagarKaya/ui/widgets/common_divider.dart';
import 'package:SaudagarKaya/ui/widgets/common_scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
// import 'package:firebase_admob/firebase_admob.dart';


ConfigClass configClass = new ConfigClass();
class DetailProdukPage extends StatefulWidget { 
 final String id_produk;
 
   DetailProdukPage(this.id_produk) ;
  @override
   DetailProdukPageState createState() => new DetailProdukPageState();
}

class DetailProdukPageState extends State<DetailProdukPage> {
  Size deviceSize;
  VideoPlayerController _controller;
  String namaProduk,deskripsiProduk,hargaProduk,mainImage,profitProduk;
  List sourceMedia;
  String emailMember = "0";
  String totalCart = "0";
  ConfigClass configClass = new ConfigClass();
  var db = new DatabaseHelper();
  final _scaffoldState = GlobalKey<ScaffoldState>();
  int jumlahTambahCart = 0;
  Future<String> getDataProduk() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     emailMember = prefs.getString('sessionEmail');
     return await http.post(configClass.produkDetail(), body: {"email" : emailMember,"id_produk" : widget.id_produk}).then((response) {
          print(response.body);
          return response.body;
    });
   }
  Future<void> refreshCart () async {
        var dbClient = await db.db;
        List<Map> list = await dbClient.rawQuery('SELECT sum(jumlah) FROM cart');
        if(list.length == 0){
          totalCart = "0";
        }else{
          totalCart = list[0]["sum(jumlah)"].toString();
        }
         setState(() {
         });
  }
  @override
  void initState() {
    super.initState();
    (() async {
      refreshCart();
    
   
      
    })();
  
  }
  @override
  void dispose() {
    super.dispose();
  }

  Widget generateImage(String mediaData, String typeMedia){
    // List dataMedia = jsonDecode(mediaData);
    // return Text(mediaData, style: TextStyle(fontSize: 16.0));
    Widget returnMedia ;
    if(typeMedia == "GAMBAR"){
      returnMedia = Image.network(
        mediaData,
        fit: BoxFit.fill,
      );
    }else{
      VideoPlayerController _videoPlayerController1;
      VoidCallback listener;
      ChewieController _chewieController;
       _videoPlayerController1 = VideoPlayerController.network(mediaData)
        ..addListener(listener)
        ..setVolume(1)
        ..initialize();
      // _videoPlayerController1 = VideoPlayerController.network(
      // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
      // ..addListener(listener)
      //         ..setVolume(1)
      //         ..initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController1,
        aspectRatio: 3 / 2,
        autoPlay: false,
        looping: false,
      );
      returnMedia =  Chewie( controller: _chewieController);
    }
    return  returnMedia;
  }

   Widget mainCard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  namaProduk,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    LabelIcon(
                      icon: Icons.star,
                      iconColor: Colors.cyan,
                      label: profitProduk,
                    ),
                    Text(
                      hargaProduk,
                      style: TextStyle(
                          color: Colors.orange.shade800,
                          fontWeight: FontWeight.w700,
                          fontSize: 25.0),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );

  Widget imagesCard() => SizedBox(
        height: deviceSize.height / 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Card(
            elevation: 2.0,
            child: 
            CarouselSlider(
            height: 200.0,
            items: sourceMedia.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.amber
                    ),
                    child: generateImage(i["sourceMedia"].toString(),i["type"].toString())
                    
                  );
                },
              );
            }).toList(),
          ),
           
          ),
        ),
      );

  Widget descCard() => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  deskripsiProduk,
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      );
  

 

  Widget quantityCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text(
        //   "",
        //   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
        // ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CustomFloat(
              tag:"buttonMin",
              isMini: true,
              icon: FontAwesomeIcons.minus,
              qrCallback: (){
                setState(() {
                  jumlahTambahCart = jumlahTambahCart - 1;
                });
              },
            ),
            Text(
                    jumlahTambahCart.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                  ),
            CustomFloat(
              tag:"buttonPlus",
              isMini: true,
              icon: FontAwesomeIcons.plus,
              qrCallback: (){
                setState(() {
                  jumlahTambahCart = jumlahTambahCart + 1;
                });
              },
            ),
          ],
        )
      ],
    );
  }
  Widget actionCard() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // colorsCard(),
                    // CommonDivider(),
                    SizedBox(
                      height: 5.0,
                    ),
                    // sizesCard(),
                    // CommonDivider(),
                    SizedBox(
                      height: 5.0,
                    ),
                    quantityCard(),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                )
            ),
      ),
    );

  Widget bodyData(){
    return
    Stack(
      fit: StackFit.expand,
      children: <Widget>[
        LoginBackground(
          showIcon: false,
          image: mainImage,
        ),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: deviceSize.height / 4,
              ),
              mainCard(),
              imagesCard(),
              descCard(),
              actionCard(),
            ],
          ),
        )
      ],
    );
  }

  Widget myBottomBar() => new BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Ink(
          height: 50.0,
          decoration: new BoxDecoration(
              gradient: new LinearGradient(colors: UIData.kitGradients)),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: double.infinity,
                child: new InkWell(
                  radius: 10.0,
                  splashColor: Colors.yellow,
                  onTap: () {
                    Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new CartPage(),
                                ));

                  },
                  child: Center(
                    child: new Text(
                      "CHECK OUT",
                      style: new TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              new SizedBox(
                width: 20.0,
              ),
              SizedBox(
                height: double.infinity,
                child: new InkWell(
                  // onTap: () {},
                  radius: 10.0,
                  splashColor: Colors.yellow,
                  child: Center(
                    // child: new Text(
                    //   "ORDER PAGE",
                    //   style: new TextStyle(
                    //       fontSize: 12.0,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white),
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  Widget CommonScaffoldCart(){
    return 
     Scaffold(
      key: _scaffoldState,
      backgroundColor: null,
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.black,
        title: Text("Detail Produk"),
        actions: <Widget>[
          SizedBox(
            width: 5.0,
          ),
          
        ],
      ),
      drawer: null,
      body: FutureBuilder(
              future: getDataProduk(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var extractdata = jsonDecode(snapshot.data);
                    List dataResult;
                    dataResult = extractdata["result"];
                    namaProduk =  dataResult[0]["content"][0]['nama_produk'].toString();
                    deskripsiProduk =  dataResult[0]["content"][0]['deskripsi'].toString();
                    hargaProduk =  dataResult[0]["content"][0]['harga'].toString();
                    mainImage =  dataResult[0]["content"][0]['main_image'].toString();
                    profitProduk =  dataResult[0]["content"][0]['profit'].toString();
                    sourceMedia = jsonDecode(dataResult[0]["content"][0]['media'].toString());
                  return bodyData();
                } else {
                  return Center (
                      child: CircularProgressIndicator()
                  );
                }
              },
            ),
      floatingActionButton:  CustomFloat(
              tag:"addCart",
              builder: Text(
                      totalCart,
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
              icon: Icons.add_shopping_cart,
              qrCallback: () async {
                    var dbClient = await db.db;
                    List<Map> rowCount = await dbClient.rawQuery('SELECT * FROM cart where id_produk ="'+widget.id_produk +'"');
                    if(rowCount.length == 0){
                      var dataCart = new Cart(
                        widget.id_produk,
                        int.parse(hargaProduk.replaceAll('.', '')),
                        jumlahTambahCart,
                        int.parse(hargaProduk.replaceAll('.', '')) * jumlahTambahCart,
                      );
                      db.saveCart(dataCart);
                    }else{
                      await dbClient.rawQuery("update cart set jumlah = '"+jumlahTambahCart.toString()+"', sub_total ='"+( int.parse(hargaProduk.replaceAll('.', '')) * jumlahTambahCart ).toString() +"' where id_produk = '"+widget.id_produk+"'");
                    }
                    
                    refreshCart();
                    AlertDialog dialog = new AlertDialog(
                      content: new Text("Cart Added")
                    );
                    showDialog(context: context,child: dialog);
              }
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: myBottomBar(),
    );
  }
  // Widget _scaffold() => CommonScaffoldCart(
  //       appTitle: "Detail Produk",
  //       bodyData: FutureBuilder(
  //             future: getDataProduk(),
  //             builder: (context, snapshot) {
  //               if (snapshot.hasData) {
  //                 var extractdata = jsonDecode(snapshot.data);
  //                   List dataResult;
  //                   dataResult = extractdata["result"];
  //                   namaProduk =  dataResult[0]["content"][0]['nama_produk'].toString();
  //                   deskripsiProduk =  dataResult[0]["content"][0]['deskripsi'].toString();
  //                   hargaProduk =  dataResult[0]["content"][0]['harga'].toString();
  //                   mainImage =  dataResult[0]["content"][0]['main_image'].toString();
  //                   profitProduk =  dataResult[0]["content"][0]['profit'].toString();
  //                   sourceMedia = jsonDecode(dataResult[0]["content"][0]['media'].toString());
  //                 return bodyData();
  //               } else {
  //                 return Center (
  //                     child: CircularProgressIndicator()
  //                 );
  //               }
  //             },
  //           ),
  //       showFAB: true,
  //       scaffoldKey: _scaffoldState,
  //       centerDocked: true,
  //       floatingIcon: Icons.add_shopping_cart,
  //       showBottomNav: true,
  //       // showDrawer: true,
  //     );

  Widget _scaffold() => CommonScaffoldCart();


  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return _scaffold();
  }

}
