import 'package:flutter/material.dart';
import 'package:SaudagarKaya/ui/widgets/common_divider.dart';
import 'package:SaudagarKaya/ui/widgets/common_scaffold.dart';
import 'package:SaudagarKaya/ui/widgets/profile_tile.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:SaudagarKaya/database/DatabaseHelper.dart';
import 'package:SaudagarKaya/config.dart';
import 'package:SaudagarKaya/utils/uidata.dart';

class MainPage extends StatefulWidget {
  BuildContext context;
  @override
  MainPageState createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  Size deviceSize;
  String emailMember = "vulnwalker@getnada.com",namaMember = "Dashboard",teleponMember = "081223744803",referalEmail = "admin@saudagarkaya.com";
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
  Widget MainPageColumn() => Container(
        height: deviceSize.height * 0.24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProfileTile(
              title: namaMember,
              subtitle: "",
            ),
            SizedBox(
              height: 10.0,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: <Widget>[
      
            //     Container(
            //       decoration: BoxDecoration(
            //         borderRadius:
            //             new BorderRadius.all(new Radius.circular(50.0)),
            //         border: new Border.all(
            //           color: Colors.black,
            //           width: 4.0,
            //         ),
            //       ),
            //       child: CircleAvatar(
            //         backgroundImage: AssetImage("assets/logo.png"),
            //         backgroundColor: Colors.black,
            //         foregroundColor: Colors.black,
            //         radius: 40.0,
            //       ),
            //     ),
            //     // IconButton(
            //     //   icon: Icon(Icons.call),
            //     //   color: Colors.black,
            //     //   onPressed: () {},
            //     // ),
            //   ],
            // )
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
              "Dashboard Aplikasi Saudagar Kaya !",
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
          MainPageColumn(),
          CommonDivider(),
          // followColumn(deviceSize),
          // CommonDivider(),
          // infoColumn(deviceSize),
          // CommonDivider(),
          descColumn(),
          CommonDivider(),
          // accountColumn()
        ],
      ),
    );
  }

  Widget _scaffold() => CommonScaffold(
        appTitle: "Dashboard",
        bodyData: bodyData(),
        // showFAB: true,
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
  Widget followColumn(Size deviceSize) => Container(
      height: deviceSize.height * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ProfileTile(
            title: "Telepon",
            subtitle: teleponMember.toString(),
          ),
          ProfileTile(
            title: "Penukaran",
            subtitle: jumlahPenukaran.toString(),
          ),
          ProfileTile(
            title: "Absen",
            subtitle: jumlahAbsen,
          ),
       
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

