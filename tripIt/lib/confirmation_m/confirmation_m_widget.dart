import '../backend/backend.dart';
import '../confimmembership/confimmembership_widget.dart';
import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationMWidget extends StatefulWidget {
  ConfirmationMWidget({Key key}) : super(key: key);

  @override
  _ConfirmationMWidgetState createState() => _ConfirmationMWidgetState();
}

class _ConfirmationMWidgetState extends State<ConfirmationMWidget> {
  DateTimeRange calendarSelectedDay;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

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
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: Text(
                'Membership Booking conformation',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                  fontSize: 20,   
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 170, 0),
              child: Text(
                'choose the start date:',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                ),
              ),
            ),
            StreamBuilder<List<MembershipRecord>>(
              stream: queryMembershipRecord(
                singleRecord: true,
              ),
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
                List<MembershipRecord> calendarMembershipRecordList =
                    snapshot.data;
                // Customize what your widget looks like with no query results.
                if (snapshot.data.isEmpty) {
                  return Material(
                    child: Container(
                      height: 100,
                      child: Center(
                        child: Text('No results.'),
                      ),
                    ),
                  );
                }
                final calendarMembershipRecord =
                    calendarMembershipRecordList.first;
                return FlutterFlowCalendar(
                  color: FlutterFlowTheme.primaryColor,
                  weekFormat: false,
                  weekStartsMonday: false,
                  onChange: (DateTimeRange newSelectedDate) {
                    setState(() => calendarSelectedDay = newSelectedDate);
                  },
                  titleStyle: TextStyle(),
                  dayOfWeekStyle: TextStyle(),
                  dateStyle: TextStyle(),
                  selectedDateStyle: TextStyle(),
                  inactiveDateStyle: TextStyle(),
                );
              },
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 250, 0),
              child: Text(
                'Price:200S.R',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Lexend Deca',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  final membershipCreateData = createMembershipRecordData(
                    price: '200',
                    startdate: calendarSelectedDay.start,
                    type: 'one month',
                  );
                  await MembershipRecord.collection
                      .doc()
                      .set(membershipCreateData);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmMembershipWidget(),
                    ),
                  );
                },
                text: 'Confirm',
                options: FFButtonOptions(
                  width: 130,
                  height: 40,
                  color: Color(0xFF1D750F),
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Lexend Deca',
                    color: Colors.white,
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
              child: InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmMembershipWidget(),
                    ),
                  );
                },
                child: Icon(
                  Icons.chevron_left,
                  color: FlutterFlowTheme.tertiaryColor,
                  size: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
