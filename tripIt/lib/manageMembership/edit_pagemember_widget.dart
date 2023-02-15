import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_it/backend/backend.dart';
import 'package:trip_it/utils/cached_image.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as Path;

class edit_pagemember_widget extends StatefulWidget {
  final DocumentReference<Object> doc;
  const edit_pagemember_widget({Key key, this.doc}) : super(key: key);
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<edit_pagemember_widget> {
  Future<void> _editrecord(String record) async {
    List<DocumentSnapshot> recordList = (await FirebaseFirestore.instance
            .collection('membership_packages')
            .where("name_lowercase", isEqualTo: record.toLowerCase())
            .get())
        .docs;

    if (recordList.length <= 1) {
      widget.doc.update({
        "name": record,
        "name_lowercase": record.toLowerCase(),
        "Price": priceController.text,
        "days": daysController.text,
        "Image": imageURL,
      });

      setState(() => _loadingButton = true);
      try {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('Membership is updated successfully'),
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
            title: Text('The membership is already exist'),
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
      } else {
        print('No image selected.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Pick an image"),
            duration: Duration(seconds: 10),
          ),
        );
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
      imageURL = CurrentImageURL;
    }
    /*else {
      imageURL = "";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("pick an image"),
          duration: Duration(seconds: 10),
        ),
      );
    }*/
  }

//----------------------------Start

  DocumentReference memberRef =
      FirebaseFirestore.instance.collection('membership_packages').doc();

  int counter = 0;
  var CurrentImage;
  TextEditingController linenameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  bool _loadingButton = false;
  String CurrentImageURL;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Future<void> initialize() async {
    await widget.doc.snapshots().listen((event) {
      setState(() {
        linenameController = new TextEditingController(text: event.get("name"));
        priceController = new TextEditingController(text: event.get("Price"));
        daysController = new TextEditingController(text: event.get("days"));
        CurrentImageURL = event.get("Image");
        CurrentImage = NetworkImage(CurrentImageURL);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    //CollectionReference membership =
    //  FirebaseFirestore.instance.collection('membership_packages');

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
                      'Edit membership',
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 250, 0),
                  child: Text(
                    'Package name',
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
                      //hintText: 'Enter your name',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter the membership name';
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 250, 0),
                  child: Text(
                    'Number of days',
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
                    controller: daysController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(5),
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      //hintText: 'Enter your name',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter the number of days';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 290, 0),
                  child: Text(
                    'Price in S.R',
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
                      LengthLimitingTextInputFormatter(5),
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      //hintText: 'Enter your name',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter the price in SR';
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
                    'membership image',
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
                backgroundImage: selected_image != null
                    ? FileImage(selected_image)
                    : CurrentImage, //NetworkImage(CurrentImageURL),
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
            ])),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!_key.currentState.validate()) {
            return;
          }
          await saveImages(selected_image, memberRef);
          if (imageURL.isNotEmpty) {
            await _editrecord(
                linenameController.text.replaceAll("/  +/g", " ").trim());
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.edit),
      ),
    );
  }
}
