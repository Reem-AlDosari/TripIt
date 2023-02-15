import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trip_it/chat/admin_inbox.dart';
import 'package:trip_it/Rating/AdminRating.dart';
import 'package:trip_it/deletetrip/deletetrip_widget.dart';
import 'package:trip_it/edit_trip/edit_trip_widget.dart';
import 'package:trip_it/history%20page/history_page.dart';
import 'package:trip_it/home_page/home_page_widget.dart';
import 'package:trip_it/manageMembership/addmember_widget.dart';
import 'package:trip_it/manageMembership/deletemember_widget.dart';
import 'package:trip_it/manageMembership/edit_member_widget.dart';
import 'package:trip_it/models/app_user.dart';
import 'package:trip_it/passengerSearch/passengersearch.dart';
import 'package:trip_it/providers/app_provider.dart';
import 'package:trip_it/utils/logout_sheet.dart';

import '../addtrip/addtrip_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import '../addticket/addticket_widget.dart';
//import '/addticket/addticket_widget.dart';

class AdminTabWidget extends StatefulWidget {
  AdminTabWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<AdminTabWidget> createState() => _AdminTabWidget();
}

class _AdminTabWidget extends State<AdminTabWidget> {
  var appProvider = Provider.of<AppProvider>(Get.context, listen: false);
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(milliseconds: 200), () async {
      appProvider.fetchAllUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF0D67B5),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Get.bottomSheet(ConfirmSheet(
                  onConfirm: () async {
                    await FirebaseAuth.instance.signOut();
                    Get.offAll(HomePageWidget());
                  },
                ));
              },
            ),
            actions: [

                  IconButton(
                  onPressed: () async {
                    Get.to(AdminInbox());
                  },
                  icon: Icon(Icons.chat))
              // Image.asset(
              //   'assets/images/WhatsApp_Image_2021-09-07_at_5.48.48_PM.jpeg',
              //   width: 100,
              //   height: 100,
              //   fit: BoxFit.cover,
              // )
            
            ],
            centerTitle: true,
            elevation: 4,
          ),
          backgroundColor: Color(0xFFCBD8E9),
          body: model.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
              : SafeArea(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: DefaultTabController(
                      length: 3,
                      initialIndex: 0,
                      child: Column(children: [
                        TabBar(
                          labelColor: FlutterFlowTheme.primaryColor,
                          indicatorColor: FlutterFlowTheme.secondaryColor,
                          tabs: [
                            Tab(
                                child: Text(
                              'Home page',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF0D67B5),
                                fontSize: 17,
                              ),
                            )),
                            Tab(
                                child: Text(
                              'Manage trips',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF0D67B5),
                                fontSize: 17,
                              ),
                            )),
                            Tab(
                                child: Text(
                              'Manage memberships',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF0D67B5),
                                fontSize: 16,
                              ),
                            ))
                          ],
                        ),
                        Expanded(
                            child: TabBarView(children: [
                       Column(mainAxisSize: MainAxisSize.max, children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: Text(
                                'Manage passengers',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF0D67B5),
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: double.infinity,
                                height: 60,
                                //    color: Colors.deepPurpleAccent[400],
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Color(0xFF0D67B5),
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ))),
                                  child: Text(
                                    'search for passenger',
                                    style: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 27,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => passengerSearchWidget(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                           
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: double.infinity,
                                height: 60,
                                //    color: Colors.deepPurpleAccent[400],
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Color(0xFF0D67B5),
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ))),
                                  child: Text(
                                    'Rating',
                                    style: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 27,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                           FeedbackWidget(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ]),
                          Column(mainAxisSize: MainAxisSize.max, children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: Text(
                                'Manage trips',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF0D67B5),
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: double.infinity,
                                height: 60,
                                //    color: Colors.deepPurpleAccent[400],
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Color(0xFF0D67B5),
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ))),
                                  child: Text(
                                    'Add trip',
                                    style: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 27,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => addtrip_widget(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: double.infinity,
                                height: 60,
                                //    color: Colors.deepPurpleAccent[400],
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Color(0xFF0D67B5),
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ))),
                                  child: Text(
                                    'Edit trip',
                                    style: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 27,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            edit_trip_widget(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: double.infinity,
                                height: 60,
                                //    color: Colors.deepPurpleAccent[400],
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Color(0xFF0D67B5),
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ))),
                                  child: Text(
                                    'Delete trip',
                                    style: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 27,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            deletetrip_widget(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ]),
                          Column(mainAxisSize: MainAxisSize.max, children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: Text(
                                'Manage membership',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF0D67B5),
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: double.infinity,
                                height: 60,
                                //    color: Colors.deepPurpleAccent[400],
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Color(0xFF0D67B5),
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ))),
                                  child: Text(
                                    'Add membership',
                                    style: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 27,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            addmember_widget(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: double.infinity,
                                height: 60,
                                //    color: Colors.deepPurpleAccent[400],
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Color(0xFF0D67B5),
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ))),
                                  child: Text(
                                    'Edit membership',
                                    style: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 27,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            edit_member_widget(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: double.infinity,
                                height: 60,
                                //    color: Colors.deepPurpleAccent[400],
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Color(0xFF0D67B5),
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ))),
                                  child: Text(
                                    'Delete membership',
                                    style: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 27,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            deletemember_widget(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ]),
                        ]))
                      ]),
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget userWidget(AppUser user) {
    return InkWell(
      onTap: () {
        Get.to(History(
          userEmail: user.email,
        ));
      },
      child: Container(
        margin: EdgeInsets.only(
            top: Get.height * .02,
            left: Get.width * .04,
            right: Get.width * .04),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Username"),
                Text(user.userName),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Phone Number"),
                Text(user?.phoneNumber.toString() ?? "")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Email"),
                Text(user?.email ?? ""),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Gender"),
                Text(user?.gender ?? ""),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Signed up"),
                Text(DateFormat('dd-MM-yyyy').format(user.createdAt.toDate())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
