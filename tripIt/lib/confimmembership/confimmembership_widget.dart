

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

import 'package:trip_it/dashboard.dart';
import 'package:trip_it/providers/app_provider.dart';
import 'package:trip_it/welcome_page/ticketConfiramationRating.dart';

import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';


class ConfirmMembershipWidget extends StatefulWidget {
  final bool membership;
  ConfirmMembershipWidget({this.membership = false});

  @override
  _ConfirmMembershipWidgetState createState() =>
      _ConfirmMembershipWidgetState();
}

class _ConfirmMembershipWidgetState extends State<ConfirmMembershipWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String emailBody;
  String passName;
  var appProvider = Provider.of<AppProvider>(Get.context);

  get firestoreInstance => null;
  @override
  void initState() {
    // TODO: implement initState
    passName = appProvider.userData.userName;
    emailBody = "Hello " +
        passName +
        ",\n \n Thank you for trusting TripIt! your booking has been successfully confirmed. \n \n Hope to see you again. \n\n\n Best Regards,\n TripIt team";

    sendEmail(
      appProvider.userData.email,
      "Book confirmation",
      emailBody,
    );

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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
                  child: Text(
                    widget.membership
                        ? 'Membership confirmed successfully'
                        : 'Ticket booked successfully',
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
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 150, 0, 80),
                    child: InkWell(
                      onTap: () async {
                
                         show();

                        /*{
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
                            };*/
                      },
                      child: Text(
                        'Go back to home page',
                        
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
        );
      },
    );
  }

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
  }
   void show(){
    showDialog(context: context,barrierDismissible: true, builder: (context){
      
      return RatingDialog(
       
        
        title: Text(""),
         message: Text("Rate your experience with TripIt!"),
         image: Icon(Icons.star, size: 100, color:Colors.blue, ),
         submitButtonText: "Submit",
         onSubmitted: (response) async {
         
           await FirebaseFirestore.instance.collection('Rating').add(
             {
           'Commnet':response.comment,
             }
           );
           thank();

           
         }
         
      );
    });
  }
  void thank(){
     showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: Text('Thank you for your rating'),
            // content: Text('adding trip is succsseful'),
            actions: [
              TextButton(
                onPressed: () =>Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashBoard(),
                    ),
                  ), 
                child: Text('Ok'),
              ),
            ],
          );
        },

    
 ); 
}
}
