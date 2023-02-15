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
import '../forgetpass/confirmationresetpass_widget.dart';


class forgetpassWidget extends StatefulWidget {
  forgetpassWidget ({Key key}) : super(key: key);

  @override
  _forgetpassWidgetState createState() => _forgetpassWidgetState();
}

class _forgetpassWidgetState extends State<forgetpassWidget > {
  String _email;
  final auth= FirebaseAuth.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  




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
                  onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  
                ),
                
              ),
              
            ),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FFButtonWidget(
                onPressed: () {
                 
auth.sendPasswordResetEmail(email:_email  );
Navigator.of(context)
                     .push(MaterialPageRoute(builder: (context) => Confimationresetpasswidget()));

                     

                },
                text: 'Send request',
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
