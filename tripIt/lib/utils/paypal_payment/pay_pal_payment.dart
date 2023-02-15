import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_it/models/cart_item.dart';
import 'package:trip_it/utils/paypal_payment/pay_pal.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalPayment extends StatefulWidget {
  final Function onFinish;
  String docId;
  String transId;
  String price;

  bool isTrip;
  bool isMembership;
  PaypalPayment({
    this.docId,
    this.transId,
    this.price,
    this.onFinish,
    this.isTrip = false,
    this.isMembership = false,
  });

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String checkoutUrl;
  String executeUrl;
  String accessToken;
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();
        print('its accesss token:$accessToken');
        final transactions = getOrderParams();
        print('its transaction :$transactions');
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        print('payment exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  // item name, price and quantity
  String itemName = 'iPhone X';
  String itemPrice = '1.99';
  int quantity = 1;

  Map<String, dynamic> getOrderParams() {
    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": widget.price ?? '0',
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": widget.price ?? '0',
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(checkoutUrl);

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios_rounded),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services
                    .executePayment(
                  widget.transId,
                  executeUrl,
                  payerID,
                  accessToken,
                  widget.price,
                  widget.isTrip,
                  widget.isMembership,
                  widget.docId,
                )
                    .then((id) {
                  widget.onFinish(id);
                });
              } else {
                Get.back();
              }
              Get.back();
            }
            if (request.url.contains(cancelURL)) {
              Get.back();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}

class CartPaypalPayment extends StatefulWidget {
  final Function onFinish;
  List<String> docIds;
  List<Product> cartItems;
  String transId;
  String price;

  bool isTrip;
  bool isMembership;
  CartPaypalPayment({
    this.docIds,
    this.transId,
    this.cartItems,
    this.price,
    this.onFinish,
    this.isTrip = false,
    this.isMembership = false,
  });

  @override
  State<StatefulWidget> createState() {
    return CartPaypalPaymentState();
  }
}

class CartPaypalPaymentState extends State<CartPaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String checkoutUrl;
  String executeUrl;
  String accessToken;
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();
        print('its accesss token:$accessToken');
        final transactions = getOrderParams();
        print('its transaction :$transactions');
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        print('payment exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  // item name, price and quantity
  String itemName = 'iPhone X';
  String itemPrice = '1.99';
  int quantity = 1;

  Map<String, dynamic> getOrderParams() {
    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": widget.price ?? '0',
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": widget.price ?? '0',
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(checkoutUrl);

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios_rounded),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services
                    .executeCartPayment(
                  widget.transId,
                  executeUrl,
                  payerID,
                  accessToken,
                  widget.price,
                  widget.docIds,
                  widget.cartItems,
                )
                    .then((id) {
                  widget.onFinish(id);
                });
              } else {
                Get.back();
              }
              Get.back();
            }
            if (request.url.contains(cancelURL)) {
              Get.back();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}
