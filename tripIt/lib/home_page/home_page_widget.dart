import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_it/admintab/admintab_widget.dart';
import 'package:trip_it/guest_tabspage/welcome_page_widget.dart';
import 'package:trip_it/welcome_page/welcome_page_widget.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../passenger_registration/passenger_registration_widget.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  bool passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFCBD8E9),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFCBD8E9),
            boxShadow: [
              BoxShadow(
                color: FlutterFlowTheme.grayIcon,
              )
            ],
            border: Border.all(
              color: Color(0xFFCBD8E9),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/WhatsApp_Image_2021-09-07_at_5.48.48_PM.jpeg',
                        width: 160,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * .05,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * .07),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        obscureText: false,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          labelText: 'Email Address',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Lexend Deca',
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Lexend Deca',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * .07),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !passwordVisibility,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Lexend Deca',
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          suffixIcon: InkWell(
                            onTap: () => setState(
                              () => passwordVisibility = !passwordVisibility,
                            ),
                            child: Icon(
                              passwordVisibility
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 24,
                            ),
                          ),
                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Lexend Deca',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FFButtonWidget(
                      onPressed: () {
                        _logIn();
                      },
                      text: 'Log In',
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
                  // FFButtonWidget(
                  //   onPressed: () async {
                  //     await Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => AdminLoginWidget(),
                  //       ),
                  //     );
                  //   },
                  //   text: 'Login as admin',
                  //   options: FFButtonOptions(
                  //     width: 300,
                  //     height: 55,
                  //     color: Color(0xFF0D67B5),
                  //     textStyle: FlutterFlowTheme.subtitle2.override(
                  //       fontFamily: 'Lexend Deca',
                  //       color: Colors.white,
                  //     ),
                  //     elevation: 4,
                  //     borderSide: BorderSide(
                  //       color: Colors.transparent,
                  //       width: 2,
                  //     ),
                  //     borderRadius: 30,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  //   child: FFButtonWidget(
                  //     onPressed: () async {
                  //       await Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => PassLoginWidget(),
                  //         ),
                  //       );
                  //     },
                  //     text: 'Login as passenger',
                  //     options: FFButtonOptions(
                  //       width: 300,
                  //       height: 55,
                  //       color: Color(0xFF0D67B5),
                  //       textStyle: FlutterFlowTheme.subtitle2.override(
                  //         fontFamily: 'Lexend Deca',
                  //         color: Colors.white,
                  //       ),
                  //       borderSide: BorderSide(
                  //         color: Colors.transparent,
                  //         width: 2,
                  //       ),
                  //       borderRadius: 30,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: Get.height * .05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Lexend Deca',
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PassengerRegistrationWidget(),
                            ),
                          );
                        },
                        text: 'Create Account',
                        options: FFButtonOptions(
                          width: 140,
                          height: 40,
                          color: Color(0x004B39EF),
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontSize: 18,
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF0D67B5),
                          ),
                          elevation: 0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                          borderRadius: 12,
                        ),
                      )
                    ],
                  ),
                FFButtonWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              // builder: (context) => guestTabspageWidget(),
                              builder: (context) => WelcomePageWidget1(),
                            ),
                          );
                        },
                        text: 'Continue as a guest ...',
                        options: FFButtonOptions(
                          width: 500,
                          height: 60,
                          color: Color(0x004B39EF),
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontSize: 18,
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF0D67B5),
                          ),
                          elevation: 0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                          borderRadius: 12,
                        ),
                      )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _logIn() async {
    try {
      print(emailController.text);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      await FirebaseFirestore.instance
          .collection("admin")
          .where('email', isEqualTo: emailController.text)
          .get()
          .then((value) async {
        print("check");
        if (value.docs.length > 0) {
          print("if");
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminTabWidget(),
            ),
          );
        } else {
          print("else");
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => WelcomePageWidget()));
        }
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      var message = '';
      switch (e.code) {
        case 'invalid-email':
          message = 'invalid email';
          break;
        case 'user-disabled':
          message = 'the user is disabeld';
          break;
        case 'user-not-found':
          message = 'user not found';
          break;
        case 'wrong-password':
          message = 'incorrect password';
          break;
        case 'too-many-requests':
          message =
              'user blocked for sometime due to many wrong attempts.Try again later';
          break;
      }
      print(message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Log in failed'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('ok')),
              ],
            );
          });
    }
  }
}
