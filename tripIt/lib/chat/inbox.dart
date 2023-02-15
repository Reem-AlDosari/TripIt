import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:trip_it/chat/chat_service.dart';
import 'package:trip_it/chat/message.dart';

class Inbox extends StatefulWidget {
  final String roomId;
  final String email;
  final String userEmail;

  Inbox({
    this.email,
    this.userEmail,
    this.roomId,
  });
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  StreamSubscription _streamSubscriptionChat;
  var isSelected = 0;
  var listMessage;
  bool isLoading = false;

  bool isSendIcon = false;
  DateTime dateTime = DateTime.now();
  var selectedRoomId;
  TextEditingController textController;
  ScrollController _controller = ScrollController();
  String textSaver = "";
  List<Message> chat = [];
  /*-----------------------read Messages -----------------------------------*/
  StreamSubscription<QuerySnapshot> streamSubscription;

  void readAllMessage(BuildContext context) {
    streamSubscription = null;
    print("read Messages $streamSubscription");
    print("against email $widget.");
    streamSubscription = FirebaseFirestore.instance
        .collection("Chats")
        .where('room_id', isEqualTo: widget.roomId)
        .where('receiver_id', isEqualTo: widget.userEmail)
        .where('sender_id', isEqualTo: widget.email)
        .where('seen', isEqualTo: false)
        .snapshots()
        .listen((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("Chats")
            .doc(element.id)
            .update({'seen': true}).then((value) {
          print('Seen by staff ::::::and:::::::::updated');
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    fetchChat(widget.roomId);
    readAllMessage(context);
    print("room id:${widget.roomId}");
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamSubscription.cancel();
    _streamSubscriptionChat.cancel();
    _streamSubscriptionChat = null;
    super.dispose();
    _controller.dispose();
    textController.dispose();
  }

  Future<void> onSendMessage(Message msg) async {
    // type: 0 = text, 1 = image, 2 = sticker
    textController.clear();

    var documentReference = FirebaseFirestore.instance
        .collection('Chats')
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    documentReference.set(msg.toJson());
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['sender_id'] == '') ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['receiver_id'] != '') ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D67B5),
        centerTitle: true,
        title: Text(
          "Support",
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              conversation(),
              bottomTextNavigation(),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomTextNavigation() {
    return Container(
      alignment: Alignment.bottomCenter,
      height: Get.height * .08,
      padding: EdgeInsets.only(
          left: Get.width * .01,
          right: Get.width * .03,
          top: Get.height * .013),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF0D67B5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.only(
                    left: Get.width * .03,
                  ),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(color: Color(0xFF0D67B5)),
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: "MelReg",
                      color: Color(0xFF0D67B5),
                    ),
                    textAlign: TextAlign.start,
                    controller: textController,
                    maxLines: 2,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Get.width * .03),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      hintText: "Type a message here",
                      // hintStyle: MyTextStyles.poppins().copyWith(
                      //   fontSize: Get.height * .018,
                      //   color: blueGreyHeadings,
                      // ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (textController.text.isNotEmpty) {
                          isSendIcon = true;
                        } else {
                          isSendIcon = false;
                        }
                      });
                      textSaver = value;
                      print("text saver   " + textSaver);
                    },
                    onFieldSubmitted: (value) {},
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * .02,
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () async {
                      if (textController.text != '') {
                        Message msg = Message(
                          message: textController.text,
                          receiver: widget.email,
                          sender: widget.userEmail,
                          roomId: widget.roomId,
                          createdAt: Timestamp.now(),
                          isSeen: false,
                        );
                        chat.insert(0, msg);
                        setState(() {});
                        await onSendMessage(msg);
                      } else {
                        Fluttertoast.showToast(msg: "Please type something");
                      }
                    },
                    child: Container(
                      height: 47,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.send,
                        color: Color(0xFF0D67B5),
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget conversation() {
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemBuilder: (context, index) {
          Message msg = chat[index];
          print("msgs length ${chat.length}");
          return buildItem(msg);
        },
        itemCount: chat.length,
        reverse: true,
        controller: _controller,
      ),
    );
  }

  Widget buildItem(Message msg) {
    if (msg.sender == widget.userEmail) {
      // Right (my message)
      return Column(children: [
        sendChat(
          msg.message,
        ),
      ]);
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            receivedChat(msg.message, msg.sender),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  Widget sendChat(
    String text,
  ) {
    return Container(
        margin: EdgeInsets.only(right: 5, top: 10, bottom: 10),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Card(
                  margin: EdgeInsets.only(left: 10),
                  color: Color(0xFF0D67B5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(0),
                          topRight: Radius.circular(15))),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * .7,
                        minWidth: 1),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        text,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
              SizedBox(
                width: 5,
              ),
              // CachedAvatar(
              //   radius: 18,
              //   imageUrl: '${userInfo?.result?.profileImageUrl ?? ""}',
              // ),
            ],
          ),
        ));
  }

  Widget receivedChat(String text, String sender) {
    return Container(
        margin: EdgeInsets.only(right: 5, top: 10, bottom: 10),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Card(
                  margin: EdgeInsets.only(left: 10),
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(0),
                          topRight: Radius.circular(15))),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * .7,
                        minWidth: 1),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        text,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }

  Future<void> fetchChat(String roomId) async {
    var value = await ChatService.messages(roomId);
    if (_streamSubscriptionChat == null) {
      _streamSubscriptionChat = value.listen((event) {
        chat = event;
        print("length of messages ${chat.length} } ");
        setState(() {});
      });
    }
  }
}
