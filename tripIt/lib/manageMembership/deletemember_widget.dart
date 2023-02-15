import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import '../addticket/addticket_widget.dart';
//import '/addticket/addticket_widget.dart';

/*Future<void> main() async {
  
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
runApp(addtrip_widget());

}*/

class deletemember_widget extends StatefulWidget {
  var title;

  deletemember_widget({Key key, this.title}) : super(key: key);

  @override
  State<deletemember_widget> createState() => _deletemember_widget();
}

class _deletemember_widget extends State<deletemember_widget> {
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
        title: new Text("Delete membership"),
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
                                    primary: Colors.red,
                                  ),
                                  onPressed: () {
                                    //TripRef.doc(Trip.id).delete();
                                    _showMyDialog(
                                        memberRef.doc(membership_packages.id));
                                  },
                                  child: const Text('Delete membership'),
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

  Future<void> _showMyDialog(DocumentReference<Object> doc) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete membership'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Are you sure you want to delete this membership?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () async {
                doc.delete();
                await Future.delayed(Duration(seconds: 1));
                await showDialog(
                  context: context,
                  builder: (alertDialogContext) {
                    return AlertDialog(
                      title: Text('Membership is deleted successfully'),
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

                /*     ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "trip is deleted successfully",
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        fontSize: 19,
                        color: Colors.red,
                      ),
                    ),
                    duration: Duration(seconds: 7),
                  ),
                );*/
                Navigator.of(context).pop();
                // return Text('Confirmed');
              },
            ),
          ],
        );
      },
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
