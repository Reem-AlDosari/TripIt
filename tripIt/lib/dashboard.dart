import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:trip_it/Passenger_profile/passenger_profile.dart';
import 'package:trip_it/cart/cart_page.dart';
import 'package:trip_it/flutter_flow/flutter_flow_icon_button.dart';
import 'package:trip_it/flutter_flow/flutter_flow_theme.dart';
import 'package:trip_it/history%20page/history_page.dart';
import 'package:trip_it/providers/app_provider.dart';
import 'package:trip_it/models/cart_item.dart';
import 'package:trip_it/models/currency.dart';
import 'package:trip_it/tabspage/tabspage_widget.dart';

class DashBoard extends StatefulWidget {
   
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  
  DateTime currentBackPressTime;
  Future<bool> exitApp() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press again to exit");
      return Future.value(false);
    }
    return exit(0);
  }

 int page = 1;
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AppProvider>(context, listen: false).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context,) {
     return Consumer<AppProvider>(
      builder: (context, model, _) {
    return WillPopScope(
      onWillPop: exitApp,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0D67B5),
          automaticallyImplyLeading: false,
          leading: page == 0
              ? IconButton(
                  onPressed: () async {
                    Provider.of<AppProvider>(context, listen: false)
                        .startChat();
                  },
                  icon: Icon(Icons.chat))
              : SizedBox(),
          title: Text(
            getTitle(page),
            style: FlutterFlowTheme.subtitle2.override(
              fontFamily: 'Lexend Deca',
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: [
            Image.asset(
              'assets/images/WhatsApp_Image_2021-09-07_at_5.48.48_PM.jpeg',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            
            )
          ],
          centerTitle: true,
          elevation: 4,
        ),
        body: getPage(page),
        bottomNavigationBar: Container(
          color: Color(0xFF0D67B5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.person,
                  color: page == 0 ? Colors.white : Colors.black,
                  size: 30,
                ),
                onPressed: () async {
                  setState(() {
                    page = 0;
                  });
                },
              ),
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.train,
                  color: page == 1 ? Colors.white : Colors.black,
                  size: 30,
                ),
                onPressed: () async {
                  setState(() {
                    page = 1;
                  });
                },
              ),
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.date_range_rounded,
                  color: page == 2 ? Colors.white : Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    page = 2;
                  });
                },
              ),
           Row(
              children:[
                 FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 10,
                borderWidth: 1,
                buttonSize: 50,
                
              
                icon: Icon(
                  Icons.shopping_cart_rounded,
                  color: page == 3 ? Colors.white : Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    page = 3;
                  });
                },
              ),

             Column(
      mainAxisSize: MainAxisSize.min,
      children: [
       
          
        Row( 
          children: [Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0,0,0,30),
           child:Text(
            model.cartProducts.length.toString(),

             style: FlutterFlowTheme.bodyText1.override(
      fontFamily: 'Lexend Deca',
      color: Color(0xFF0C0C0C),
      fontSize:17 ,)
         ))],
        ),
           
      ],
    ),
            ]),
            ]),
    )));
  });}

  getPage(int page) {
    switch (page) {
      case 0:
        return PassengerProfileWidget();
      case 1:
        return TabspageWidget();
      case 2:
        return History(
          userEmail:
              Provider.of<AppProvider>(context, listen: false).userData.email,
          appbar: true,
        );
      case 3:
        return CartPage(
          dashboard: true,
        );
    }
  }

  getTitle(int page) {
    switch (page) {
      case 0:
        return "Profile";
      case 1:
        return "Book Now";
      case 2:
        return "History";
      case 3:
        return "Cart";
    }
  }
}
