import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_it/chat/message.dart';

class ChatService {
  static Future<Stream<List<Message>>> messages(String roomId) async {
    var ref = FirebaseFirestore.instance
        .collection("Chats")
        .where('room_id', isEqualTo: roomId)
        .orderBy('created_at', descending: true)
        .snapshots()
        .asBroadcastStream();
    var x = ref.map(
        (event) => event.docs.map((e) => Message.fromJson(e.data())).toList());
    return x;
  }
}
