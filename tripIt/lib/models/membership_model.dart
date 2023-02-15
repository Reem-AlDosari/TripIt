import 'package:trip_it/backend/backend.dart';

class MemberShipModel {
  String price;
  String pay;
  String userEmail;
  String type;

  Timestamp startDate;
  MemberShipModel(
      {this.type, this.pay, this.price, this.userEmail, this.startDate});
  factory MemberShipModel.fromJson(Map<String, dynamic> json) {
    return MemberShipModel(
      price: json["Price"],
      pay: json["pay"],
      userEmail: json["email"],
      type: json["type"],
      startDate: json["Startdate"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "Price": this.price,
      "pay": this.pay,
      "email": this.userEmail,
      "type": this.type,
      "Startdate": this.startDate,
    };
  }
}
