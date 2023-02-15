import 'package:trip_it/backend/backend.dart';
import 'package:trip_it/backend/schema/Rating_record.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({Key key}) : super(key: key);

  @override
  _FeedbackWidgetState createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(60, 50, 0, 0),
                  child: Text(
                    'Passengers Feedback',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                )
              ],
            ),
          Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                child: StreamBuilder<List<RatingRecord>>(
                  stream: queryRatingRecord(),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: FlutterFlowTheme.primaryColor,
                          ),
                        ),
                      );
                    }
                    List<RatingRecord> listViewRatingRecordList = snapshot.data;
         
                    return ListView.builder(
                    
                      
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewRatingRecordList.length,
                      itemBuilder: (context, listViewIndex) {
                        final listViewRatingRecord =
                            listViewRatingRecordList[listViewIndex];
                        return Card(
                          
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Color(0xFFF5F5F5),
                            child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                          child: Text(
                            
                            listViewRatingRecord.commnet,
                             style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Lexend Deca',
                              fontSize: 22,
                            ),
                            
                          ),
                           ),
                        );
                      },
                    );
                    
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
