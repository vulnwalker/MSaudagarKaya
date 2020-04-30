import 'package:flutter/material.dart';


class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size;
    return Scaffold(
      // bottomNavigationBar: CartBottomBar(),
      backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
             Container(
              height: 59,
              width: screenWidth.width * 1.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios,size: 22,),
                    ),
                    Text('Shopping Cart',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 32,
                          width: 32,
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(20),
                          //     color: Colors.black
                          // ),
                        ),
                        
                      ],
                    )
                  ],
                ),
              ),
            ),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                height: 410,
                width: screenWidth.width * 1.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          spreadRadius: 1,
                          blurRadius: 8)
                    ]
                ),
                child: ListView(

                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Row(

                        children: <Widget>[
                          Text('Cart',style: TextStyle(fontSize: 20),),
                          Spacer()
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Divider(
                          thickness:2,
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,),
                      child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              'https://www.styleathome.com/assets/img/default.jpg?v=1522265967'))),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Essential Kits',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      Text(
                                        'Rp. 180.000',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        ' ',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(20)),
                                                    child: GestureDetector(
                                                        // onTap: decrementCounter,
                                                        child: Icon(
                                                          Icons.remove_circle,
                                                          color: Colors.white,
                                                          size: 30,
                                                        )),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(left: 6, right: 6),
                                                      child: Text(
                                                        '4',
                                                        style: TextStyle(
                                                            fontSize: 20, fontWeight: FontWeight.bold),
                                                      )),
                                                  Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius: BorderRadius.circular(20)),
                                                    child: GestureDetector(
                                                        // onTap: incrementCounter,
                                                        child: Icon(
                                                          Icons.add_circle,
                                                          color: Colors.white,
                                                          size: 30,
                                                        )),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Divider(
                          thickness:2,
                        )
                    ),
                    // List Cart 
                    Container(
                      margin: EdgeInsets.only(left: 20,),
                      child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              'https://www.styleathome.com/assets/img/default.jpg?v=1522265967'))),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Essential Kits',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ))
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        '\$',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(20)),
                                                    child: GestureDetector(
                                                        // onTap: decrementCounter,
                                                        child: Icon(
                                                          Icons.remove_circle,
                                                          color: Colors.white,
                                                          size: 30,
                                                        )),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(left: 6, right: 6),
                                                      child: Text(
                                                        '4',
                                                        style: TextStyle(
                                                            fontSize: 20, fontWeight: FontWeight.bold),
                                                      )),
                                                  Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius: BorderRadius.circular(20)),
                                                    child: GestureDetector(
                                                        // onTap: incrementCounter,
                                                        child: Icon(
                                                          Icons.add_circle,
                                                          color: Colors.white,
                                                          size: 30,
                                                        )),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                    ),
                    //list Cart
                    Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Divider(
                          thickness:2,
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('Shipping',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30,top: 10),
                      child:Container(
                        height: 74,
                        width: screenWidth.width * 1.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 1.0,),
                              height: 72,
                              width: 140,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                  color: Colors.white
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Free',style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.bold),),
                                  Text('Standard Shipping',style: TextStyle(color: Colors.grey,fontSize: 15),),
                                  Text('(3-5 Days)',style: TextStyle(color: Colors.grey,fontSize: 15))
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 1.0,),
                              height: 72,
                              width: 137,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
                                  color: Colors.white
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('\$10',style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.bold)),
                                  Text('Express Shipping',style: TextStyle(color: Colors.grey,fontSize: 15)),
                                  Text('(1-3 Days)',style: TextStyle(color: Colors.grey,fontSize: 15))
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  )
                  ],
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}
