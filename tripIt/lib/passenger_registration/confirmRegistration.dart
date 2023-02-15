import 'package:trip_it/pass_login/pass_login_widget.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfimRegistrationWidget extends StatefulWidget {
  ConfimRegistrationWidget({Key key}) : super(key: key);

  @override
  _ConfimRegistrationWidgetState createState() =>
      _ConfimRegistrationWidgetState();
}

class _ConfimRegistrationWidgetState extends State<ConfimRegistrationWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFCBD8E9),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
              child: Text(
                'Registration done succefully ',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  fontSize: 40,
                color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
              child: Icon(
                Icons.check_circle,
                color: Color(0xFF208F0D),
                size: 100,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 150, 0, 0),
              child: InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PassLoginWidget(),
                    ),
                  );
                },
                child: Text(
                  'Move to passnger login',
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF334DE5),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

