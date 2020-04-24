import 'package:SaudagarKaya/database/DatabaseHelper.dart';
import 'package:SaudagarKaya/database/model/account.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:SaudagarKaya/src/Widget/bezierContainer.dart';
import 'package:SaudagarKaya/src/loginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;

import 'mainPage.dart';
class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();
  final TextEditingController _namaController = new TextEditingController();
  final TextEditingController _alamatController = new TextEditingController();
  final TextEditingController _nomorTeleponController = new TextEditingController();
  final TextEditingController _namaBankController = new TextEditingController();
  final TextEditingController _nomorRekeningController = new TextEditingController();
  final TextEditingController _namaRekeningController = new TextEditingController();
  final TextEditingController _emailReferal = new TextEditingController();
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

 

  Widget _submitButton() {
    return 
    InkWell(
      onTap: () {
        configClass.showLoading(context);
        http.post(configClass.register(), body: {
          "email":_emailController.text,
          "password": _passController.text,
          "nama": _namaController.text,
          // "alamat": _alamatController.text,
          "nomorTelepon": _nomorTeleponController.text,
          "referalEmail": _emailReferal.text,
        }).then((response) {
          configClass.closeLoading(context);
          
      
          final jsonResponse = JSON.jsonDecode(response.body.toString());
          String loginResponse ;
          // Resp resp = new Resp.fromJson(jsonResponse);
          var extractdata = JSON.jsonDecode(response.body);
          List dataResult;
          List dataContent;
          String err,cek;
          dataResult = extractdata["result"];
          print(response.body.toString());
          

          if(dataResult[0]["err"] == ''){
            Flushbar(
                      title:  "Sukses",
                      message:  "Pendaftaran Berhasil",
                      duration:  Duration(seconds: 15),              
                      )   ..show(context);
            var db = new DatabaseHelper();

            
            var dataAccount = new Account(
              _emailController.text,
              _passController.text,
              dataResult[0]["content"]["nama"],
              dataResult[0]["content"]["nomor_telepon"],
              int.tryParse(dataResult[0]["content"]["jumlah_barang"]),
              dataResult[0]["content"]["nama_bank"],
              dataResult[0]["content"]["nomor_rekening"],
              dataResult[0]["content"]["nama_rekening"],
              dataResult[0]["content"]["lisensi"],
              int.tryParse(dataResult[0]["content"]["profit"]),
              1,
            );
            db.saveAccount(dataAccount);
            print("Welcome "+ dataResult[0]["content"]["nama"].toString());
            Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));

          }else{
            loginResponse = dataResult[0]["err"];
            AlertDialog dialog = new AlertDialog(
              content: new Text(loginResponse)
            );
            showDialog(context: context,child: dialog);

            // Flushbar(
            //           title:  "Warning",
            //           message:  dataResult[0]["err"],
            //           duration:  Duration(seconds: 15),              
            //           )   ..show(context);
          }

        });

      },
      child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xfffbb448), Color(0xfff7892b)])),
      child: Text(
        'Register Now',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
    )
    ;
  }

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Saudagar',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'Kaya',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            
          ]),
    );
  }

  Widget _formRegister() {
    return 
    SingleChildScrollView(
      child:Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                  controller: this._emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                  controller: this._passController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Nama",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                  controller: this._namaController,
                  obscureText: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true))
            ],
          ),
        ),
        // Container(
        //   margin: EdgeInsets.symmetric(vertical: 10),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       Text(
        //         "Kota",
        //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        //       ),
        //       SizedBox(
        //         height: 10,
        //       ),
        //       TextField(
        //           controller: this._alamatController,
        //           obscureText: false,
        //           decoration: InputDecoration(
        //               border: InputBorder.none,
        //               fillColor: Color(0xfff3f3f4),
        //               filled: true))
        //     ],
        //   ),
        // ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Nomor WA",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                  controller: this._nomorTeleponController,
                  obscureText: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true))
            ],
          ),
        ),
        // Container(
        //   margin: EdgeInsets.symmetric(vertical: 10),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       Text(
        //         "Nama Bank",
        //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        //       ),
        //       SizedBox(
        //         height: 10,
        //       ),
        //       TextField(
        //           controller: this._namaBankController,
        //           obscureText: false,
        //           decoration: InputDecoration(
        //               border: InputBorder.none,
        //               fillColor: Color(0xfff3f3f4),
        //               filled: true))
        //     ],
        //   ),
        // ),
        // Container(
        //   margin: EdgeInsets.symmetric(vertical: 10),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       Text(
        //         "Nomor Rekening",
        //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        //       ),
        //       SizedBox(
        //         height: 10,
        //       ),
        //       TextField(
        //           controller: this._nomorRekeningController,
        //           obscureText: false,
        //           decoration: InputDecoration(
        //               border: InputBorder.none,
        //               fillColor: Color(0xfff3f3f4),
        //               filled: true))
        //     ],
        //   ),
        // ),
        // Container(
        //   margin: EdgeInsets.symmetric(vertical: 10),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       Text(
        //         "Nama Rekening",
        //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        //       ),
        //       SizedBox(
        //         height: 10,
        //       ),
        //       TextField(
        //           controller: this._namaRekeningController,
        //           obscureText: false,
        //           decoration: InputDecoration(
        //               border: InputBorder.none,
        //               fillColor: Color(0xfff3f3f4),
        //               filled: true))
        //     ],
        //   ),
        // ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Email Referal",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                  controller: this._emailReferal,
                  obscureText: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true))
            ],
          ),
        ),
      ],
    ) ,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Container(
          height: MediaQuery.of(context).size.height,
          child:Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: SizedBox(),
                    ),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _formRegister(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    )
                  ],
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: _loginAccountLabel(),
              // ),
              Positioned(top: 40, left: 0, child: _backButton()),
              Positioned(
                  top: -MediaQuery.of(context).size.height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer())
            ],
          ),
        )
      )
    );
  }
}
