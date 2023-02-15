import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import 'package:trip_it/history%20page/history_page.dart';
import 'package:trip_it/home_page/home_page_widget.dart';

import 'package:trip_it/models/app_user.dart';
import 'package:trip_it/providers/app_provider.dart';
import 'package:trip_it/utils/logout_sheet.dart';


import '../flutter_flow/flutter_flow_theme.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import '../addticket/addticket_widget.dart';
//import '/addticket/addticket_widget.dart';

class passengerSearchWidget extends StatefulWidget {
  passengerSearchWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<passengerSearchWidget> createState() => _passengerSearchWidget();
}

class _passengerSearchWidget extends State<passengerSearchWidget> {
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
          body
              : SafeArea(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: DefaultTabController(
                      length: 3,
                      initialIndex: 0,
                      child: Column(children: [
                       
                        Expanded(
                            child: 
                          Column(mainAxisSize: MainAxisSize.max, children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: TextFormField(
                                controller: model.searchTC,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                onChanged: (value) {
                                  model.searchUsers();
                                },
                                decoration: InputDecoration(
                                   hintText: "search for passenger..",
                                  prefixIcon: Icon(
                                    Icons.search_rounded,
                                    size: 30,
                                    color: FlutterFlowTheme.background,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  isDense: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                   fillColor: FlutterFlowTheme.tertiaryColor,
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          20, 24, 20, 24),
                                ),
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: FlutterFlowTheme.dark900,
                                ),
                              ),
                            ),
                            model.searchTC.text.isEmpty
                                ? Expanded(
                                    child: ListView.builder(
                                        itemCount: model.appUsers.length,
                                        itemBuilder: (context, index) {
                                          AppUser user = model.appUsers[index];

                                          return userWidget(user);
                                        }),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                        itemCount: model.searchedUsers.length,
                                        itemBuilder: (context, index) {
                                          AppUser user =
                                              model.searchedUsers[index];

                                          return userWidget(user);
                                        }),
                                  ),
                          ]),
                         
                         
                        ),
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
                
                Text(user.userName),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               
                Text(user?.phoneNumber.toString() ?? "")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Text(user?.email ?? ""),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             
                Text(user?.gender ?? ""),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Signed up date:"),
                Text(DateFormat('dd-MM-yyyy').format(user.createdAt.toDate())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
