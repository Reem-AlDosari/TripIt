import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trip_it/flutter_flow/flutter_flow_theme.dart';
import 'package:trip_it/models/membership_model.dart';
import 'package:trip_it/models/trip_model.dart';

class History extends StatefulWidget {
  final String userEmail;
  final bool appbar;
  History({this.userEmail, this.appbar=false});
  
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String userEmail;
  @override
  void initState() {
    // TODO: implement initState
    userEmail = widget.userEmail;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
          appBar: widget.appbar
              ? PreferredSize(
                  child: SizedBox(), preferredSize: Size.fromHeight(0))
              : AppBar(
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
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: [
                TabBar(
                  labelColor: FlutterFlowTheme.primaryColor,
                  indicatorColor: FlutterFlowTheme.secondaryColor,
                  tabs: [
                    Tab(
                      child: Text(
                        'trip',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF0D67B5),
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'membership',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF0D67B5),
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [


                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                           Expanded(
              flex: 1,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Booking")
                    .where('userEmail', isEqualTo: userEmail)
                    .orderBy("bookingDate", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox();
                  } else if (snapshot.data.docs.isEmpty) {
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'No Trip Bookings Found',
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Expanded(
                          child: Container(
                            height: Get.height,
                            child: ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot doc =
                                      snapshot.data.docs[index];
                                  TripBookingModel trip =
                                      TripBookingModel.fromJson(doc.data());

                                  return tripBooking(trip);
                                }),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
                        
                        
                         
                        ],
                      ),



                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                             Expanded(
              flex: 1,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Membership")
                    .where('email', isEqualTo: userEmail.trim())
                    .orderBy("Startdate", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox();
                  } else if (snapshot.data.docs.isEmpty) {
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'No Membership Found',
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Expanded(
                          child: Container(
                            height: Get.height,
                            child: ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot doc =
                                      snapshot.data.docs[index];
                                  MemberShipModel membership =
                                      MemberShipModel.fromJson(doc.data());

                                  return memberShipBooking(membership);
                                }),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
                          
                          
                        ],
                      )



                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  

  }
  Widget tripBooking(TripBookingModel trip) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(
          top: Get.height * .01, left: Get.width * .04, right: Get.width * .04),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(
              0.2,
            ),
            blurRadius: 3)
      ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Booking Price",
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                ),
              ),
              Text(
                trip.price,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Bill",
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                ),
              ),
              Text(
                trip.totalBill,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Quantity",
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                ),
              ),
              Text(
                trip.quantity.toString(),
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Booking Date",
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                ),
              ),
              Text(
                DateFormat("MM-dd-yyyy")
                    .format(trip.bookingDate.toDate())
                    .toString(),
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Line",
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                ),
              ),
              Text(
                trip.line,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment status",
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                ),
              ),
              Text(
                trip.pay,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget memberShipBooking(MemberShipModel membership) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(
          top: Get.height * .01, left: Get.width * .04, right: Get.width * .04),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(
              0.2,
            ),
            blurRadius: 3)
      ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Membership Price",
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                ),
              ),
              Text(
                membership?.price ?? "",
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Membership Date",
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                ),
              ),
              Text(
                DateFormat("MM-dd-yyyy")
                    .format(membership.startDate.toDate())
                    .toString(),
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Membership type",
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                ),
              ),
              Text(
                membership?.type ?? "",
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment status",
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                ),
              ),
              Text(
                membership?.pay ?? "",
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}