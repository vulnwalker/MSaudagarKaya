import 'package:SaudagarKaya/CheckRoute.dart';
import 'package:SaudagarKaya/src/fragment/cartPage.dart';
import 'package:SaudagarKaya/src/fragment/copyWiritingPage.dart';
import 'package:SaudagarKaya/src/fragment/kotak.dart';
import 'package:SaudagarKaya/src/fragment/leadPage.dart';
import 'package:SaudagarKaya/src/fragment/memberShipPage.dart';
import 'package:SaudagarKaya/src/fragment/produkPage.dart';
import 'package:SaudagarKaya/src/fragment/leadPage.dart';
import 'package:SaudagarKaya/src/loginPage.dart';
import 'package:SaudagarKaya/src/mainPage.dart';
import 'package:SaudagarKaya/src/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:SaudagarKaya/src/fragment/profilePage.dart';
import 'src/welcomePage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Saudagar Kaya',
      theme: ThemeData(
         primarySwatch: Colors.blue,
         textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
           body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
         ),
      ),
      debugShowCheckedModeBanner: false,
      home: CheckRoute(),
      routes: <String, WidgetBuilder>{
        "login": (BuildContext context) => LoginPage(),
        "register": (BuildContext context) => SignUpPage(),
        "profile": (BuildContext context) => Profile(),
        "membership": (BuildContext context) => MemberShip(),
        "mainPage": (BuildContext context) => MainPage(),
        "welcomePage": (BuildContext context) => WelcomePage(),
        "produkPage": (BuildContext context) => ProdukPage(),
        "copyWritingPage": (BuildContext context) => CopyWriting(),
        "leadPage": (BuildContext context) => Lead(),
        "kotak": (BuildContext context) => ShoppingWidgets(),
        "cartPage": (BuildContext context) => CartPage(),
      },
    );
  }
}
