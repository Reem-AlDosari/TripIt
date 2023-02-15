import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pass_login/pass_login_widget.dart';

class Confimationresetpasswidget extends StatefulWidget {
  Confimationresetpasswidget({Key key}) : super(key: key);

  @override
  _ConfimationresetpasswidgetState createState() => _ConfimationresetpasswidgetState();
}

class _ConfimationresetpasswidgetState extends State<Confimationresetpasswidget> {
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
                'Email sent successfully',
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
            Align(
              alignment: AlignmentDirectional(0.8, -0.85),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 115, 0, 0),
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
                    'Go back to login page',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: FlutterFlowTheme.primaryColor,
                      
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );}}