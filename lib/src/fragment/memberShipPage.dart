import 'package:SaudagarKaya/ui/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:SaudagarKaya/ui/widgets/common_divider.dart';
import 'package:SaudagarKaya/ui/widgets/common_scaffold.dart';
import 'package:SaudagarKaya/ui/widgets/profile_tile.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:SaudagarKaya/database/DatabaseHelper.dart';
import 'package:SaudagarKaya/config.dart';
import 'package:SaudagarKaya/utils/uidata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberShip extends StatefulWidget {
  BuildContext context;
  @override
  MemberShipState createState() {
    return new MemberShipState();
  }
}

class MemberShipState extends State<MemberShip> {
  Size deviceSize;
  String emailMember = "vulnwalker@getnada.com",namaMember = "udin",teleponMember = "081223744803",referalEmail = "admin@saudagarkaya.com";
  int saldoMember;
  int jumlahBarangTerjual = 0;
  double persenToPremium = 0;
  String personalOmset = "0";
  String personalProfit = "0";
  String teamOmset = "0";
  String teamProfit = "0";
  String totalProfit = "0";
  ConfigClass configClass = new ConfigClass();
  var databaseHelper = new  DatabaseHelper() ;


  @override
  void initState() {
    super.initState();
    // (() async {
    //     //  await getDataAccount();
    //     setState(() {
    //     });
    // })();
  
  }
  Future<String> getMemberComission() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     emailMember = prefs.getString('sessionEmail');
     return await http.post(configClass.memberCommision(), body: {"email" : emailMember}).then((response) {
          print(response.body);
          return response.body;
    });
   }
  @override
  void didChangeDependencies() {
        (() async {
        //  await getDataAccount();
        setState(() {
                  
        });
    })();
    super.didChangeDependencies();
    
  }

   //Column1
  Widget MemberShipColumn() => Container(
        height: deviceSize.height * 0.24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProfileTile(
              title: "My MemberShip",
              subtitle: "",
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // IconButton(
                //   icon: Icon(Icons.chat),
                //   color: Colors.black,
                //   onPressed: () {},
                // ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(50.0)),
                    border: new Border.all(
                      color: Colors.black,
                      width: 4.0,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/logo.png"),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.black,
                    radius: 40.0,
                  ),
                ),
                // IconButton(
                //   icon: Icon(Icons.call),
                //   color: Colors.black,
                //   onPressed: () {},
                // ),
              ],
            )
          ],
        ),
      );

  //column2

  //column3
  Widget descColumn() => Container(
        height: deviceSize.height * 0.13,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              "SaudagarKaya mobile aplication is free app for you. This app like the minner point apps other. Give you prize arround your point",
              style: TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
              maxLines: 3,
              softWrap: true,
            ),
          ),
        ),
      );
  Widget progresColumn() => Container(
        decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
        height: deviceSize.height * 0.13,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text("s"),
                    ),
                  ),
      );
  //column4
  Widget accountColumn() => Container(
        height: deviceSize.height * 0.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ProfileTile(
                  title: "Website",
                  subtitle: "rm-rf.studio",
                ),
                ProfileTile(
                  title: "Phone",
                  subtitle: "+6281223744803",
                ),
                ProfileTile(
                  title: "YouTube",
                  subtitle: "youtube.com/vulnwalker",
                ),
              ],
            ),
           
          ],
        ),
      );

  Widget bodyData() { 
//     const cellRed = Color(0xffc73232);
// const cellMustard = Color(0xffd7aa22);
// const cellGrey = Color(0xffcfd4e0);
// const cellBlue = Color(0xff1553be);
// const background = Color(0xff242830);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Progres to Premium",
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.black),
              ),
              
            ],
          ),
          RoundedProgressBar(
              childLeft: Text(""+persenToPremium.toString()+"%",
                  style: TextStyle(color: Colors.black)),
              percent: persenToPremium,
              theme: RoundedProgressBarTheme.yellow
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              Text(
                jumlahBarangTerjual.toString()+" / 15 Barang",
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.black),
              ),
              
            ],
          ),
          CommonDivider(),
          SizedBox(
              height: 10.0,
            ),
          Container(
            decoration: BoxDecoration(color: Colors.green), //.withOpacity(0.8)
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Personal Omset",
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(personalOmset,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.green),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Personal Profit",
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(personalProfit,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
           SizedBox(
                height: 5.0,
              ),
          
          // CommonDivider(),
          // Container(
          //     decoration: BoxDecoration(color: Colors.blue),
          //     child: Padding(
          //       padding: const EdgeInsets.all(16.0),
          //       child: new Row(
          //       mainAxisSize: MainAxisSize.max,
          //       children: <Widget>[
          //         // new Image.asset("assets/images/profile.jpg", height: 70.0),
          //         CircleAvatar(
          //           radius: 40.0,
          //           backgroundImage: NetworkImage(
          //               "https://avatars0.githubusercontent.com/u/12619420?s=460&v=4"),
          //         ),
          //         new Container(width: 16.0),
          //         new Text("Dzakir", style: Style.headerTextStyle),
          //       ]
          //   ),
          //   )
          // ),
          // Container(
          //     decoration: BoxDecoration(color: Colors.blue),
          //     child: Padding(
          //       padding: const EdgeInsets.all(16.0),
          //       child: new Row(
          //       mainAxisSize: MainAxisSize.max,
          //       children: <Widget>[
          //         CircleAvatar(
          //           radius: 40.0,
          //           backgroundImage: NetworkImage(
          //               "http://member.saudagarkaya.com//assets/images/profile/8_dndini.jpg"),
          //         ),
          //         new Container(width: 16.0),
          //         new Text("Dini ", style: Style.titleTextStyle),
          //       ]
          //   ),
          //   )
          // ),
          SizedBox(
                height: 5.0,
              ),
          Container(
            decoration: BoxDecoration(color: Colors.green.withOpacity(1)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Team Omset",
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(teamOmset,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.green),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Team Profit",
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(teamProfit,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
           SizedBox(
                height: 5.0,
              ),
          Container(
            decoration: BoxDecoration(color: Colors.green),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Total Profit",
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text("5.550.000",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          
          // komisiColumn(deviceSize),
         
          // CommonDivider(),
          // descColumn(),
          // CommonDivider(),
        ],
      ),
    );
  }

  Widget _scaffold() => CommonScaffold(
        appTitle: "Membership",
        bodyData: 
        FutureBuilder(
              future: getMemberComission(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  var extractdata = JSON.jsonDecode(snapshot.data);
                    List dataResult;
                    dataResult = extractdata["result"];
                    // emailMember = dataResult[0]["content"]["email"];
                    // print(dataResult[0]["content"][0]["nama"]);
                    
                    personalProfit =  dataResult[0]["content"][0]['profit'].toString();
                    personalOmset =  dataResult[0]["content"][0]['omset_profit'].toString();
                    teamProfit =  dataResult[0]["content"][0]['komisi_referal'].toString();
                    teamOmset =  dataResult[0]["content"][0]['omset_referal'].toString();
                    jumlahBarangTerjual =  int.parse(dataResult[0]["content"][0]['jumlah_barang_terjual']);
                    totalProfit =  dataResult[0]["content"][0]['totalProfit'];
                    persenToPremium =  double.parse(dataResult[0]["content"][0]['persenToPremium']);

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
        showDrawer: true,
        
      );

  Widget komisiColumn(Size deviceSize) => Container(
      height: deviceSize.height * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          BoxTile("Profit", "Rp. 500.000", "Rp. 1.500.00"),
          BoxTile("Penukaran", "Rp. 700.000", "Rp. 6.100.000"),
          // BoxTile(
          //   title: "Profit",
          //   komisi: "Rp. 500.000",
          //   omset: "Rp. 1.500.00",
          // ),
          // BoxTile(
          //   title: "Penukaran",
          //   komisi: "Rp. 700.000",
          //   omset: "Rp. 6.100.000",
          // ),

       
        ],
      ),
    );
  Widget BoxTile (String title, String komisi, String omset) => Container(
    decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
      height: deviceSize.height * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.black),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                komisi,
                style: TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal, color: Colors.black),
              ),
              Text(
                omset,
                style: TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal, color: Colors.black),
              ),
            ],
          )


       
        ],
      ),
    );


  @override
  Widget build(BuildContext context) {
    // getDataAccount();
    deviceSize = MediaQuery.of(context).size;
    return _scaffold();
  }


}

// class BoxTile extends StatelessWidget {
//   final title;
//   final komisi;
//   final omset;
//   final textColor;
//   BoxTile({this.title, this.komisi, this.omset, this.textColor = Colors.black});
//   @override
//   Widget build(BuildContext context) {
//     var column = Column(
      
//       mainAxisAlignment: MainAxisAlignment.center,
//       decoration: BoxDecoration(
//         color: Colors.deepPurple,
//       ),
//       children: <Widget>[
//         Text(
//           title,
//           style: TextStyle(
//               fontSize: 20.0, fontWeight: FontWeight.w700, color: textColor),
//         ),
//         SizedBox(
//           height: 5.0,
//         ),
//         Text(
//           komisi,
//           style: TextStyle(
//               fontSize: 15.0, fontWeight: FontWeight.normal, color: textColor),
//         ),
//         Text(
//           omset,
//           style: TextStyle(
//               fontSize: 15.0, fontWeight: FontWeight.normal, color: textColor),
//         ),
//       ],
//     );
//     return column;
//   }
// }


