import 'package:flutter/material.dart';
import 'package:SaudagarKaya/ui/widgets/common_divider.dart';
import 'package:SaudagarKaya/ui/widgets/common_scaffold.dart';
import 'package:SaudagarKaya/ui/widgets/profile_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:SaudagarKaya/database/DatabaseHelper.dart';
import 'package:SaudagarKaya/config.dart';
import 'package:SaudagarKaya/utils/uidata.dart';

class Profile extends StatefulWidget {
  BuildContext context;
  @override
  ProfileState createState() {
    return new ProfileState();
  }
}

class ProfileState extends State<Profile> {
  Size deviceSize;
  String emailMember = "dndini2@gmail.com",teleponMember = "081223744803",referalEmail = "admin@saudagarkaya.com";
  String namaMember = "Dini Yuliani";
  String nama_bank = "BCA";
  String nama_rekening = "Ibu Yuliani";
  String nomor_rekening = "0348268";
  String alamatMember = "jl. Dago barat no 73 A";
  String lisensi = "PREMIUM";
  String foto = "";
  String status = "AKTIF";
  int saldoMember;
  String jumlahPenukaran = "0";
  String jumlahAbsen = "0";
  ConfigClass configClass = new ConfigClass();
  var databaseHelper = new  DatabaseHelper() ;
 
  @override
  void initState() {
    super.initState();
   
  }
   Future<String> getProfile() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     emailMember = prefs.getString('sessionEmail');
     return await http.post(configClass.profile(), body: {"email" : emailMember}).then((response) {
          // print(response.body);
          // var extractdata = JSON.jsonDecode(response.body);
          // List dataResult;
          // dataResult = extractdata["result"];
          // emailMember = dataResult[0]["content"]["email"];
          // namaMember =  dataResult[0]["content"]["nama"];
          // teleponMember =  dataResult[0]["content"]["nomor_telepon"];
          // nama_bank =  dataResult[0]["content"]["nama_bank"];
          // nomor_rekening =  dataResult[0]["content"]["nomor_rekening"];
          // nama_rekening =  dataResult[0]["content"]["nama_rekening"];
          // alamatMember =  dataResult[0]["content"]["alamat"];
          // referalEmail =  dataResult[0]["content"]["referal"];
          // lisensi =  dataResult[0]["content"]["lisensi"];
          // foto =  dataResult[0]["content"]["foto"];
          // status =  dataResult[0]["content"]["status"];

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
  Widget profileColumn() => Container(
        height: deviceSize.height * 0.48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                        new BorderRadius.all(new Radius.circular(100.0)),
                    border: new Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(foto),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.black,
                    radius: 90.0,
                  ),
                ),
                // IconButton(
                //   icon: Icon(Icons.call),
                //   color: Colors.black,
                //   onPressed: () {},
                // ),
              ],
            ),
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
              height: 10.0,
            ),
              Text(
                namaMember,
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.black),
              ),
              // SizedBox(
              //   height: 5.0,
              // ),
              // Text(
              //   teleponMember,
              //   style: TextStyle(
              //       fontSize: 15.0, fontWeight: FontWeight.normal, color: Colors.black),
              // ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                lisensi,
                style: TextStyle(
                     fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.black),
              ),
              // Icon(Icons.stars)
            ],
          ),
            SizedBox(
              height: 10.0,
            ),
           
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


  Widget bodyData() { 
    int _act = 2;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          profileColumn(),
          Card(
            child: ListTile(
                leading: Icon(Icons.email),
                title: Text(emailMember),
                subtitle: _act != 2 ? Text('EMAIL.') : null,
                enabled: _act == 2,
                // onTap: () { 
                //   Navigator.of(context).pushReplacementNamed("profile");
                // }
            ),
          ),
          Card(
            child: ListTile(
                leading: Icon(Icons.phone_android),
                title: Text(teleponMember),
                subtitle: _act != 2 ? Text('PHONE.') : null,
                enabled: _act == 2,
                // onTap: () { 
                //   Navigator.of(context).pushReplacementNamed("profile");
                // }
            ),
          ),
          Card(
            child: ListTile(
                leading: Icon(Icons.local_atm),
                title: Text(nama_bank + " " +nomor_rekening + " a/n "+ nama_rekening ),
                subtitle: _act != 2 ? Text('BANK.') : null,
                enabled: _act == 2,
                // onTap: () { 
                //   Navigator.of(context).pushReplacementNamed("profile");
                // }
            ),
          ),
          Card(
            child: ListTile(
                leading: Icon(Icons.home),
                title: Text(alamatMember ),
                subtitle: _act != 2 ? Text('Alamat.') : null,
                enabled: _act == 2,
                // onTap: () { 
                //   Navigator.of(context).pushReplacementNamed("profile");
                // }
            ),
          ),
          Card(
            child: ListTile(
                leading: Icon(Icons.group),
                title: Text(referalEmail ),
                subtitle: _act != 2 ? Text('Referal.') : null,
                enabled: _act == 2,
                // onTap: () { 
                //   Navigator.of(context).pushReplacementNamed("profile");
                // }
            ),
          ),

          CommonDivider(),
          // descColumn(),
          CommonDivider(),
          // accountColumn()
        ],
      ),
    );
  }

  Widget _scaffold() => CommonScaffold(
        appTitle: "Profile",
        bodyData: 
              FutureBuilder(
              future: getProfile(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  var extractdata = JSON.jsonDecode(snapshot.data);
                    List dataResult;
                    dataResult = extractdata["result"];
                    // emailMember = dataResult[0]["content"]["email"];
                    // print(dataResult[0]["content"][0]["nama"]);
                    
                    namaMember =  dataResult[0]["content"][0]['nama'].toString();
                    teleponMember =  dataResult[0]["content"][0]["nomor_telepon"];
                    nama_bank =  dataResult[0]["content"][0]["nama_bank"];
                    nomor_rekening =  dataResult[0]["content"][0]["nomor_rekening"];
                    nama_rekening =  dataResult[0]["content"][0]["nama_rekening"];
                    alamatMember =  dataResult[0]["content"][0]["alamat"];
                    referalEmail =  dataResult[0]["content"][0]["referal"];
                    lisensi =  dataResult[0]["content"][0]["lisensi"];
                    foto =  dataResult[0]["content"][0]["foto"];
                    status =  dataResult[0]["content"][0]["status"];
                  // tampilkan dvarata
                  return bodyData();
                } else {
                  return Center (
                      child: CircularProgressIndicator()
                  );
                }
              },
            ),

        showFAB: true,
        showDrawer: true,
        floatingIcon: Icons.edit,
        eventFloatButton: (){
          // AlertDialog dialog = new AlertDialog(
          //               content: new Text("Reload Activity")
          //             );
          // showDialog(context: context,child: dialog);
          Navigator.of(context).pushNamed(UIData.editProfileRoute);
        },
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

