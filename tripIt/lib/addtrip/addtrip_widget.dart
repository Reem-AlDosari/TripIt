import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as Path;

//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import '../addticket/addticket_widget.dart';
//import '/addticket/addticket_widget.dart';

/*Future<void> main() async {
  
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
runApp(addtrip_widget());

}*/

class addtrip_widget extends StatefulWidget {
  addtrip_widget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<addtrip_widget> createState() => _addtrip_widget();
}

class _addtrip_widget extends State<addtrip_widget> {
  //late DateTime datePicked;

  Future<void> _addrecord(String record, String text) async {
    List<DocumentSnapshot> recordList = (await FirebaseFirestore.instance
            .collection('Trip')
            .where("Line_lowercase", isEqualTo: record.toLowerCase())
            // .where("name", isEqualTo: text)
            .get())
        .docs;

    List<DocumentSnapshot> recordList1 = (await FirebaseFirestore.instance
            .collection('Trip')
            .where("name_lowercase", isEqualTo: text.toLowerCase())
            // .where("name", isEqualTo: text)
            .get())
        .docs;

    if (recordList.isEmpty && recordList1.isEmpty) {
      FirebaseFirestore.instance.collection('Trip').add({
        "Line": record,
        "Line_lowercase": record.toLowerCase(),
        "name": text,
        "name_lowercase": text.toLowerCase(),
        "Price": priceController.text,
        "Image": imageURL,
      });

      setState(() => _loadingButton = true);
      try {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('trip is added successfully'),
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
      } finally {
        setState(() => _loadingButton = false);
      }
    } else {
      await showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: Text('the trip is already exist'),
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
  }

// Image Picker
  //List<File> _images = [];
  File selected_image; // Used only if you need a single picture

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    // Let user select photo from gallery
    if (gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
      );
    }

    setState(() {
      if (pickedFile != null) {
        //  _images.add(File(pickedFile.path));
        selected_image =
            File(pickedFile.path); // Use if you only need a single picture
      }
    });
  }

  DocumentReference tripRef =
      FirebaseFirestore.instance.collection('Trip').doc();

  Future<String> uploadFile(File _image) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('Trip/${Path.basename(_image.path)}');
    await storageReference.putFile(_image);

    print('File Uploaded');
    String returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }

  String imageURL = '';

  Future<void> saveImages(File _image, DocumentReference ref) async {
    if (_image != null) {
      imageURL = await uploadFile(_image);
    } else {
      imageURL = "";
      await showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: Text('pick an image'),
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
  }

  int counter = 0;
  //DateTime selectedDate = DateTime.now();
  String lineController;
  final linenameController = TextEditingController();
  final priceController = TextEditingController();
  bool _loadingButton = false;

  //final dateController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CollectionReference Trip = FirebaseFirestore.instance.collection('Trip');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFCBD8E9),

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

      //backgroundColor: Color.fromARGB(203, 216, 233, 255),
      body: SingleChildScrollView(
        child: Form(

            //   padding: new EdgeInsets.all(10.0),
            //  margin: EdgeInsets.all(30),

            // padding: EdgeInsets.all(30),
            key: _key,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Trip',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        fontSize: 40,
                        color: Color(0xFF0D67B5),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 270, 0),
                  child: Text(
                    'Line color',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      fontSize: 16,
                      color: Color(0xFF0D67B5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: .0),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: DropdownButtonFormField<String>(
                    value: lineController,
                    items: <String>[
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
                    ]
                        .map((label) => DropdownMenuItem(
                              child: Text(label.toString()),
                              value: label,
                            ))
                        .toList(),
                    hint: Text("choose line color"),
                    onChanged: (value) {
                      setState(() {
                        lineController = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter the line color',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (String val) {
                      if (val?.isEmpty ?? true) {
                        return 'please choose the line color';
                      }
                      return null;
                    },

                    //   validator: validateText,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 270, 0),
                  child: Text(
                    'Line Name',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      fontSize: 16,
                      color: Color(0xFF0D67B5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: .0),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(20),
                      FilteringTextInputFormatter.allow(
                          RegExp("[a-z,A-Z,' ']")),
                      FilteringTextInputFormatter.deny(RegExp(r'^ +')),
                      //      FilteringTextInputFormatter.deny(RegExp(r'^' '+')),
                    ],
                    controller: linenameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter the line name',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter the line name';
                      }
                      return null;
                    },

                    //   validator: validateText,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 310, 0),
                  child: Text(
                    'Price',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      fontSize: 16,
                      color: Color(0xFF0D67B5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      //100000
                      LengthLimitingTextInputFormatter(5),
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'price from 1-99 in SR',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'please enter the price';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Text(
                    'Line image',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      fontSize: 16,
                      color: Color(0xFF0D67B5),
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 80,
                backgroundImage:
                    selected_image != null ? FileImage(selected_image) : null,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: RawMaterialButton(
                  fillColor: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.add_photo_alternate_rounded,
                    color: Colors.white,
                  ),
                  elevation: 8,
                  onPressed: () {
                    getImage(true);
                  },
                  padding: EdgeInsets.all(15),
                  shape: CircleBorder(),
                ),
              ),

              /*     Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    child: const Text('add ticket'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const addticket(),
                        ),
                      );
                    },
                  ),
                ),
              ),*/

              /*    Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                child: Image.network(
                  'https://alriyadh-city.com/wp-content/uploads/2018/01/%D8%AE%D8%B1%D9%8A%D8%B7%D8%A9-%D9%85%D8%AA%D8%B1%D9%88-%D8%A7%D9%84%D8%B1%D9%8A%D8%A7%D8%B6.jpg',
                  width: 360,
                  height: 390,
                  fit: BoxFit.cover,
                ),
              ),*/
            ])

            /*
          child: StreamBuilder(
              stream: Trip.orderBy('Index').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('Loading'));
                }
                return ListView(
                  children: snapshot.data!.docs.map((trips) {
                    return Center(
                      child: ListTile(
                        title: Text(Trip['Index'].toString() +
                            " " +
                            Trip['Source'] +
                            " to " +
                            Trip['Destination']),
                        onLongPress: () {
                          Trip.reference.delete();
                        },
                      ),
                    );
                  }).toList(),
                );
              }),
              */

            ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!_key.currentState.validate()) {
            return;
          }
          await saveImages(selected_image, tripRef);
          if (imageURL.isNotEmpty) {
            await _addrecord(lineController,
                linenameController.text.replaceAll("/  +/g", " ").trim());
          }
        },

        // _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}





/*String? validateText(String formText) {
  if (formText.isEmpty) return 'field is required';
  return null;
}*/