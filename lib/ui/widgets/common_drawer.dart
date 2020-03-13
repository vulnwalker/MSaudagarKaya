import 'package:flutter/material.dart';
import 'package:SaudagarKaya/ui/widgets/about_tile.dart';
import 'package:SaudagarKaya/utils/uidata.dart';
import 'package:flushbar/flushbar.dart';

class CommonDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _act = 2;
    return Drawer(
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
                  subtitle: _act != 2 ? Text('Dashboard') : null,
                  enabled: _act == 2,
                  onTap: () { 
                    Navigator.of(context).pushReplacementNamed("mainPage");
                    
                  }
              ),
            ),
            Card(
              child: ListTile(
                  leading: Icon(Icons.traffic),
                  title: Text('Trafic'),
                  subtitle: _act != 2 ? Text('The airplane is only in Act II.') : null,
                  enabled: _act == 2,
                  onTap: () {
                      Flushbar(
                      title:  "Trafic",
                      message:  "Trafic Clicked",
                      duration:  Duration(seconds: 3),              
                      )   ..show(context);
                   }
              ),
            ),
            Card(
              child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  subtitle: _act != 2 ? Text('The airplane is only in Act II.') : null,
                  enabled: _act == 2,
                  onTap: () { 
                    Navigator.of(context).pushReplacementNamed("profile");
                  }
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
                  onTap: () { 
                    Navigator.of(context).pushReplacementNamed("membership");
                   }
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
      );
  }
}
