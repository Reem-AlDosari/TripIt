import 'package:trip_it/backend/backend.dart';

class TripBookingModel {
  String price;
  String totalBill;
  String pay;
  String line;
  String userEmail;
  int type;
  int quantity;
  Timestamp createdAt;
  Timestamp bookingDate;
  TripBookingModel(
      {this.type,
      this.createdAt,
      this.totalBill,
      this.pay,
      this.quantity,
      this.line,
      this.price,
      this.userEmail,
      this.bookingDate});
  factory TripBookingModel.fromJson(Map<String, dynamic> json) {
    return TripBookingModel(
      price: json["price"],
      quantity: json["quantity"],
      line: json["line"],
      totalBill: json["total_bill"],
      pay: json["pay"],
      userEmail: json["userEmail"],
      type: json["type"],
      createdAt: json["createdAt"],
      bookingDate: json["bookingDate"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "price": this.price,
      "quantity": this.quantity,
      "total_bill": this.totalBill,
      "line": this.line,
      "pay": this.pay,
      "userEmail": this.userEmail,
      "type": this.type,
      "createdAt": this.createdAt,
      "bookingDate": this.bookingDate,
    };
  }
}
