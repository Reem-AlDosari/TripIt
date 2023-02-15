import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trip_it/backend/backend.dart';
import 'package:trip_it/confimmembership/confimmembership_widget.dart';
import 'package:trip_it/models/currency.dart';
import 'package:trip_it/models/trip_model.dart';
import 'package:trip_it/utils/cached_image.dart';
import 'package:trip_it/utils/paypal_payment/pay_pal_payment.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

class Line1Page extends StatefulWidget {
  final DocumentSnapshot doc;
  Line1Page({@required this.doc});

  @override
  _Line1PageState createState() => _Line1PageState();
}

class _Line1PageState extends State<Line1Page> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double rate;
  double price;

  Future<void> convertCurrency(String url) async {
    setState(() {
      isLoading = true;
    });
    try {
      Uri uri = Uri.parse(url);
      var response = await http.post(
        uri,
      );

      var jsonResponse = json.decode(response.body);
      Currency currency = Currency.fromJson(jsonResponse);

      rate = currency.quotes.uSDSAR;
      price = double.parse(widget.doc['Price']) / rate;
      print("price ${widget.doc['Price']}");
      print("rate ${currency.quotes.uSDSAR}");
      print("usd  price  $price");
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print(error);
    }
  }

  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    convertCurrency(
        "http://api.currencylayer.com/live?access_key=0a187ff1ed668ef1f69f9308e00b7820");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF0D67B5),
        automaticallyImplyLeading: true,
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
      backgroundColor: Color(0xFFCBD8E9),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(top: Get.height * .02),
              child: Center(
                child: Text(
                  '${widget.doc['Line'].toString()} line ',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Container(
              height: Get.height * .5,
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedImage(
                  imageUrl: widget.doc['Image'],
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                  child: Text(
                    'Price: ',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    '${widget.doc['Price']} S.R',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
            isLoading
                ? Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                  )
          ],
        ),
      ),
    );
  }
}
