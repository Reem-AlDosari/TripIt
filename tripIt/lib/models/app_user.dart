import 'package:trip_it/backend/backend.dart';

class AppUser {
  String email;
  String gender;
  String uid;
  String userName;
  String phoneNumber;
  Timestamp createdAt;

  AppUser({
    this.email,
    this.gender,
    this.userName,
    this.uid,
    this.phoneNumber,
    this.createdAt,
  });
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      email: json["email"],
      gender: json["Gender"],
      uid: json["uid"],
      userName: json["username"],
      phoneNumber: json["phone"],
      createdAt: json["created_time"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "email": this.email,
      "Gender": this.gender,
      "uid": this.uid,
      "username": this.userName,
      "phone": this.phoneNumber,
      "created_time": this.createdAt,
    };
  }
}
