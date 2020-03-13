import 'package:flutter/material.dart';
import 'package:SaudagarKaya/ui/widgets/common_divider.dart';
import 'package:SaudagarKaya/ui/widgets/common_scaffold.dart';
import 'package:SaudagarKaya/ui/widgets/profile_tile.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:SaudagarKaya/database/DatabaseHelper.dart';
import 'package:SaudagarKaya/config.dart';
import 'package:SaudagarKaya/utils/uidata.dart';

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
  String jumlahPenukaran = "0";
  String jumlahAbsen = "0";
  ConfigClass configClass = new ConfigClass();
  var databaseHelper = new  DatabaseHelper() ;


  @override
  void initState() {
    super.initState();
    (() async {
        //  await getDataAccount();
        setState(() {
        });
    })();
  
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
            child: Text(
              "Progres Upgrade Member",
              style: TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
              maxLines: 3,
              softWrap: true,
            ),
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          progresColumn(),
          CommonDivider(),
          komisiColumn(deviceSize),
          CommonDivider(),
          infoColumn(deviceSize),
          CommonDivider(),
          descColumn(),
          CommonDivider(),
        ],
      ),
    );
  }

  Widget _scaffold() => CommonScaffold(
        appTitle: "Membership",
        bodyData: bodyData(),
        showFAB: true,
        showDrawer: true,
        floatingIcon: Icons.edit,
        eventFloatButton: (){
          // AlertDialog dialog = new AlertDialog(
          //               content: new Text("Reload Activity")
          //             );
          // showDialog(context: context,child: dialog);
          Navigator.of(context).pushNamed(UIData.profileRoute);
        },
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
  Widget infoColumn(Size deviceSize) => Container(
      height: deviceSize.height * 0.13,
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ProfileTile(
            title: "Point",
            subtitle: saldoMember.toString(),
          ),
          ProfileTile(
            title: "Referal",
            subtitle: referalEmail.toString(),
          ),

       
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


