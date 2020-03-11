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
          text: 'Main 2 ',
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

  

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     drawer: Drawer(
  //         child: ListView(
  //           padding: EdgeInsets.zero,
  //           children: <Widget>[
  //             DrawerHeader(
  //               child: Text('Drawer Header'),
  //               decoration: BoxDecoration(
  //                 color: Colors.blue,
  //               ),
  //             ),
  //             ListTile(
  //               title: Text('Dashboard'),
  //               onTap: () {
  //                 // Update the state of the app.
  //                 // ...
  //               },
  //             ),
  //             ListTile(
  //               title: Text('Trafic'),
  //               onTap: () {
  //                 // Update the state of the app.
  //                 // ...
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     body: SingleChildScrollView(
  //       child: Container(
  //           height: MediaQuery.of(context).size.height,
  //           child: Stack(
  //             children: <Widget>[
  //               Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 20),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: <Widget>[
  //                     Expanded(
  //                       flex: 3,
  //                       child: SizedBox(),
  //                     ),
  //                     _title(),
  //                     SizedBox(
  //                       height: 50,
  //                     ),
                     
  //                     _submitButton(),
                      
  //                     _divider(),
  //                     // _facebookButton(),
  //                     Expanded(
  //                       flex: 2,
  //                       child: SizedBox(),
  //                     ),
  //                   ],
  //                 ),
  //               ),
               
  //             ],
  //           ),
  //         )
  //       )
  //     );
    
  // }

  Widget build(BuildContext context) {
    int _act = 2;
    return Scaffold(
      appBar: AppBar(title: Text("Main Menu")),
      body: Center(child: Text('My Page!')),
      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height : 120.0, 
              child  : new DrawerHeader(
                  child  : Image.asset(
                    'assets/images/logo.png',
                    width: 300.0,
                    height: 30.0,
                    // fit: BoxFit.cover,
                  ),
                  decoration: new BoxDecoration(color: Colors.black),
                  margin : EdgeInsets.zero,
                  padding: EdgeInsets.zero
              ),
            ),
            Card(
              child: ListTile(
                  leading: Icon(Icons.dashboard),
                  title: Text('Dashboard'),
                  subtitle: _act != 2 ? Text('The airplane is only in Act II.') : null,
                  enabled: _act == 2,
                  onTap: () { /* react to the tile being tapped */ }
              ),
            ),
            Card(
              child: ListTile(
                  leading: Icon(Icons.traffic),
                  title: Text('Trafic'),
                  subtitle: _act != 2 ? Text('The airplane is only in Act II.') : null,
                  enabled: _act == 2,
                  onTap: () { /* react to the tile being tapped */ }
              ),
            ),
            Card(
              child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  subtitle: _act != 2 ? Text('The airplane is only in Act II.') : null,
                  enabled: _act == 2,
                  onTap: () { /* react to the tile being tapped */ }
              ),
            ),
            Card(
              child: ListTile(
                  leading: Icon(Icons.group_work),
                  title: Text('My Leads'),
                  subtitle: _act != 2 ? Text('The airplane is only in Act II.') : null,
                  enabled: _act == 2,
                  onTap: () { /* react to the tile being tapped */ }
              ),
            ),
            Card(
              child: ListTile(
                  leading: Icon(Icons.card_membership),
                  title: Text('Membership'),
                  subtitle: _act != 2 ? Text('The airplane is only in Act II.') : null,
                  enabled: _act == 2,
                  onTap: () { /* react to the tile being tapped */ }
              ),
            ),
            Card(
              child: ListTile(
                  leading: Icon(Icons.watch),
                  title: Text('Training'),
                  subtitle: _act != 2 ? Text('The airplane is only in Act II.') : null,
                  enabled: _act == 2,
                  onTap: () { /* react to the tile being tapped */ }
              ),
            ),
            Card(
              child: ListTile(
                  leading: Icon(Icons.pages),
                  title: Text('Copywriting'),
                  subtitle: _act != 2 ? Text('The airplane is only in Act II.') : null,
                  enabled: _act == 2,
                  onTap: () { /* react to the tile being tapped */ }
              ),
            ),
            Card(
              child: ListTile(
                  leading: Icon(Icons.shop),
                  title: Text('Shop'),
                  subtitle: _act != 2 ? Text('The airplane is only in Act II.') : null,
                  enabled: _act == 2,
                  onTap: () { /* react to the tile being tapped */ }
              ),
            ),
            Card(
              child: ListTile(
                  leading: Icon(Icons.payment),
                  title: Text('Invoice'),
                  subtitle: _act != 2 ? Text('The airplane is only in Act II.') : null,
                  enabled: _act == 2,
                  onTap: () { /* react to the tile being tapped */ }
              ),
            ),
           
            
            
          ],
        ),
      ),
    );
  }
}
