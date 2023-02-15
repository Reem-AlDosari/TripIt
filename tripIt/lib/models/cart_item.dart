import 'package:trip_it/backend/backend.dart';

class Product {
  String price;
  String docId;
  String memberShipType;
  String name;
  String userEmail;
  int type;
  int quantity;
  bool isMembership;
  Timestamp startDate;
  Timestamp endDate;
  Product({
    this.type,
    this.memberShipType,
    this.docId,
    this.startDate,
    this.endDate,
    this.name,
    this.isMembership = false,
    this.quantity = 1,
    this.price,
    this.userEmail,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      price: json["price"],
      memberShipType: json["membership_type"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      isMembership: json["is_membership"],
      docId: json["doc_id"],
      name: json["name"],
      quantity: json["quantity"],
      userEmail: json["user_email"],
      type: json["type"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "price": this.price,
      "membership_type": this.memberShipType,
      "start_date": this.startDate,
      "end_date": this.endDate,
      "is_membership": this.isMembership,
      "quantity": this.quantity,
      "user_email": this.userEmail,
      "type": this.type,
      "doc_id": this.docId,
      "name": this.name,
    };
  }
}
