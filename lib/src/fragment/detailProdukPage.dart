import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:SaudagarKaya/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show base64, jsonDecode, utf8;
import 'package:SaudagarKaya/database/DatabaseHelper.dart';
import 'package:SaudagarKaya/database/model/account.dart';
import 'package:SaudagarKaya/utils/uidata.dart';
import 'package:SaudagarKaya/ui/page/home_page.dart';
import 'dart:async';
import 'package:SaudagarKaya/ui/widgets/profile_tile.dart';
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
  String namaProduk,deskripsiProduk;
  List sourceMedia;
  String emailMember = "0";
  ConfigClass configClass = new ConfigClass();
  
  Future<String> getDataProduk() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     emailMember = prefs.getString('sessionEmail');
     return await http.post(configClass.produkDetail(), body: {"email" : emailMember,"id_produk" : widget.id_produk}).then((response) {
          print(response.body);
          return response.body;
    });
   }
  @override
  void initState() {
    super.initState();
    (() async {
        setState(() {
        });
    })();
  
  }
  @override
  void dispose() {
    super.dispose();
  }


   //Column1
  Widget headerProduk() => Container(
        height: deviceSize.height * 0.10,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              new Flexible(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      namaProduk,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  ],
                ),
              ),
           
          ],
        ),
      );

  //column2

  //column3

  
  Widget contentDetailProduk() => Container(
        height: deviceSize.height * 0.80,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: new SingleChildScrollView(
              child: new Center(
                child: Text(deskripsiProduk)
                // child: new HtmlView(data: "<b><h3>$judulBerita</h3> </b>"+"\n"+deskripsiProduk.toString()),
              ),
            ),
          ),
      );
  //column4
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

  Widget bodyData() { 
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          headerProduk(),
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
                    // child: Image.network(
                    //           sourceMedia[i]["sourceMedia"],
                    //           fit: BoxFit.fill,
                    //         )
                  );
                },
              );
            }).toList(),
          ),
          CommonDivider(),
          contentDetailProduk(),

          // accountColumn()
        ],
      ),
    );
  }

  Widget _scaffold() => CommonScaffold(
        appTitle: "Detail Produk",
        bodyData: FutureBuilder(
              future: getDataProduk(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var extractdata = jsonDecode(snapshot.data);
                    List dataResult;
                    dataResult = extractdata["result"];
                    namaProduk =  dataResult[0]["content"][0]['nama_produk'].toString();
                    deskripsiProduk =  dataResult[0]["content"][0]['deskripsi'].toString();
                    
                    sourceMedia = jsonDecode(dataResult[0]["content"][0]['media'].toString());

                    
                    // personalOmset =  dataResult[0]["content"][0]['omset_profit'].toString();
                    // teamProfit =  dataResult[0]["content"][0]['komisi_referal'].toString();
                    // teamOmset =  dataResult[0]["content"][0]['omset_referal'].toString();
                    // jumlahBarangTerjual =  int.parse(dataResult[0]["content"][0]['jumlah_barang_terjual']);
                    // totalProfit =  dataResult[0]["content"][0]['totalProfit'];
                    // persenToPremium =  double.parse(dataResult[0]["content"][0]['persenToPremium']);

                  // tampilkan dvarata
                  return bodyData();
                } else {
                  return Center (
                      child: CircularProgressIndicator()
                  );
                }
              },
            ),
        showFAB: false,
        // showDrawer: true,
        floatingIcon: Icons.edit,
        eventFloatButton: (){
          // AlertDialog dialog = new AlertDialog(
          //               content: new Text("Reload Activity")
          //             );
          // showDialog(context: context,child: dialog);
          Navigator.of(context).pushNamed(UIData.editProfileRoute);
        },
      );



  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return _scaffold();
  }

}
