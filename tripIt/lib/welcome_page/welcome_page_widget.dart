import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trip_it/dashboard.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

class WelcomePageWidget extends StatefulWidget {
  WelcomePageWidget({Key key}) : super(key: key);

  @override
  _WelcomePageWidgetState createState() => _WelcomePageWidgetState();
}

class _WelcomePageWidgetState extends State<WelcomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loadingButton1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFCBD8E9),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(-0.65, -0.3),
              child: Text(
                'WELCOME TO TRIPIT',
                style: FlutterFlowTheme.title2.override(
                  fontFamily: 'Roboto Condensed',
                ),
              ),
            ),
            Center(
              child: Text(
                'TripIt metro is a world class metro that\nensures reliability and safety in operations\nits equipped with most modren \ncommunication.',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  color: Colors.black,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 150, 0, 0),
                child: FFButtonWidget(
                  onPressed: () {
                    print('Button pressed ...');
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => DashBoard()));
                  },
                  text: 'Start Your journey',
                  options: FFButtonOptions(
                    width: 200,
                    height: 40,
                    color: Color(0xFF0D67B5),
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.white,
                      fontSize: 19,
                      fontStyle: FontStyle.italic,
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-0.2, -0.7),
              child: Lottie.network(
                'https://assets2.lottiefiles.com/packages/lf20_zizREI.json',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                animate: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
