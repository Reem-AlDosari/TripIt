import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/services.dart';

import 'edit_pagetrip_widget.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import '../addticket/addticket_widget.dart';
//import '/addticket/addticket_widget.dart';

/*Future<void> main() async {
  
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
runApp(addtrip_widget());

}*/

class edit_trip_widget extends StatefulWidget {
  var title;

  edit_trip_widget({Key key, this.title}) : super(key: key);

  @override
  State<edit_trip_widget> createState() => _edit_trip_widget();
}

class _edit_trip_widget extends State<edit_trip_widget> {
/*Future deleteTripDocument(NotifierModel notifier) async {
    final String uid = await _grabUID();
    final String notifierID = notifier.documentID;
    return await _returnState(Trip.document(uid).collection(Trip).document(notifierID).delete());
  }*/

  CollectionReference TripRef = FirebaseFirestore.instance.collection('Trip');

  @override
  Widget build(BuildContext context) {
    CollectionReference TripRef = FirebaseFirestore.instance.collection('Trip');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFCBD8E9),
      appBar: AppBar(
        title: new Text("Edit trip"),
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
            stream: FirebaseFirestore.instance.collection("Trip").snapshots(),
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
                    children: snapshot.data.docs.map((Trip) {
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
                                    "" + Trip['name'],
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Lexend Deca',
                                      fontSize: 16,
                                      color: Color(0xFF0D67B5),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        new Color(ColorNameToInt(Trip['Line'])),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            edit_pagetrip_widget(
                                                doc: TripRef.doc(Trip.id)),
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
                                    'edit Trip',
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

  int ColorNameToInt(String colorname) {
    List<String> colorname_table = [
      "red",
      "blue",
      "yellow",
      "green",
      "orange",
      "black",
      "white",
      "purple",
      "brown",
      "pink",
      "lime",
      "grey",
      "cyan",
      "lightBlue",
      "lightGreen",
      "teal",
      "indigo",
      "deepPurple",
      "amber",
      "deepOrange",
      "blueGrey"
    ];

    List<int> colorint_table = [
      0xFfd32f2f,
      0XFF1976d2,
      0xfffbc02d,
      0xff388e3c,
      0xfffff6f00,
      0xdd000000,
      0x99ffffff,
      0xff8e24aa,
      0xff6d4c41,
      0xffd81b60,
      0xffc0ca33,
      0xff616161,
      0xff00bcd4,
      0xff03a9f4,
      0xff8bc34a,
      0xff009688,
      0xff3f51b5,
      0xff512da8,
      0xFFFFa000,
      0xffe64a19,
      0xff546e7a,
    ];
    for (int i = 0; i < colorname_table.length; i++) {
      if (colorname == colorname_table[i]) return colorint_table[i];
    }
    return colorint_table[1]; //in case no match found
  }
}
