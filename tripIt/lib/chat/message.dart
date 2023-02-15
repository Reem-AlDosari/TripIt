import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String sender;
  String receiver;
  Timestamp createdAt;
  String roomId;
  String message;
  bool isSeen;
  int type;

  Message(
      {this.sender,
        this.receiver,
        this.createdAt,
        this.roomId,
        this.message,
        this.isSeen,
        this.type});

  Message.fromJson(Map<String, dynamic> json) {
    sender = json['sender_id'];
    receiver = json['receiver_id'];
    createdAt = json['created_at'];
    roomId = json['room_id'];
    message = json['message'];
    isSeen = json['seen'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender_id'] = this.sender;
    data['receiver_id'] = this.receiver;
    data['created_at'] = this.createdAt;
    data['room_id'] = this.roomId;
    data['message'] = this.message;
    data['seen'] = this.isSeen;
    data['type'] = this.type;
    return data;
  }
}
