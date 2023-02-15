import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trip_it/passenger_registration/confirmRegistration.dart';
import 'package:trip_it/utils/validator.dart';

import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_radio_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

Future<User> createAccountWithEmail(
    BuildContext context, String email, String password) async {
  final createAccountFunc = () => FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email.trim(), password: password);
  return signInOrCreateAccount(context, createAccountFunc);
}

class TripItFirebaseUser {
  TripItFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

/// Tries to sign in or create an account using Firebase Auth.
/// Returns the User object if sign in was successful.
Future<User> signInOrCreateAccount(
    BuildContext context, Future<UserCredential> Function() signInFunc) async {
  try {
    final userCredential = await signInFunc();
    await maybeCreateUser(userCredential.user);
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.message}')),
    );
    return null;
  }
}

TripItFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TripItFirebaseUser> tripItFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<TripItFirebaseUser>((user) => currentUser = TripItFirebaseUser(user));

DocumentReference get currentUserReference => currentUser?.user != null
    ? PassengerRecord.collection.doc(currentUser.user.uid)
    : null;

class PassengerRegistrationWidget extends StatefulWidget {
  PassengerRegistrationWidget({Key key}) : super(key: key);

  @override
  _PassengerRegistrationWidgetState createState() =>
      _PassengerRegistrationWidgetState();
}

class _PassengerRegistrationWidgetState
    extends State<PassengerRegistrationWidget> {
  String radioButtonValue;
  TextEditingController emailController;
  TextEditingController usernameController;
  TextEditingController passowrdController;
  bool passowrdVisibility;
  bool taken = false;
  TextEditingController phoneController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<String> userNames = [];
  void getUserName() async {
    setState(() {
      userNames.clear();
    });
    var doc = (await FirebaseFirestore.instance.collection('Passenger').get())
        .docs
        .toList();

    doc.forEach((element) async {
      setState(() {
        userNames.add(element.data()['username']);
        print("\n \n \n ${element.data()['username']}\n \n \n");
      });
    });
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    usernameController = TextEditingController();
    passowrdController = TextEditingController();
    passowrdVisibility = false;
    phoneController = TextEditingController();
    radioButtonValue = 'female';
    getUserName();
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
        //child: Align(
        // alignment: AlignmentDirectional(-0.14, -0.08),
        //child: Padding(
        // padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 220),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          constraints: BoxConstraints(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
          ),
          decoration: BoxDecoration(
            color: Color(0xFFCBD8E9),
            boxShadow: [
              BoxShadow(
                color: FlutterFlowTheme.grayIcon,
              )
            ],
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Color(0xFFCBD8E9),
            ),
          ),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: ListView(
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * .1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .1),
                  child: TextFormField(
                    controller: usernameController,
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
                      labelText: 'Username',
                      labelStyle: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Lexend Deca',
                      ),
                      hintText: '\n',
                      hintStyle: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Lexend Deca',
                      ),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      counterStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                    ),
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
                taken
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * .11, top: Get.height * .005),
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
                SizedBox(
                  height: Get.height * .01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .1),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      return FieldValidator.validateEmail(value);
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Lexend Deca',
                      ),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      counterStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                    ),
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .1),
                  child: TextFormField(
                    validator: (value) {
                      return FieldValidator.validatePassword(value);
                    },
                    controller: passowrdController,
                    obscureText: !passowrdVisibility,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Lexend Deca',
                      ),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      counterStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      suffixIcon: InkWell(
                        onTap: () => setState(
                          () => passowrdVisibility = !passowrdVisibility,
                        ),
                        child: Icon(
                          passowrdVisibility
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: FlutterFlowTheme.grayDark,
                          size: 24,
                        ),
                      ),
                    ),
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: FlutterFlowTheme.dark900,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .1),
                  child: TextFormField(
                    controller: phoneController,
                    validator: (value) {
                      return FieldValidator.validatePhoneNumber(value);
                    },
                    obscureText: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(new RegExp('[0-9]'))
                    ],
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Lexend Deca',
                      ),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      counterStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                    ),
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                Align(
                  alignment: AlignmentDirectional(0.1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                          child: Text(
                            'Gennder:',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Lexend Deca',
                            ),
                          ),
                        ),
                        FlutterFlowRadioButton(
                          options: ['female ', 'male'],
                          onChanged: (value) {
                            setState(() => radioButtonValue = value);
                          },
                          optionHeight: 25,
                          textStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                          ),
                          buttonPosition: RadioButtonPosition.left,
                          direction: Axis.horizontal,
                          radioButtonColor: Colors.blue,
                          inactiveRadioButtonColor: Color(0x8A000000),
                          toggleable: false,
                          horizontalAlignment: WrapAlignment.start,
                          verticalAlignment: WrapCrossAlignment.start,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .1),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        final user = await createAccountWithEmail(
                          context,
                          emailController.text,
                          passowrdController.text,
                        );
                        if (user == null) {
                          return;
                        }
                        final passengerCreateData = createPassengerRecordData(
                          username: usernameController.text,
                          gender: radioButtonValue,
                          email: emailController.text,
                        );

                        /////Update number as string///////
                        print("updating number");
                        await PassengerRecord.collection
                            .doc(user.uid)
                            .update(passengerCreateData);
                        await PassengerRecord.collection.doc(user.uid).update({
                          "phone": phoneController.text.trim(),
                        });
                        await Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfimRegistrationWidget(),
                          ),
                          (r) => false,
                        );
                      }
                    },
                    text: 'Register ',
                    options: FFButtonOptions(
                      width: 300,
                      height: 40,
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
        ),
      ),
    );
  }
}
