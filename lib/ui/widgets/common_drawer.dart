import 'package:SaudagarKaya/database/DatabaseHelper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:SaudagarKaya/ui/widgets/about_tile.dart';
import 'package:SaudagarKaya/utils/uidata.dart';
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonDrawer extends StatelessWidget {
  var databaseHelper = new  DatabaseHelper() ;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;
  var context ;
  SharedPreferences prefs;
  Future<String> getSession() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString('sessionEmail').toString();
  }
  @override
  Widget build(BuildContext context2) {
    int _act = 2;
    context = context2;

    return FutureBuilder(
              future: getSession(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                   return _buildDrawer();
                } else {
                  return Center (
                      child: CircularProgressIndicator()
                  );
                }
              },
            );
  }
  Widget _buildRow(IconData icon, String title, String callToAction, {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: 
      InkWell(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(callToAction);
      },
      child:Row(
                children: [
                Icon(
                  icon,
                  color: active,
                ),
                SizedBox(width: 10.0),
                Text(
                  title,
                  style: tStyle,
                ),
                Spacer(),
                if (showBadge)
                  Material(
                    color: Colors.deepOrange,
                    elevation: 5.0,
                    shadowColor: Colors.red,
                    borderRadius: BorderRadius.circular(5.0),
                    child: Container(
                      width: 25,
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        "10+",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
              ]),
      )
      
    );
  }
  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  _buildDrawer()  {
    // final String image = images[0];

    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: active,
                      ),
                      onPressed: () {
                        var databaseHelper = new  DatabaseHelper() ;
                        databaseHelper.deleteAccount();
                        Navigator.pushReplacementNamed(context, "login");
                      },
                    ),
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.orange, Colors.deepOrange])),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(prefs.getString('sessionGambar').toString()),
         
                      // backgroundImage: CachedNetworkImageProvider(image),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    prefs.getString('sessionNama').toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    prefs.getString('sessionEmail').toString(),
                    style: TextStyle(color: active, fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),
                  _buildRow(Icons.dashboard, "Dashboard","mainPage"),
                  // _buildDivider(),
                  // _buildRow(Icons.traffic, "Trafic",""),
                  // _buildRow(Icons.notifications, "Notifications",showBadge: true),
                  _buildDivider(),
                  _buildRow(Icons.person, "Profile","profile"),
                  _buildDivider(),
                  _buildRow(Icons.group_work, "My Leads","leadPage"),
                  _buildDivider(),
                  _buildRow(Icons.card_membership, "Membership","membership"),
                  _buildDivider(),
                  _buildRow(Icons.watch, "Training","trainingPage"),
                  _buildDivider(),
                  _buildRow(Icons.pages, "Copywriting","copyWritingPage"),
                  _buildDivider(),
                  _buildRow(Icons.shop, "Shop","produkPage"),
                  _buildDivider(),
                  _buildRow(Icons.payment, "Invoice","invoicePage"),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}





//extended class 

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width-40, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height/2);
    path.quadraticBezierTo(
        size.width, size.height - (size.height / 4), size.width-40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}