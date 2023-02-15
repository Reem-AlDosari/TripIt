// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:trip_it/models/membership_model.dart';
// import 'package:trip_it/models/trip_model.dart';
//
// import '../flutter_flow/flutter_flow_theme.dart';
//
// class HistoryWidget extends StatefulWidget {
//   HistoryWidget({Key key}) : super(key: key);
//
//   @override
//   _HistoryWidgetState createState() => _HistoryWidgetState();
// }
//
// class _HistoryWidgetState extends State<HistoryWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   String userEmail;
//   @override
//   void initState() {
//     // TODO: implement initState
//     userEmail = FirebaseAuth.instance.currentUser.email;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Color(0xFFCBD8E9),
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: Get.width * .04, top: 10),
//               child: Text(
//                 'Trip Bookings:',
//                 textAlign: TextAlign.center,
//                 style: FlutterFlowTheme.bodyText1.override(
//                   fontFamily: 'Poppins',
//                   fontSize: 25,
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection("Booking")
//                     .where('userEmail', isEqualTo: userEmail)
//                     .snapshots(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (!snapshot.hasData) {
//                     return SizedBox();
//                   } else if (snapshot.data.docs.isEmpty) {
//                     return Center(
//                       child: Container(
//                         alignment: Alignment.center,
//                         child: Text(
//                           'No Trip Bookings Found',
//                         ),
//                       ),
//                     );
//                   } else {
//                     return Column(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             height: Get.height,
//                             child: ListView.builder(
//                                 itemCount: snapshot.data.docs.length,
//                                 itemBuilder: (context, index) {
//                                   DocumentSnapshot doc =
//                                       snapshot.data.docs[index];
//                                   TripBookingModel trip =
//                                       TripBookingModel.fromJson(doc.data());
//
//                                   return tripBooking(trip);
//                                 }),
//                           ),
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: Get.width * .04, top: 10),
//               child: Text(
//                 'Memberships:',
//                 textAlign: TextAlign.center,
//                 style: FlutterFlowTheme.bodyText1.override(
//                   fontFamily: 'Poppins',
//                   fontSize: 25,
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection("Membership")
//                     .where('email', isEqualTo: userEmail)
//                     .snapshots(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (!snapshot.hasData) {
//                     return SizedBox();
//                   } else if (snapshot.data.docs.isEmpty) {
//                     return Center(
//                       child: Container(
//                         alignment: Alignment.center,
//                         child: Text(
//                           'No Membership Found',
//                         ),
//                       ),
//                     );
//                   } else {
//                     return Column(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             height: Get.height,
//                             child: ListView.builder(
//                                 itemCount: snapshot.data.docs.length,
//                                 itemBuilder: (context, index) {
//                                   DocumentSnapshot doc =
//                                       snapshot.data.docs[index];
//                                   MemberShipModel membership =
//                                       MemberShipModel.fromJson(doc.data());
//
//                                   return memberShipBooking(membership);
//                                 }),
//                           ),
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget tripBooking(TripBookingModel trip) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       margin: EdgeInsets.only(
//           top: Get.height * .01, left: Get.width * .04, right: Get.width * .04),
//       decoration: BoxDecoration(boxShadow: [
//         BoxShadow(
//             color: Colors.black.withOpacity(
//               0.2,
//             ),
//             blurRadius: 3)
//       ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Booking Price"),
//               Text(
//                 trip.price,
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Total Price"),
//               Text(
//                 trip.totalBill,
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Booking Date"),
//               Text(
//                 DateFormat("MM-dd-yyyy")
//                     .format(trip.bookingDate.toDate())
//                     .toString(),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Payment status"),
//               Text(
//                 trip.pay,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget memberShipBooking(MemberShipModel membership) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       margin: EdgeInsets.only(
//           top: Get.height * .01, left: Get.width * .04, right: Get.width * .04),
//       decoration: BoxDecoration(boxShadow: [
//         BoxShadow(
//             color: Colors.black.withOpacity(
//               0.2,
//             ),
//             blurRadius: 3)
//       ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Membership Price"),
//               Text(
//                 membership?.price ?? "",
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Membership Date"),
//               Text(
//                 DateFormat("MM-dd-yyyy")
//                     .format(membership.startDate.toDate())
//                     .toString(),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Payment status"),
//               Text(
//                 membership?.pay ?? "",
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
