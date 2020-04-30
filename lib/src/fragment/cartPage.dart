
import 'package:SaudagarKaya/config.dart';
import 'package:SaudagarKaya/database/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

ConfigClass configClass = new ConfigClass();
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var screenWidth  ;
  var db = new DatabaseHelper();
  Widget bodyData(Column listCart){

  return SafeArea(
        child: Container(
          child: listCart
        ),

      );
}

Future<Column> getDataCart() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var dbClient = await db.db;
     var listWidget = <Widget>[];
        final formatter = new NumberFormat("#,###");

     listWidget.add(
      Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: <Widget>[
                      Text('Cart',style: TextStyle(fontSize: 20),),
                      Spacer()
                    ],
                  ),
                ),
          );
     listWidget.add(
        Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              child: Divider(
                thickness:2,
              )
          ),       
        );
  int totalBelanja = 0;
    
     List<Map> dataCart = await dbClient.rawQuery("select * from cart");
     for (var i = 0; i < dataCart.length; i++) {
      await http.post(configClass.produkDetail(), body: {"email" : prefs.getString('sessionEmail').toString(),"id_produk" : dataCart[i]['id_produk'].toString() }).then((response) {
        var extractdata = JSON.jsonDecode(response.body);
        List dataResult;
        List dataContent;
        String err,cek;
        dataResult = extractdata["result"];
        int jumlahBeli = dataCart[i]['jumlah'];
        listWidget.add(
        Container(
          margin: EdgeInsets.only(left: 10,),
          child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  dataResult[0]["content"][0]['main_image'].toString()))),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(dataResult[0]["content"][0]['nama_produk'].toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            "Harga : "+ dataResult[0]["content"][0]['harga'].toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                          Container(
                            child: Column(
                              
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(20)),
                                          child: GestureDetector(
                                              onTap: ()async{
                                                  jumlahBeli = jumlahBeli - 1;
                                                  await dbClient.rawQuery("update cart set jumlah = '"+jumlahBeli.toString()+"', sub_total ='"+( int.parse(dataResult[0]["content"][0]['harga'].replaceAll('.', '')) * jumlahBeli ).toString() +"' where id_produk = '"+dataCart[i]['id_produk']+"'");
                                                  setState(()  {
                                                    
                                                  });
                                              },
                                              child: Icon(
                                                Icons.remove_circle,
                                                color: Colors.white,
                                                size: 30,
                                              )),
                                    ),
                                  Container(
                                      margin: EdgeInsets.only(left: 6, right: 6),
                                      child: Text(
                                        jumlahBeli.toString(),
                                        style: TextStyle(
                                            fontSize: 20, fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: GestureDetector(
                                        onTap: ()async{
                                            jumlahBeli = jumlahBeli + 1;
                                            await dbClient.rawQuery("update cart set jumlah = '"+jumlahBeli.toString()+"', sub_total ='"+( int.parse(dataResult[0]["content"][0]['harga'].replaceAll('.', '')) * jumlahBeli ).toString() +"' where id_produk = '"+dataCart[i]['id_produk']+"'");
                                            setState(()  {
                                              
                                            });
                                        },
                                        child: Icon(
                                          Icons.add_circle,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        
                        Container(
                            margin: EdgeInsets.only(left: 100),
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text(
                                    "Total : ",
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Text(
                                    formatter.format(dataCart[i]['sub_total']),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ]
                          ),
                        )
                        ],
                      ),
                    ),
                    
                ],
              ),
          ),      
        );
         totalBelanja += dataCart[i]['sub_total'];

        listWidget.add(
          Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              child: Divider(
                thickness:2,
              )
          ), 
        );
      });
       
       
     }
     listWidget.add(
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Text(
                                    "Total : "+formatter.format(totalBelanja),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                                  ),
                                ),
                              ),
        ),
      );
     
     listWidget.add(
        Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: Divider(
              thickness:2,
            )
        ),
        
      );
     listWidget.add(
        Padding(
        padding: const EdgeInsets.only(left: 27,right: 27),
        child: RaisedButton(
              onPressed: (){

              },
              child: Text(
                "Check Out".toUpperCase(),
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white
                ),
              ),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.blue)
              ),
            )
      ),
        
      );
     
     
 
    return Column(
          
            children: <Widget>[
             Container(
              height: 59,
              width: screenWidth.width * 1.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios,size: 22,),
                    ),
                    Text('Shopping Cart',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 32,
                          width: 32,
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(20),
                          //     color: Colors.black
                          // ),
                        ),
                        
                      ],
                    )
                  ],
                ),
              ),
            ),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                height: 410,
                width: screenWidth.width * 1.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          spreadRadius: 1,
                          blurRadius: 8)
                    ]
                ),
                child: ListView(
                   children : listWidget
                  // children: <Widget>[
                    
                    
                    
                    
                  // ],
                ),
              )
            ],
          );
   }
  @override
  Widget build(BuildContext context) {
   screenWidth = MediaQuery.of(context).size;
    return Scaffold(
      // bottomNavigationBar: CartBottomBar(),
      backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      body: FutureBuilder(
              future: getDataCart(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // var extractdata = jsonDecode(snapshot.data);
                  //   List dataResult;
                  //   dataResult = extractdata["result"];
                  //   namaProduk =  dataResult[0]["content"][0]['nama_produk'].toString();
                  //   deskripsiProduk =  dataResult[0]["content"][0]['deskripsi'].toString();
                  //   hargaProduk =  dataResult[0]["content"][0]['harga'].toString();
                  //   mainImage =  dataResult[0]["content"][0]['main_image'].toString();
                  //   profitProduk =  dataResult[0]["content"][0]['profit'].toString();
                  //   sourceMedia = jsonDecode(dataResult[0]["content"][0]['media'].toString());
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
}
