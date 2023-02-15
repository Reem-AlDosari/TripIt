import 'package:get/get_connect.dart';


import '../dashboard.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rating_dialog/rating_dialog.dart';

class TicketConfermationRatingWidget extends StatefulWidget {
  TicketConfermationRatingWidget({Key key}) : super(key: key);

  @override
  _TicketConfermationRatingWidgetState createState() =>
      _TicketConfermationRatingWidgetState();
}

class _TicketConfermationRatingWidgetState
    extends State<TicketConfermationRatingWidget> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFCBD8E9),
      body: SafeArea(
        child: Align(
          alignment: AlignmentDirectional(0, 0.05),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 15, 0, 0),
            child: FFButtonWidget(
              onPressed: () {
                //print('Button pressed ...');
                show();
              },
              text: 'Rate us',
              options: FFButtonOptions(
                width: 340,
                height: 60,
                color: Color(0xFF0D67B5),
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Lexend Deca',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                elevation: 2,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 8,
              ),
              loading: _loadingButton,
            ),
          ),
        ),
      ),
    );
  }
  void show(){
    showDialog(context: context,barrierDismissible: true, builder: (context){
      return RatingDialog(
        title: Text(""),
         message: Text("Rate your experience with TripIt!"),
         image: Icon(Icons.star, size: 100, color:Colors.blue, ),
         submitButtonText: "Submit",
         onSubmitted: (response) async {
          await showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: Text('Thankyou for your rating'),
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
           
         }
         
      );
    });
  }
}
