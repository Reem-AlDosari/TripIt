import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_it/backend/backend.dart';
import 'package:trip_it/flutter_flow/flutter_flow_widgets.dart';
import 'package:trip_it/lines_page/line.dart';
import 'package:trip_it/tabspage/memberpage.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class TabspageWidget extends StatefulWidget {
  TabspageWidget({Key key}) : super(key: key);

  @override
  _TabspageWidgetState createState() => _TabspageWidgetState();
}

class _TabspageWidgetState extends State<TabspageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                            flex: 0,
                            child: Container(
                              height: Get.height * .06,
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: Text(
                                'Metro lines',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF0D67B5),
                                  fontSize: 33,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("Trip")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return SizedBox();
                                } else if (snapshot.data.docs.isEmpty) {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'No Lines Found',
                                    ),
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: Get.height * .025),
                                          height: Get.height,
                                          child: ListView.builder(
                                              itemCount:
                                                  snapshot.data.docs.length,
                                              itemBuilder: (context, index) {
                                                DocumentSnapshot doc =
                                                    snapshot.data.docs[index];

                                                return line(index, doc);
                                              }),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 0,
                            child: Container(
                              // height: Get.height * .06,
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("membership_packages")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return SizedBox();
                                } else if (snapshot.data.docs.isEmpty) {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'No membership Found',
                                    ),
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: Get.height * .025),
                                          height: Get.height,
                                          child: ListView.builder(
                                              itemCount:
                                                  snapshot.data.docs.length,
                                              itemBuilder: (context, index) {
                                                DocumentSnapshot doc =
                                                    snapshot.data.docs[index];

                                                return member(index, doc);
                                              }),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
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

  int ColorNameToInt(String colorname) {
    List<String> colorname_table = [
      "red",
      "blue",
      "yellow",
      "green",
      "orange",
      "black",
      "white",
      "purple",
      "brown",
      "pink",
      "lime",
      "grey",
      "cyan",
      "lightBlue",
      "lightGreen",
      "teal",
      "indigo",
      "deepPurple",
      "amber",
      "deepOrange",
      "blueGrey"
    ];

    List<int> colorint_table = [
      0xFfd32f2f,
      0XFF1976d2,
      0xfffbc02d,
      0xff388e3c,
      0xfffff6f00,
      0xdd000000,
      0x99ffffff,
      0xff8e24aa,
      0xff6d4c41,
      0xffd81b60,
      0xffc0ca33,
      0xff616161,
      0xff00bcd4,
      0xff03a9f4,
      0xff8bc34a,
      0xff009688,
      0xff3f51b5,
      0xff512da8,
      0xFFFFa000,
      0xffe64a19,
      0xff546e7a,
    ];
    for (int i = 0; i < colorname_table.length; i++) {
      if (colorname == colorname_table[i]) return colorint_table[i];
    }
    return colorint_table[1]; //in case no match found
  }

  Widget line(int index, DocumentSnapshot doc) {
    return Container(
      height: Get.height * .06,
      margin: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: FFButtonWidget(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LinePage(
                doc: doc,
              ),
            ),
          );
        },
        text: doc['name'],
        options: FFButtonOptions(
          width: double.infinity,
          height: 60,
          //   stream: FirebaseFirestore.instance.collection("Trip").snapshots(),
          color: //index == 0
              new Color(ColorNameToInt(doc['Line'])),

          textStyle: FlutterFlowTheme.subtitle2.override(
            fontFamily: 'Lexend Deca',
            color: Colors.white,
            fontSize: 27,
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: 12,
        ),
      ),
    );
  }

  Widget member(int index, DocumentSnapshot doc) {
    return Container(
      height: Get.height * .18,
      margin: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => memberpage(
                doc: doc,
                price: doc['Price'],
                type: doc['name'],
                days: doc['days'],
              ),
            ),
          );
        },
        child: Ink.image(
          image: NetworkImage(doc['Image']),
          height: 800,
          width: 800,
        ),

        /* text: doc['name'],
        options: FFButtonOptions(
          width: double.infinity,
          height: 60,
          //   stream: FirebaseFirestore.instance.collection("Trip").snapshots(),
          color: Color(0xFF0D67B5),
          //new Color(doc['Line']),

          textStyle: FlutterFlowTheme.subtitle2.override(
            fontFamily: 'Lexend Deca',
            color: Colors.white,
            fontSize: 27,
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: 12,
        ),*/
      ),
    );
  }
}
