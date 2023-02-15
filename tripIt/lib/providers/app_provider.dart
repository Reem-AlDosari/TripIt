import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_it/chat/inbox.dart';
import 'package:trip_it/chat/initiate_chat.dart';
import 'package:trip_it/models/app_user.dart';
import 'package:trip_it/models/cart_item.dart';

class AppProvider with ChangeNotifier {
  bool isLoading = false;
  StreamSubscription _ssCart;
  StreamSubscription _ssUsers;
  AppUser userData = AppUser();
  String adminEmail = "waad@gmail.com";
  var uid;
  TextEditingController searchTC = TextEditingController();
  getUserData() async {
    uid = await FirebaseAuth.instance.currentUser.uid;
    userData = await getUserFromDB(uid);
    await fetchMyCart();
  }

  startChat() async {
    startLoader();
    await InitiateChat(
      userId: userData.email,
      peerId: adminEmail,
    ).now().then((value) async {
      stopLoader();
      await Get.to(Inbox(
        roomId: value.roomId,
        email: adminEmail,
        userEmail: userData.email,
      ));
    });
  }

  startLoader() {
    isLoading = true;
    notifyListeners();
  }

  stopLoader() {
    isLoading = false;
    notifyListeners();
  }

  Future<AppUser> getUserFromDB(String uid) async {
    print("$uid");
    startLoader();
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('Passenger').doc(uid).get();
    stopLoader();
    if (!doc.exists) {
      return null;
    }
    AppUser user = AppUser.fromJson(doc.data() as Map<String, dynamic>);
    print(user.email);
    return user;
  }

  List<Product> cartProducts = [];
  List<AppUser> appUsers = [];
  List<AppUser> searchedUsers = [];

  Future<void> updateUserProfile(AppUser user) async {
    startLoader();

    await FirebaseFirestore.instance
        .collection('Passenger')
        .doc(userData.uid)
        .update({
      "Gender": user.gender,
      "phone": user.phoneNumber,
      "username": user.userName,
    });
    userData = await getUserFromDB(uid);
    stopLoader();
    // Fluttertoast.showToast(msg: "Profile updated");
  }

  Future<void> addToCart(Product product) async {
    startLoader();

    await FirebaseFirestore.instance
        .collection('Cart')
        .add(product.toJson())
        .then((value) async {
      FirebaseFirestore.instance
          .collection('Cart')
          .doc(value.id)
          .update({"doc_id": value.id});
    });

    stopLoader();
    notifyListeners();
  }

  Future<void> addMembershipToCart(Product product) async {
    startLoader();

    await FirebaseFirestore.instance
        .collection('Cart')
        .add(product.toJson())
        .then((value) async {
      FirebaseFirestore.instance
          .collection('Cart')
          .doc(value.id)
          .update({"doc_id": value.id});
    });

    stopLoader();
    notifyListeners();
  }

  addProduct(Product product) async {
    startLoader();
    await FirebaseFirestore.instance
        .collection('Cart')
        .doc(product.docId)
        .update({
      'quantity': product.quantity + 1,
      "total_bill": (double.parse(product.price) * (product.quantity + 1))
          .toStringAsFixed(2)
    });
    stopLoader();
  }

  removeProduct(Product product) async {
    startLoader();
    await FirebaseFirestore.instance
        .collection('Cart')
        .doc(product.docId)
        .update({
      'quantity': product.quantity - 1,
      "total_bill": (double.parse(product.price) * (product.quantity - 1))
          .toStringAsFixed(2)
    });
    stopLoader();
  }

  deleteProduct(Product product) async {
    startLoader();
    await FirebaseFirestore.instance
        .collection('Cart')
        .doc(product.docId)
        .delete();
    await FirebaseFirestore.instance
        .collection('Booking')
        .doc(product.docId)
        .delete();
    stopLoader();
  }

  static Future<Stream<List<Product>>> myCart(String userId) async {
    var ref = FirebaseFirestore.instance
        .collection('Cart')
        .where("user_email", isEqualTo: userId)
        .snapshots()
        .asBroadcastStream();
    var x = ref.map((event) => event.docs
        .map((e) => Product.fromJson(e.data() as Map<String, dynamic>))
        .toList());
    return x;
  }

  Future<void> fetchMyCart() async {
    print("fetch Cart");
    var value = await myCart(userData.email);
    if (_ssCart == null) {
      _ssCart = value.listen((event) {
        cartProducts = event;

        print("length of new cart products ${cartProducts.length}");

        notifyListeners();
      });
    }
  }

  onDispose() {
    _ssCart = null;
    _ssUsers = null;
    _ssUsers.cancel;
    _ssCart.cancel;
  }

  static Future<Stream<List<AppUser>>> getAppUsers() async {
    var ref = FirebaseFirestore.instance
        .collection('Passenger')
        .snapshots()
        .asBroadcastStream();
    var x = ref.map((event) => event.docs
        .map((e) => AppUser.fromJson(e.data() as Map<String, dynamic>))
        .toList());
    return x;
  }

  Future<void> fetchAllUsers() async {
    print("fetching users");
    var value = await getAppUsers();
    if (_ssUsers == null) {
      _ssUsers = value.listen((event) {
        appUsers = event;

        print("Total number of app users ${appUsers.length}");

        notifyListeners();
      });
    }
  }

  searchUsers() {
    searchedUsers = appUsers
        .where(
            (element) => element.phoneNumber.toString().contains(searchTC.text))
        .toList();
    notifyListeners();
    searchedUsers = appUsers
        .where(
            (element) => element.phoneNumber.toString().isEmpty?
            Center(child: Text("No passenger found")):("bkghjb"));
  }
}
