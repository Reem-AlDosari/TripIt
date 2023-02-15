import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_it/chat/chatroom_model.dart';

class InitiateChat {
  String peerId;
  String userId;
  InitiateChat({
    @required this.peerId,
    @required this.userId,
  });
  List<ChatRoomModel> chatRooms = [];
  DocumentSnapshot myChatRoom;
  var db = FirebaseFirestore.instance;
  Future<ChatRoomModel> now() async {
    QuerySnapshot querySnapshot = await db.collection("ChatRooms").get();
    querySnapshot.docs.forEach((element) {
      chatRooms.add(ChatRoomModel.fromJson(element));
    });
    if (!EmptyList.isTrue(querySnapshot.docs)) {
      List<ChatRoomModel> roomInfo = chatRooms
          .where((element) =>
              (element.createdBy == userId || element.createdBy == peerId) &&
              (element.peerId == peerId || element.peerId == userId))
          .toList();
      if (EmptyList.isTrue(roomInfo)) {
        myChatRoom = await getRoomDoc();
        return ChatRoomModel.fromJson(myChatRoom.data());
      } else {
        return roomInfo[0];
      }
    } else {
      DocumentSnapshot doc = await getRoomDoc();

      return ChatRoomModel.fromJson(doc);
    }
  }

  Future<DocumentSnapshot> getRoomDoc() async {
    String docId = DateTime.now().millisecondsSinceEpoch.toString();
    ChatRoomModel chatRoomModel = ChatRoomModel(
      createdAt: Timestamp.now(),
      createdBy: userId,
      roomId: docId,
      peerId: peerId,
      supportChat: 0,
      users: [userId, peerId],
    );
    print(chatRoomModel.toJson());
    await db.collection("ChatRooms").doc(docId).set(chatRoomModel.toJson());
    DocumentSnapshot chatRoomDoc =
        await db.collection("ChatRooms").doc(docId).get();
    return chatRoomDoc;
  }
}

class EmptyList {
  static bool isTrue(List list) {
    if (list == null || list.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
