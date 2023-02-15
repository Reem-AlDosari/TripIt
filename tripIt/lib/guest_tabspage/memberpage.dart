import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:trip_it/backend/backend.dart';
import 'package:trip_it/cart/cart_page.dart';
import 'package:trip_it/confimmembership/confimmembership_widget.dart';
import 'package:trip_it/models/cart_item.dart';
import 'package:trip_it/models/currency.dart';
import 'package:trip_it/providers/app_provider.dart';
import 'package:trip_it/utils/cached_image.dart';
import 'package:trip_it/utils/paypal_payment/pay_pal_payment.dart';

import '../backend/backend.dart';
import '../confimmembership/confimmembership_widget.dart';
import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

class memberpage1 extends StatefulWidget {
  final String type;
  final String price;
  final String days;
  memberpage1(
      {@required this.type,
      @required this.price,
      @required this.days,
      DocumentSnapshot<Object> doc});

  @override
  _memberpage1State createState() => _memberpage1State();
}

class _memberpage1State extends State<memberpage1> {
  DocumentReference memberRef =
      FirebaseFirestore.instance.collection('membership').doc();
  Product product;
  DateTimeRange calendarSelectedDay;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  double rate = 3.75;
  double dollarPrice;
  var appProvider = Provider.of<AppProvider>(Get.context, listen: false);
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
      print(currency.quotes);
      rate = currency.quotes.uSDSAR;
      dollarPrice = double.parse(widget.price) / rate;
      print("price ${widget.price}");
      print("rate ${currency.quotes.uSDSAR}");
      print("usd  price  $dollarPrice");
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print("error caught:$error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, model, _) {
        return Scaffold(
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
          key: scaffoldKey,
          backgroundColor: Color(0xFFCBD8E9),
          body: SafeArea(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 50, 50, 50),
                      child: Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(40, 50, 0, 0),
                          child: Text(
                            'Member ship: ${widget.type}',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(100, 100, 0, 90),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price: ${widget.price} S.R',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  /* Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.green,
                          )
                       : FFButtonWidget(
                            onPressed: () async {
                              print("confirm");
                              print(
                                  "expiry date ${widget.type == "one week" ? DateTime(calendarSelectedDay.start.year, calendarSelectedDay.start.month, calendarSelectedDay.start.day + 7) : widget.type == "one month" ? DateTime(calendarSelectedDay.start.year, calendarSelectedDay.start.month + 1, calendarSelectedDay.start.day) : DateTime(calendarSelectedDay.start.year + 1, calendarSelectedDay.start.month, calendarSelectedDay.start.day)}");
                              setState(() {
                                isLoading = true;
                              });
                              var userEmail =
                                  FirebaseAuth.instance.currentUser.email;
                              final membershipCreateData =
                                  createMembershipRecordData(
                                price: widget.price,
                                startdate: calendarSelectedDay.start,
                                endDate: widget.type == "one week"
                                    ? DateTime(
                                        calendarSelectedDay.start.year,
                                        calendarSelectedDay.start.month,
                                        calendarSelectedDay.start.day + 7)
                                    : widget.type == "one month"
                                        ? DateTime(
                                            calendarSelectedDay.start.year,
                                            calendarSelectedDay.start.month + 1,
                                            calendarSelectedDay.start.day)
                                        : DateTime(
                                            calendarSelectedDay.start.year + 1,
                                            calendarSelectedDay.start.month,
                                            calendarSelectedDay.start.day),
                                type: widget.type,
                                pay: "not paid",
                                email: userEmail,
                              );
                              print(membershipCreateData.toString());

                              var now = Timestamp.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                              await MembershipRecord.collection
                                  .doc(now)
                                  .set(membershipCreateData)
                                  .then((value) => payMemberShipBill(
                                      expiryDate: widget.type == "one week"
                                          ? DateTime(
                                              calendarSelectedDay.start.year,
                                              calendarSelectedDay.start.month,
                                              calendarSelectedDay.start.day + 7)
                                          : widget.type == "one month"
                                              ? DateTime(
                                                  calendarSelectedDay.start.year,
                                                  calendarSelectedDay
                                                          .start.month +
                                                      1,
                                                  calendarSelectedDay.start.day)
                                              : DateTime(
                                                  calendarSelectedDay.start.year +
                                                      1,
                                                  calendarSelectedDay.start.month,
                                                  calendarSelectedDay.start.day),
                                      docID: now,
                                      price: (double.parse(widget.price) / rate)
                                          .toStringAsFixed(0)));
                            },
                            text: 'Confirm',
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: Color(0xFF1D750F),
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                          ),
                  ),*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> payMemberShipBill(
      {String docID, String price, DateTime expiryDate}) async {
    print("initializing payment expiry date $expiryDate");
    var transId = Timestamp.now().millisecondsSinceEpoch.toString();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaypalPayment(
          docId: docID,
          transId: transId,
          isMembership: true,
          price: price,
          onFinish: (val) async {
            print("payment finished");
            await callReminder("Membership purchased",
                "You have purchased a membership", DateTime.now());
            await callReminder("Membership Expired",
                "Your membership will be expired today", expiryDate);

            await Get.to(() => ConfirmMembershipWidget(
                  membership: true,
                ));
          },
        ),
      ),
    );
  }

  Future<void> callReminder(String msg, String title, DateTime date) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10, channelKey: 'basic_channel', title: title, body: msg));
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    String utcTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'scheduled',
          title: title,
          body: msg,
          notificationLayout: NotificationLayout.Default,
        ),
        schedule: NotificationCalendar.fromDate(date: date));
  }
}
