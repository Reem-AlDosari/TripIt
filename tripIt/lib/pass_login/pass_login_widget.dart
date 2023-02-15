import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_it/home_page/home_page_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import '../home_page/home_page_widget.dart';
import '../tabspage/tabspage_widget.dart';
import '../welcome_page/welcome_page_widget.dart';
import '../passenger_registration/passenger_registration_widget.dart';
import '../forgetpass/forgetpass_widget.dart';
import 'package:trip_it/forgetpass/forgetpass_widget.dart';

class PassLoginWidget extends StatefulWidget {
  PassLoginWidget({Key key}) : super(key: key);

  @override
  _PassLoginWidgetState createState() => _PassLoginWidgetState();
}

class _PassLoginWidgetState extends State<PassLoginWidget> {
  final passEmailController = new TextEditingController();
  final passPasswordController = new TextEditingController();
  bool passPasswordVisibility = false;
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

  _logIn() async {
    progressDialogue(context);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: passEmailController.text,
          password: passPasswordController.text);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => WelcomePageWidget()));
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
        automaticallyImplyLeading: false,
         leading: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
              Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePageWidget(),
                  ),
                );
              },
              child: Icon(
                Icons.arrow_back_outlined,
                color: FlutterFlowTheme.tertiaryColor,
                size: 30,
             ),
              ),
            )
          ],
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
      backgroundColor: Color(0xFFCBD8E9),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          children: [
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
                    controller: passEmailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Lexend Deca',
                      ),
                      hintText: 'Email Address',
                      hintStyle: FlutterFlowTheme.bodyText1.override(
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
                  border: Border.all(
                    color: Colors.white,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 20, 0),
                  child: TextFormField(
                    controller: passPasswordController,
                    obscureText: !passPasswordVisibility,
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
                          () =>
                              passPasswordVisibility = !passPasswordVisibility,
                        ),
                        child: Icon(
                          passPasswordVisibility
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                    child: Text(
                      'Don\'t have an account?',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                      Navigator.of(context)
                     .push(MaterialPageRoute(builder: (context) => PassengerRegistrationWidget()));

                    },
                    text: 'Create Account',
                    options: FFButtonOptions(
                      width: 140,
                      height: 40,
                      color: Color(0x004B39EF),
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF0D67B5),
                        fontSize: 20,
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
Row(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Align(
      alignment: AlignmentDirectional(0.05, -0.05),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
        child: Text(
          'do you face any problem?',
          textAlign: TextAlign.start,
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Lexend Deca',
                        color: Colors.black,
                        fontSize: 15,
          ),
        ),
      ),
    ),
    FFButtonWidget(
      onPressed: () async { 
       
                      await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => forgetpassWidget(),
                  ),
                );

      },
      text: 'forget password',
     
                    options: FFButtonOptions(
                      width: 140,
                      height: 40,
                      color: Color(0x004B39EF),
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF0D67B5),
                        fontSize: 22,
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
)


          ],
        ),
      ),
    );
  }
}