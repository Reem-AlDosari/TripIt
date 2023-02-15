import 'dart:async';
import 'dart:convert' as convert;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart';
import 'package:trip_it/backend/schema/membership_record.dart';
import 'package:trip_it/models/cart_item.dart';
import 'package:trip_it/models/trip_model.dart';

class PaypalServices {
  String domain = "https://api.sandbox.paypal.com";
  // for sandbox mode
//  String domain = "https://api.paypal.com"; // for production mode

  //Sand Box
  String clientId =
      'AXRue6AGH-X2nmu5lCT7DcWeTFgFz6MGK7wnrEpCrZCMSGrOtVX6DoqRW35hCLa4Za3yUHZoYjWXYpIL';
  String secret =
      'EAcOhAoETfedTLnc2nMxtxoX-upJi1thBBGqIbF_w4pgQLR26n5_dWsvdcqhKxUXr3jsGl5QylfrnzZq';

  ///Live
/////Not added live keys yet ..........

  // for getting the access token from Paypal
  Future<String> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      Uri uri =
          Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials');
      var response = await client.post(uri);
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>> createPaypalPayment(
      transactions, accessToken) async {
    try {
      Uri uri2 = Uri.parse("$domain/v1/payments/payment");
      var response = await http.post(uri2,
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      print("payment api response $body");
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return null;
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<String> executePayment(
    transId,
    url,
    payerId,
    accessToken,
    servicePrice,
    bool isTrip,
    bool isMembership,
    docId,
  ) async {
    try {
      Uri uri = Uri.parse(url);
      var response = await http.post(uri,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        var doc = convert.json.decode(response.body).toString();
        DateTime dateTime = DateTime.now().toLocal();
        double price = double.parse(servicePrice);
        if (isTrip) {
          await FirebaseFirestore.instance
              .collection("Booking")
              .doc(docId)
              .update({
            'pay': "paid",
          });
        } else if (isMembership) {
          await FirebaseFirestore.instance
              .collection("Membership")
              .doc(docId)
              .update({
            'pay': "paid",
          });
        } else {
          print("none");
        }
        print(response);

        print(body);
        return body["id"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // for executing the cart payment transaction
  Future<String> executeCartPayment(
    transId,
    url,
    payerId,
    accessToken,
    servicePrice,
    List<String> docIds,
    List<Product> cartItems,
  ) async {
    try {
      Uri uri = Uri.parse(url);
      var response = await http.post(uri,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        cartItems.forEach((element) async {
          if (element.isMembership) {
            final membershipCreateData = createMembershipRecordData(
              price: element.price,
              startdate: element.startDate.toDate(),
              endDate: element.endDate.toDate(),
              type: element.memberShipType,
              pay: "paid",
              email: element.userEmail,
            );
            print(membershipCreateData.toString());

            var now = Timestamp.now().millisecondsSinceEpoch.toString();
            await MembershipRecord.collection
                .doc(now)
                .set(membershipCreateData);
            await callReminder("Membership purchased",
                "You have purchased a membership", DateTime.now());
            await callReminder(
                "Membership Expired",
                "Your membership will be expired today",
                element.endDate.toDate());
            await FirebaseFirestore.instance
                .collection("Cart")
                .doc(element.docId)
                .delete();
          } else {
            TripBookingModel trip = TripBookingModel(
              price: element.price,
              quantity: element.quantity,
              createdAt: Timestamp.now(),
              line: element.name,
              bookingDate: element.startDate,
              totalBill: (double.parse(element.price) * (element.quantity))
                  .toStringAsFixed(2),
              type: 0,
              pay: "paid",
              userEmail: element.userEmail,
            );
            await FirebaseFirestore.instance
                .collection("Booking")
                .doc(element.docId)
                .set(trip.toJson());
            await FirebaseFirestore.instance
                .collection("Cart")
                .doc(element.docId)
                .delete();
          }
        });
        print(response);

        return body["id"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> callReminder(String msg, String title, DateTime date) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10, channelKey: 'basic_channel', title: title, body: msg));
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    String utcTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'scheduled',
          title: title,
          body: msg,
          notificationLayout: NotificationLayout.Default,
        ),
        schedule: NotificationCalendar.fromDate(date: date));
  }
}
