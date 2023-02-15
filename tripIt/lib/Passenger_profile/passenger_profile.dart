import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:trip_it/home_page/home_page_widget.dart';
import 'package:trip_it/models/app_user.dart';
import 'package:trip_it/providers/app_provider.dart';
import 'package:trip_it/utils/logout_sheet.dart';
import 'package:trip_it/utils/validator.dart';

import '../flutter_flow/flutter_flow_theme.dart';

class PassengerProfileWidget extends StatefulWidget {
  PassengerProfileWidget({Key key}) : super(key: key);

  @override
  _PassengerProfileWidgetState createState() => _PassengerProfileWidgetState();
}

class _PassengerProfileWidgetState extends State<PassengerProfileWidget> {
  List<String> userNames = [];
  void getUserName() async {
    userNames.clear();
    setState(() {});
    var doc = (await FirebaseFirestore.instance.collection('Passenger').get())
        .docs
        .toList();

    doc.forEach((element) async {
      userNames.add(element.data()['username']);
      print("\n \n \n ${element.data()['username']}\n \n \n");
    });
    setState(() {});
  }

  bool _loadingButton = false;
  bool taken = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String radioButtonValue;
  TextEditingController emailProfileController;
  TextEditingController usernameProfileController;
  TextEditingController phoneProfileController;
  TextEditingController genderProfileController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    getUserName();
    setState(() {
      radioButtonValue =
          Provider.of<AppProvider>(context, listen: false).userData.gender;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, model, _) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFFCBD8E9),
          body: SafeArea(
            child: Align(
              alignment: AlignmentDirectional(0.05, -0.6),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 22),
                // child: InkWell(
                // onTap: () async {
                // Navigator.pop(context);
                // },
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Email Address',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF0D67B5),
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: TextFormField(
                            controller: emailProfileController ??=
                                TextEditingController(
                              text: model.userData.email,
                            ),
                            enabled: false,
                            // validator: (value) {
                            //   return FieldValidator.validateEmail(value);
                            // },
                            obscureText: false,
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(),
                              //hintText: 'Enter your name',
                              filled: true,
                              fillColor: Color(0xFFCBD8E9),
                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Username',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF0D67B5),
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: TextFormField(
                            controller: usernameProfileController ??=
                                TextEditingController(
                              text: model.userData.userName,
                            ),
                            validator: (value) {
                              return FieldValidator.validateUsername(value);
                            },
                            onChanged: (value) {
                              if (value.length > 1) {
                                setState(() {
                                  taken = false;
                                });

                                for (var i = 0; i <= userNames.length; i++) {
                                  if (value.toLowerCase() ==
                                      userNames[i]?.toLowerCase().toString()) {
                                    if (value.toLowerCase() !=
                                        model.userData.userName)
                                      setState(() {
                                        taken = true;
                                        print("$value,${userNames[i]}");
                                      });

                                    break;
                                  }
                                }
                              }
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //hintText: 'Enter your name',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        taken
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * .11,
                                    top: Get.height * .005),
                                child: Text(
                                  'Username already taken',
                                  style: FlutterFlowTheme.bodyText1.override(
                                      fontSize: 12,
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.red),
                                ),
                              )
                            : Container(
                                height: 0,
                              ),
                        /*   Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Email Address',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF0D67B5),
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: TextFormField(
                            controller: emailProfileController ??=
                                TextEditingController(
                              text: model.userData.email,
                            ),
                            enabled: false,
                            // validator: (value) {
                            //   return FieldValidator.validateEmail(value);
                            // },
                            obscureText: false,
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(),
                              //hintText: 'Enter your name',
                              filled: true,
                              fillColor: Color(0xFFCBD8E9),
                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),*/
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Phone',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF0D67B5),
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: phoneProfileController ??=
                                  TextEditingController(
                                text: model.userData.phoneNumber.toString(),
                              ),
                              validator: (value) {
                                return FieldValidator.validatePhoneNumber(
                                    value);
                              },
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //hintText: 'Enter your name',
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 16,
                              )),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0.26),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: Text(
                                    'Gender',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF0D67B5),
                                      fontSize: 20,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        model.userData.gender = "female";
                                      });
                                    },
                                    icon: model.userData.gender == "female"
                                        ? Icon(
                                            Icons.radio_button_checked_rounded,
                                            color: Color(0xFF0D67B5))
                                        : Icon(Icons.radio_button_off_rounded,
                                            color: Color(0xFF0D67B5)),
                                  ),
                                  Text("Female")
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        model.userData.gender = "male";
                                      });
                                    },
                                    icon: model.userData.gender == "male"
                                        ? Icon(
                                            Icons.radio_button_checked_rounded,
                                            color: Color(0xFF0D67B5))
                                        : Icon(Icons.radio_button_off_rounded,
                                            color: Color(0xFF0D67B5)),
                                  ),
                                  Text("Male")
                                ],
                              ),
                            ],
                          ),
                        ),
                        model.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                color: Colors.blue,
                              ))
                            : Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: Get.width * .05,
                                    vertical: Get.height * .01),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  elevation: 0,
                                  // minWidth: Get.width,
                                  height: Get.height * .055,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * .15),
                                  color: Color(0xFF0D67B5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Save",
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    if (formKey.currentState.validate()) {
                                      AppUser user = AppUser(
                                        gender: model.userData.gender,
                                        phoneNumber:
                                            phoneProfileController.text,
                                        userName:
                                            usernameProfileController.text,
                                      );
                                      if (!taken) {
                                        model.updateUserProfile(user);
                                        await Future.delayed(
                                            Duration(milliseconds: 250));
                                        _editrecord();
                                      }
                                    }
                                  },
                                ),
                              ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Get.width * .05,
                              vertical: Get.height * .05),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            elevation: 0,
                            // minWidth: Get.width,
                            height: Get.height * .055,
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * .15),
                            color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Log out",
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Get.bottomSheet(ConfirmSheet(
                                onConfirm: () async {
                                  await FirebaseAuth.instance.signOut();
                                  Get.offAll(HomePageWidget());
                                },
                              ));
                            },
                          ),
                        ),

                        /*Align(
                          alignment: AlignmentDirectional(-0.06, 0.71),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () {
                                pass_name =
                                    passengerProfilePassengerRecord.username;
                                email_body = "Hello " +
                                    pass_name +
                                    ",\n \n Thank you for trusting TripIt! your booking has been successfully confirmed. \n \n Hope to see you again. \n\n\n Best Regards,\n TripIt team";

                                sendEmail(
                                  passengerProfilePassengerRecord.email,
                                  "Book confirmation",
                                  email_body,
                                );
                              },
                              text:
                                  ' for sending emalis ',
                              options: FFButtonOptions(
                                width: 300,
                                height: 55,
                                color: Color(0xFF0D67B5),
                                textStyle: FlutterFlowTheme.subtitle2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                ),
                                elevation: 4,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: 30,
                              ),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _editrecord() async {
    setState(() => _loadingButton = true);
    try {
      await showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: Text('your profile has been updated'),
            // content: Text('adding trip is succsseful'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext),
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() => _loadingButton = false);
    }
  }
}


//email
/*
  sendEmail(String sendEmailTo, String subject, String emailBody) async {
    await FirebaseFirestore.instance.collection('Emails').add(
      {
        'to': "$sendEmailTo",
        'message': {
          'subject': "$subject",
          'text': "$emailBody",
        },
      },
    ).then(
      (value) {
        print("Qued emailfor delivery");
      },
    );
    print('Email done');
  }*/

