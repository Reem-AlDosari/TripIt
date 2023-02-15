import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/services.dart';

import 'edit_pagemember_widget.dart';
//import 'edit_pagetrip_widget.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import '../addticket/addticket_widget.dart';
//import '/addticket/addticket_widget.dart';

/*Future<void> main() async {
  
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
runApp(addtrip_widget());

}*/

class edit_member_widget extends StatefulWidget {
  var title;

  edit_member_widget({Key key, this.title}) : super(key: key);

  @override
  State<edit_member_widget> createState() => _edit_member_widget();
}

class _edit_member_widget extends State<edit_member_widget> {
/*Future deleteTripDocument(NotifierModel notifier) async {
    final String uid = await _grabUID();
    final String notifierID = notifier.documentID;
    return await _returnState(Trip.document(uid).collection(Trip).document(notifierID).delete());
  }*/

  CollectionReference memberRef =
      FirebaseFirestore.instance.collection('membership_packages');

  @override
  Widget build(BuildContext context) {
    CollectionReference memberRef =
        FirebaseFirestore.instance.collection('membership_packages');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFCBD8E9),
      appBar: AppBar(
        title: new Text("Edit membership"),
        titleTextStyle: new TextStyle(fontSize: 19, color: Colors.white),
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
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("membership_packages")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(children: [
                Container(
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.all(0.0),
                  height: 650.0,
                  width: 650.0,
                  child: ListView(
                    children: snapshot.data.docs.map((membership_packages) {
                      //   var mytrip = TripRef.doc(Trip.id);

                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            //   color: Colors.white,
                            width: MediaQuery.of(context).size.width / 0,
                            height: MediaQuery.of(context).size.height / 6,

                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 20, 10, 0),
                                  child: Text(
                                    "" + membership_packages['name'],
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Lexend Deca',
                                      fontSize: 16,
                                      color: Color(0xFF0D67B5),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF0D67B5),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            edit_pagemember_widget(
                                                doc: memberRef.doc(
                                                    membership_packages.id)),
                                      ),
                                    );

                                    /*    TripRef.doc(Trip.id).update({
                                      'Line': "reem",
                                      'price': '40',
                                      'name': 'king',
                                      'Image': 'newimage'
                                    });*/
                                  },
                                  child: Text(
                                    'Edit membership',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Lexend Deca',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                /*    ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {},
                  child: const Text('Delete Line'),

/*onPressed: (){
DeleteData(),

},*/

snapshot.data[index].id
                ),*/

                //   TripRef.doc(Trip.id).delete();
              ]);
            }),
      ),
    );
  }
}
