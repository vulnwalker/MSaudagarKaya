import 'package:flutter/material.dart';
import 'package:SaudagarKaya/src/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flushbar/flushbar.dart';
import 'Widget/bezierContainer.dart';


class MainPage extends StatefulWidget {
  final String title;

  MainPage({Key key, this.title}) : super(key: key);

  

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
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
    return GestureDetector(
        onTap: () => 
        Flushbar(
                  title:  "Hey Ninja",
                  message:  "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                  duration:  Duration(seconds: 3),              
                )..show(context)
        ,
        child: new Container(
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
                    'Login',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('-'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  

   Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Main ',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'Menu',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            
          ]),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
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
                     
                      _submitButton(),
                      
                      _divider(),
                      // _facebookButton(),
                      Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
               
              ],
            ),
          )
        )
      );
    
  }
}
