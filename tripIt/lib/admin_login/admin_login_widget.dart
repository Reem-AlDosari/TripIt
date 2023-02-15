import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../admintab/admintab_widget.dart';


import '../addtrip/addtrip_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

class AdminLoginWidget extends StatefulWidget {
  AdminLoginWidget({Key key}) : super(key: key);

  @override
  _AdminLoginWidgetState createState() => _AdminLoginWidgetState();
}

class _AdminLoginWidgetState extends State<AdminLoginWidget> {
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  bool passwordVisibility =false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  progressDialogue(BuildContext context) {
    //set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    showDialog(
      //prevent outside touch
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(onWillPop: () {}, child: alert);
      },
    );
  }
 
    _logInAsAdmin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      await FirebaseFirestore.instance
          .collection("admin")
          .where('email', isEqualTo: emailController.text)
          .get()
          .then((value) async { print ("check");
        if (value.docs.length > 0) {
          await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => AdminTabWidget(),

  ),
);
          
        } else {
          await FirebaseAuth.instance.signOut();
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

  @override
  Widget build(BuildContext context) {
  
 
      return Scaffold(
        key: scaffoldKey,
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
          child: ListView(
            children: [
              SizedBox(
                height: 80,
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 24),
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
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(40, 0, 40, 20),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 20, 0),
                    child: TextFormField(
                      controller: emailController,
                      obscureText: false,
                      decoration: InputDecoration(
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
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(40, 0, 40, 20),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 20, 0),
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FFButtonWidget(
                  onPressed: () {
                    print('login as admin ...');

                    /**
                     * This button didn't have this line.
                     * So it was basically useless
                     */
                    _logInAsAdmin();
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
              
              
            ],
          ),
        ),
      );
    
  }
}
