import 'package:SaudagarKaya/ui/widgets/common_scaffold.dart';
import 'package:SaudagarKaya/ui/widgets/login_background.dart';
import 'package:flutter/material.dart';
import 'package:SaudagarKaya/model/product.dart';
import 'package:SaudagarKaya/src/action/shopping_action.dart';
import 'package:SaudagarKaya/ui/widgets/label_icon.dart';

class ShoppingWidgets extends StatelessWidget {
  Size deviceSize;
  // final Product product;
  final _scaffoldState = GlobalKey<ScaffoldState>();
  // ShoppingWidgets({Key key, this.product}) : super(key: key);
  Widget mainCard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "NAMA PRODUK",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text("PRODUK BRAND"),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    LabelIcon(
                      icon: Icons.star,
                      iconColor: Colors.cyan,
                      label: "5.6",
                    ),
                    Text(
                      "10000",
                      style: TextStyle(
                          color: Colors.orange.shade800,
                          fontWeight: FontWeight.w700,
                          fontSize: 25.0),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );

  Widget imagesCard() => SizedBox(
        height: deviceSize.height / 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Card(
            elevation: 2.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network("https://mosaic02.ztat.net/vgs/media/pdp-zoom/LE/22/1D/02/2A/12/LE221D022-A12@16.1.jpg"),
                  ),
            ),
          ),
        ),
      );

  Widget descCard() => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Print T-shirt",
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      );
  Widget bodyData(){
    return
    Stack(
      fit: StackFit.expand,
      children: <Widget>[
        LoginBackground(
          showIcon: false,
          image: "https://mosaic02.ztat.net/vgs/media/pdp-zoom/LE/22/1D/02/2A/12/LE221D022-A12@16.1.jpg",
        ),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: deviceSize.height / 4,
              ),
              mainCard(),
              imagesCard(),
              descCard(),
              actionCard(),
            ],
          ),
        )
      ],
    )
    
    ;
  }
  Widget actionCard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ShoppingAction()),
        ),
      );
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return
    
    CommonScaffold(
            backGroundColor: Colors.grey.shade100,
            actionFirstIcon: null,
            appTitle: "Product Detail",
            showFAB: true,
            scaffoldKey: _scaffoldState,
            showDrawer: false,
            centerDocked: true,
            floatingIcon: Icons.add_shopping_cart,
            bodyData: bodyData(),
            showBottomNav: true,
        ) 
    ;
  }
}
