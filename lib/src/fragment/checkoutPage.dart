

import 'package:SaudagarKaya/config.dart';
import 'package:SaudagarKaya/database/DatabaseHelper.dart';
import 'package:SaudagarKaya/ui/widgets/common_scaffold.dart';

  
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'package:url_launcher/url_launcher.dart';
ConfigClass configClass = new ConfigClass();
class CheckoutPage extends StatefulWidget{
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var db = new DatabaseHelper();

  final String address = "Chabahil, Kathmandu";

  final String phone="9818522122";

  final double total = 500;
  String jasaExpedisi;
  int costOngkir = 0;
  
  int subTotal = 0;
  String stringJsonProvinsi;
  String stringJsonKota;
  String stringJsonService;
  List listProvinsi;
  List listKota = [{"city_id" : "-","city_name" : "0" }];
  String provinsiSelected;
  String kotaSelected;
  String serviceSelected;
  String alamatPengiriman = "";
  String emailMember = "";
  String nomorTelepon = "";
  String namaPembeli = "";
  String emailPembeli = "";
  String kodePos = "";
  String kecamatanPembeli = "";
  int beratBarang = 250;
  String servicePengiriman = "" ;
  String keterangan = "" ;
  List listService = [{"service" : "-","value" : "0" }];
  Future<String> get getDataCart async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emailMember = prefs.getString('sessionEmail').toString();
    var dbClient = await db.db;
    List<Map> dataCart = await dbClient.rawQuery("select sum(sub_total) from cart");
    subTotal = dataCart[0]["sum(sub_total)"];
    List<Map> listCart = await dbClient.rawQuery("select * from cart");
    String implodeIdAndJumlah = "";
    for (var a = 0; a < listCart.length; a++) {
      implodeIdAndJumlah = implodeIdAndJumlah + ";" + listCart[a]["id_produk"].toString() + "," + listCart[a]["jumlah"].toString() ;
    }
    await http.post(configClass.getWeight(), body: {"implodeIdAndJumlah" : implodeIdAndJumlah }).then((response) {
      var extractdata = JSON.jsonDecode(response.body);
      List dataResult;
      dataResult = extractdata["result"];
      beratBarang = dataResult[0]["content"]['beratBarang'];
    });
    await http.post(configClass.getProvinsi(), body: {"email" : prefs.getString('sessionEmail').toString(),"servicePengiriman" : "" }).then((response) {
        var extractdata = JSON.jsonDecode(response.body);
        List dataResult;
        dataResult = extractdata["result"];
        Map<String, dynamic> dataContent = JSON.jsonDecode(dataResult[0]["content"]);
        listProvinsi = JSON.jsonDecode(dataContent["provinsi"]);
        stringJsonProvinsi = dataContent["provinsi"];
    });
    return subTotal.toString();
  }

  @override
  Widget build(BuildContext context) {
    var context3 = context;
    return CommonScaffold(
      scaffoldKey: scaffoldKey,
      appTitle: "Checkout",
      showDrawer: false,
      showFAB: false,
      bodyData: FutureBuilder(
              future: getDataCart,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _buildBody(context3);
                } else {
                  return Center (
                      child: CircularProgressIndicator()
                  );
                }
              },
            ),
    );
  }

  Future<void> setJasaExpedisi(String val) async {
    await http.post(configClass.getService(), body: {"layananPengiriman" : val,"beratBarang" : beratBarang.toString(),"idProvinsi" : provinsiSelected, "idKota" :kotaSelected }).then((response) {
        var extractdata = JSON.jsonDecode(response.body);
        List dataResult;
        dataResult = extractdata["result"];
        Map<String, dynamic> dataContent = JSON.jsonDecode(dataResult[0]["content"]);
        List listBiaya = JSON.jsonDecode(dataContent["biaya"]);
        stringJsonService = dataContent["biaya"];
        listService = [];
        List<dynamic> costsOngkir = listBiaya[0]["costs"];
        for (var i = 0; i < costsOngkir.length; i++) {
         print(costsOngkir[i]["service"].toString());
         listService.add(
           {
             "service" : costsOngkir[i]["service"].toString()+ " ( "+costsOngkir[i]["cost"][0]["etd"].toString()+" )",
             "value" : costsOngkir[i]["cost"][0]["value"].toString(),
             }
           );
        }
        setState(() {
            jasaExpedisi = val;
        });     
            
    });
     
  }
  Widget _buildBody(BuildContext context)  {
    final formatter = new NumberFormat("#,###");
    final TextEditingController alamatPengirimanController = new TextEditingController();
    final TextEditingController nomorTeleponController = new TextEditingController();
    return SingleChildScrollView(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Sub Total"),
                  Text(formatter.format(subTotal)),
                ],
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Ongkir"),
                  Text(formatter.format(costOngkir)),
                ],
              ),
              SizedBox(height: 10.0,),  
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total", style: Theme.of(context).textTheme.title,),
                  Text("Rp. "+formatter.format(subTotal+costOngkir)+"", style: Theme.of(context).textTheme.title),
                ],
              ),
              SizedBox(height: 20.0,),
              Container(
                color: Colors.grey.shade200,
                padding: EdgeInsets.all(8.0),
                width: double.infinity,
                child: Text("Pengiriman".toUpperCase()) 
              ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10,top: 10),
                    height: 50.0,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Colors.blueGrey)),
                              child: DropdownButton<String>(
                              hint: Text("PROVINSI"),
                              isExpanded: true,
                              value: provinsiSelected == null ? null : provinsiSelected,
                              items: listProvinsi.map((value) {
                                  return new DropdownMenuItem<String>(
                                    value: value["province_id"],
                                    child: new Text(value["province"]),
                                  );
                                }).toList(),
                                onChanged: (String selectedValue) async {
                                  provinsiSelected = selectedValue;
                                  await http.post(configClass.getKota(), body: {"idProvinsi" : selectedValue,"servicePengiriman" : "" }).then((response) {
                                     //empty
                                         kotaSelected = null;
                                         listKota =[{"city_id" : "-","city_name" : "0" }];
                                         jasaExpedisi = null;
                                         listService = [{"service" : "-","value" : "0" }];
                                         serviceSelected = null;   
                                      //empty

                                      var extractdata = JSON.jsonDecode(response.body);
                                      List dataResult;
                                      dataResult = extractdata["result"];
                                      Map<String, dynamic> dataContent = JSON.jsonDecode(dataResult[0]["content"]);
                                      listKota = JSON.jsonDecode(dataContent["kota"]);
                                      stringJsonKota = dataContent["kota"];
                                      setState(()  { });
                                  });
                                },
                            ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10,top: 10),
                    height: 50.0,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Colors.blueGrey)),
                              child: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text("KOTA"),
                              value: kotaSelected == null ? null : kotaSelected,
                              items: listKota.map((value) {
                                  return new DropdownMenuItem<String>(
                                    value: value["city_id"],
                                    child: new Text(value['type'].toString() + " " + value["city_name"].toString()),
                                  );
                                }).toList(),
                                onChanged: (String selectedValue) async {
                                  //empty
                                      jasaExpedisi = null;
                                      listService = [{"service" : "-","value" : "0" }];
                                      serviceSelected = null;   
                                  //empty
                                  kotaSelected = selectedValue;
                                  setState(()  { });
                                },
                            ),
                  ),
                  
                  Container(
                    margin: EdgeInsets.only(bottom: 10,top: 10),
                    height: 50.0,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Colors.blueGrey)),
                        child: TextField(
                        // controller: alamatPengirimanController,
                        onChanged: (text) {
                          alamatPengiriman = text;
                        },
                        maxLines: 8,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration.collapsed(hintText: "Alamat"),
                    ) 
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10,top: 10),
                    height: 50.0,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Colors.blueGrey)),
                        child: TextFormField(
                            onChanged: (text) {
                                kecamatanPembeli = text;
                            },
                            decoration: InputDecoration(
                                // labelText:"whatever you want", 
                                hintText: "Kecamatan",
                            )
                        ) 
                  ),
                  TextFormField(
                      onChanged: (text) {
                          kodePos = text;
                      },
                      decoration: InputDecoration(
                          // labelText:"whatever you want", 
                          hintText: "Kode Pos",
                          icon: Icon(Icons.local_post_office)
                      )
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    color: Colors.grey.shade200,
                    padding: EdgeInsets.all(8.0),
                    width: double.infinity,
                    child: Text("Expedisi Pengiriman".toUpperCase())
                  ),
                  
                  RadioListTile(
                    groupValue: jasaExpedisi,
                    value: "jne",
                    title: Text("JNE"),
                    onChanged: (val) {
                      //empty
                          listService = [{"service" : "-","value" : "0" }];
                          serviceSelected = null;   
                      //empty
                      setJasaExpedisi(val);
                    },
                  ),
                  RadioListTile(
                    groupValue: jasaExpedisi,
                    value: "pos",
                    title: Text("POS"),
                    onChanged: (val) {
                      //empty
                          listService = [{"service" : "-","value" : "0" }];
                          serviceSelected = null;   
                      //empty
                      setJasaExpedisi(val);
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10,top: 10),
                    height: 50.0,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Colors.blueGrey)),
                              child: DropdownButton<String>(
                              hint: Text("SERVICE PENGIRIMAN"),
                              isExpanded: true,
                              value: serviceSelected == null ? null : serviceSelected,
                              items: listService.map((value) {
                                  return new DropdownMenuItem<String>(
                                    value: value["value"],
                                    child: new Text(value["service"]),
                                  );
                                }).toList(),
                                onChanged: (String selectedValue) async {
                                  servicePengiriman =  listService.toString();
                                  costOngkir = int.parse(selectedValue);
                                  serviceSelected = selectedValue;
                                  setState(()  { });
                                },
                            ),
                  ),
                  Container(
                    color: Colors.grey.shade200,
                    padding: EdgeInsets.all(8.0),
                    width: double.infinity,
                    child: Text("Contact".toUpperCase())
                  ),
                  TextFormField(
                      onChanged: (text) {
                          namaPembeli = text;
                      },
                     
                      decoration: InputDecoration(
                          // labelText:"whatever you want", 
                          hintText: "Nama Penerima",
                          icon: Icon(Icons.person)
                      )
                  ),
                  
                  TextFormField(
                      onChanged: (text) {
                          nomorTelepon = text;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          // labelText:"whatever you want", 
                          hintText: "Nomor Telepon",
                          icon: Icon(Icons.phone_iphone)
                      )
                  ),
                  TextFormField(
                      onChanged: (text) {
                          emailPembeli = text;
                      },
                      
                      decoration: InputDecoration(
                          // labelText:"whatever you want", 
                          hintText: "Email",
                          icon: Icon(Icons.email)
                      )
                  ),
                  TextFormField(
                      onChanged: (text) {
                          keterangan = text;
                      },
                      keyboardType: TextInputType.multiline,
                      
                      decoration: InputDecoration(
                          // labelText:"whatever you want", 
                          hintText: "Keterangan",
                          icon: Icon(Icons.description)
                      )
                  ),
                  SizedBox(height: 20.0,),
              Container(
                color: Colors.grey.shade200,
                padding: EdgeInsets.all(8.0),
                width: double.infinity,
                child: Text("Payment Option".toUpperCase())
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 80,
                    child  : Image.asset(
                        'assets/Logo_BCA.png',
                        width: 300.0,
                        height: 30.0,
                        // fit: BoxFit.cover,
                      ),
                      decoration: new BoxDecoration(color: Colors.transparent),
                      margin : EdgeInsets.zero,
                      padding: EdgeInsets.zero
                  ),
                  Container(
                    height: 40,
                    width: 80,
                    child  : Image.asset(
                        'assets/Logo_BRI.png',
                        width: 300.0,
                        height: 30.0,
                        // fit: BoxFit.cover,
                      ),
                      decoration: new BoxDecoration(color: Colors.transparent),
                      margin : EdgeInsets.only(left: 30),
                      padding: EdgeInsets.zero
                  ),
                  Container(
                    height: 40,
                    width: 80,
                    child  : Image.asset(
                        'assets/Logo_Mandiri.png',
                        width: 300.0,
                        height: 30.0,
                        // fit: BoxFit.cover,
                      ),
                      decoration: new BoxDecoration(color: Colors.transparent),
                      margin : EdgeInsets.only(left: 30,bottom: 10),
                      padding: EdgeInsets.zero
                  ),
                ]
              ),
              
              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {

                    configClass.showLoading(context);
                    var dbClient = await db.db;
                    List<Map> listCart = await dbClient.rawQuery("select * from cart");
                    await http.post(configClass.checkout(), body: {
                      "email" : emailMember,
                      "idProvinsi" : provinsiSelected, 
                      "idKota" : kotaSelected, 
                      "ongkir" : costOngkir.toString(),
                      "subTotal" : subTotal.toString(),
                      "alamatPengiriman" :alamatPengiriman,
                      "nomorTelepon" :nomorTelepon, 
                      "namaPembeli" :namaPembeli, 
                      "emailPembeli" :emailPembeli, 
                      "keterangan" :keterangan, 
                      "kecamatanPembeli" :kecamatanPembeli, 
                      "kodePos" :kodePos, 
                      "expedisiPengiriman" : jasaExpedisi.toString(), 
                      "servicePengiriman" : serviceSelected.toString(), 
                      "jsonProvinsiPengiriman" : stringJsonProvinsi.toString(), 
                      "jsonKotaPengiriman" : stringJsonKota.toString(), 
                      "jsonServicePengiriman" : stringJsonService.toString(), 
                      "cart" : JSON.jsonEncode(listCart), 
                      }).then((response) {
                      configClass.closeLoading(context);
                      // print(response.body);
                      var extractdata = JSON.jsonDecode(response.body);
                      List dataResult;
                      dataResult = extractdata["result"];
                      dbClient.rawQuery("delete from cart");
                      Navigator.of(context).pushReplacementNamed("mainPage");
                      launch("https://saudagarkaya.com/payment/"+dataResult[0]["content"]["idTransaksi"]);

                      print(dataResult[0]["content"]["idTransaksi"]);
                    });
                  },
                  child: Text("Confirm Order", style: TextStyle(
                    color: Colors.white
                  ),),
                ),
              )
            ]
        )
    );
  }
}