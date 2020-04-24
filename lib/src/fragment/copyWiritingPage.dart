import 'dart:async';
import 'package:flutter/material.dart';
import 'package:SaudagarKaya/model/CopyWritingModel.dart';
import 'package:SaudagarKaya/ui/widgets/common_scaffold.dart';
import 'package:flushbar/flushbar.dart';
import 'package:SaudagarKaya/config.dart';
import 'package:SaudagarKaya/utils/uidata.dart';
import 'package:http/http.dart' as http;
import 'package:SaudagarKaya/database/DatabaseHelper.dart';
import 'dart:convert' as JSON;
import 'package:SaudagarKaya/database/model/account.dart';
import 'package:SaudagarKaya/ui/widgets/text_style.dart';
import 'package:SaudagarKaya/ui/widgets/separator.dart';
class CopyWriting extends StatefulWidget {

  @override
  CopyWritingPage createState() {
    return new CopyWritingPage();
  }
}

class CopyWritingPage extends State<CopyWriting> {
    final scaffoldKey = GlobalKey<ScaffoldState>();
  String email,password,passwordConfirm,nama,nomorTelepon = "";
  int limitFrom = 0;
  int limitTo = 10;
  String oldEmail ;
  int saldoMember;
  ConfigClass configClass = new ConfigClass();
  var databaseHelper = new  DatabaseHelper() ;
  final bool horizontal = false;

  void getDataAccount() async{
    var dbClient = await databaseHelper.db;
        List<Map> list = await dbClient.rawQuery('SELECT * FROM tabel_account');
        email = list[0]["email"];
        nama = list[0]["nama"];
        oldEmail = list[0]["email"];
        password = list[0]["password"];
        passwordConfirm = list[0]["password"];
        nomorTelepon = list[0]["nomor_telepon"]; 
        saldoMember = list[0]["saldo"]; 
  }
  
  List<int> items = List.generate(10, (i) => i);
  List<CopyWritingModel> kolom = [];
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;

  @override
  void initState() {
    super.initState();
     (() async {
        var dbClient = await databaseHelper.db;
        List<Map> list = await dbClient.rawQuery('SELECT * FROM tabel_account');
        email = list[0]["email"];
        _getMoreData();
        _scrollController.addListener(() {
          if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
            _getMoreData();
          }
        });
        setState(() {
        });
    })();
    
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _getMoreData() async {
        
         if (!isPerformingRequest) {
            setState(() => isPerformingRequest = true);
            List<int> newEntries = await fakeRequest(
                items.length, items.length + 10); //returns empty list
                if (newEntries.isEmpty) {
                  double edge = 200.0;
                  double offsetFromBottom = _scrollController.position.maxScrollExtent -
                      _scrollController.position.pixels;
                  if (offsetFromBottom < edge) {
                      _scrollController.animateTo(
                        _scrollController.offset - (edge - offsetFromBottom),
                        duration: new Duration(milliseconds: 500),
                        curve: Curves.easeOut
                      );
                  }
                }
            setState(() {
              items.addAll(newEntries);
              isPerformingRequest = false;
            });
          }
         
   
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(1.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  /// from - inclusive, to - exclusive
  Future<List<int>> fakeRequest(int from, int to) async {
    await http.post(configClass.copyWritingList(), body: {"email":email,"from" : limitFrom.toString(),"to":limitTo.toString()}).then((response) {
            List dataResult;
            List dataContent;
            print(response.body);
            var extractdata = JSON.jsonDecode(response.body);
            dataResult = extractdata["result"];
            if(dataResult[0]['err'] == ''){
              dataContent = dataResult[0]["content"];
              for (var i = 0; i < dataContent.length; i++) {
                kolom.add( 
                    CopyWritingModel(
                            id_copy_writing: dataContent[i]['id'],
                            judul: dataContent[i]['judul'],
                            isi_content: dataContent[i]['isi_content'],
                            tanggal: dataContent[i]['tanggal'],
                            status: dataContent[i]['status'],
                        )
                  );     
              }
              limitFrom = limitFrom + dataContent.length ;
            }
        
      });
    
      return List.generate(to - from, (i) => i + from);
  }

      Widget _planetValue({String value, String image}) {
      return new Container(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Image.asset(image, height: 12.0),
            new Container(width: 8.0),
            new Text(value, style: Style.smallTextStyle),
          ]
        ),
      );
    }
  
  Widget bodyData(context) {
    return  ListView.builder(
        itemCount: kolom.length,
        itemBuilder: (context, index) {
          if (index == items.length) {
            return _buildProgressIndicator();
          } else {
            return ListTile(
              title: new Card(
                color: Colors.black,
              elevation: 1.5,
              child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            new Container(
              child: new Container(
                                margin: new EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
                                constraints: new BoxConstraints.expand(),
                                child: new Column(
                                  crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                                  children: <Widget>[
                                    // new Container(height: 4.0),
                                    new Text(kolom[index].judul, style: Style.titleTextStyle),
                                    // new Container(height: 10.0),
                                    // new Text(kolom[index].status, style: Style.commonTextStyle),
                                    new Separator(),
                                    new Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        // new Expanded(
                                        //   flex: horizontal ? 1 : 0,
                                        //   child: _planetValue(
                                        //     value: kolom[index].tanggal,
                                        //     image: 'assets/images/calendar.png')

                                        // ),
                                        new Container(
                                          width: horizontal ? 8.0 : 32.0,
                                        ),
                                        // new Expanded(
                                        //     flex: horizontal ? 1 : 0,
                                        //     child: _planetValue(
                                        //     value: kolom[index].jam,
                                        //     image: 'assets/images/clock.png')
                                        // )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                        height: horizontal ? 124.0 : 154.0,
                        // margin: horizontal
                        //   ? new EdgeInsets.only(left: 46.0)
                        //   : new EdgeInsets.only(top: 72.0),
                        decoration: new BoxDecoration(
                          color: new Color(0xff1553be),
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.circular(8.0),
                          boxShadow: <BoxShadow>[
                            new BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              offset: new Offset(0.0, 10.0),
                            ),
                          ],
                        ),
                      ),
                       new Container(
                        margin: new EdgeInsets.symmetric(
                          vertical: 16.0
                        ),
                        alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
                        // child: new Hero(
                        //     tag: "planet-hero",
                        //     child: new Image(
                        //     image: new AssetImage("assets/logo.png"),
                        //     height: 92.0,
                        //     width: 92.0,
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                )
             )
            );
          }
        },
        controller: _scrollController,
      );
  }


  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      scaffoldKey: scaffoldKey,
      appTitle: "Copy Writing",
      showDrawer: true,
      showFAB: false,
      actionFirstIcon: Icons.pageview,
      bodyData: bodyData(context),
    );
  }
}
