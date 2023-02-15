import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:trip_it/backend/backend.dart';
import 'package:trip_it/confimmembership/confimmembership_widget.dart';
import 'package:trip_it/models/cart_item.dart';
import 'package:trip_it/models/currency.dart';
import 'package:trip_it/providers/app_provider.dart';
import 'package:trip_it/utils/paypal_payment/pay_pal_payment.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

class CartPage extends StatefulWidget {
  final bool dashboard;
  CartPage({this.dashboard = false});
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Product product;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double rate = 3.75;
  double price = 0.0;
  bool isLoadiing = false;
  List<String> docIds = [];
  DateTime now = DateTime.now();
  bool isLoading = false;
  DateTime today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var appProvider = Provider.of<AppProvider>(Get.context, listen: false);
  @override
  void initState() {
    // TODO: implement initState
    convertCurrency(
        "http://api.currencylayer.com/live?access_key=0a187ff1ed668ef1f69f9308e00b7820");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, model, _) {
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: widget.dashboard
              ? PreferredSize(
                  child: SizedBox(), preferredSize: Size.fromHeight(0))
              : AppBar(
                  backgroundColor: Color(0xFF0D67B5),
                  automaticallyImplyLeading: true,
                  actions: [
                    Image.asset(
                      'assets/images/WhatsApp_Image_2021-09-07_at_5.48.48_PM.jpeg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  ],
                  centerTitle: true,
                  elevation: 4,
                ),
          backgroundColor: Color(0xFFCBD8E9),
          body: SafeArea(
            child: model.cartProducts.isEmpty
                ? Center(child: Text("No Items in cart"))
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex:150 ,
                        child: Container(
                          margin: EdgeInsets.only(top: Get.height * .025),
                          height: Get.height,
                          child: ListView.builder(
                              itemCount: model.cartProducts.length,
                              itemBuilder: (context, index) {
                                Product product = model.cartProducts[index];

                                return cartItem(product, model);
                              }),
                        ),
                      ),
                      model.cartProducts.isEmpty ? SizedBox() : Spacer(),
                      isLoading
                          ? Center(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          : Expanded(
                              flex: 0,
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    payTotalBill(model);
                                  },
                                  text: 'Pay Now',
                                  options: FFButtonOptions(
                                    width: 340,
                                    height: 60,
                                    color: Color(0xFF0D67B5),
                                    textStyle:
                                        FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    elevation: 2,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 8,
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
          ),
        );
      },
    );
  }

  Future<void> convertCurrency(String url) async {
    try {
      Uri uri = Uri.parse(url);
      var response = await http.post(
        uri,
      );

      var jsonResponse = json.decode(response.body);
      Currency currency = Currency.fromJson(jsonResponse);

      rate = currency.quotes.uSDSAR;
    } catch (error) {
      print(error);
    }
  }

  Future<void> payCartBill(
      {List<String> docIDs,
      List<Product> cartItems,
      String price,
      AppProvider model}) async {
    print("initializing payment");
    var transId = Timestamp.now().millisecondsSinceEpoch.toString();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPaypalPayment(
          docIds: docIDs,
          cartItems: cartItems,
          transId: transId,
          isTrip: true,
          price: price,
          onFinish: (val) async {
            print("payment finished");
            await FirebaseFirestore.instance
                .collection("Cart")
                .where("user_email", isEqualTo: model.userData.email)
                .get()
                .then((value) {
              value.docs.forEach((element) {
                FirebaseFirestore.instance
                    .collection("Cart")
                    .doc(element.id)
                    .delete();
              });
            });

            Get.to(() => ConfirmMembershipWidget());
          },
        ),
      ),
    );
  }

  Widget cartItem(Product product, AppProvider model) {
    return Container(
        margin: EdgeInsets.only(
            left: Get.width * .02,
            right: Get.width * .02,
            top: Get.height * .01),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white70),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(product.type == 0 ? "" : "Membership"),
                
              ],
            ),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
           
            ),
            
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Line"),
                Text(
                  (product.name) 
                      ,
                ),
              ],
            ), SizedBox(
              height: Get.height * .02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("price"),
                Text(
                  (double.parse(product.price) * product.quantity)
                      .toStringAsFixed(1)+" SR",
                ),
              ],
            ),
            product.type == 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quantity"),
                      model.isLoading
                          ? CircularProgressIndicator(
                              color: Colors.blue,
                            )
                          : Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      product.quantity == 1
                                          ? model.deleteProduct(product)
                                          : model.removeProduct(product);
                                    },
                                    icon: Icon(product.quantity == 1
                                        ? Icons.delete
                                        : Icons.remove)),
                                Text(product.quantity.toString()),
                                IconButton(
                                    onPressed: () {
                                      model.addProduct(product);
                                    },
                                    icon: Icon(Icons.add)),
                              ],
                            ),
                            
                    ],
                  ):
                   product.type == 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quantity"),
                      model.isLoading
                          ? CircularProgressIndicator(
                              color: Colors.blue,
                            )
                          : Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      product.quantity == 1
                                          ? model.deleteProduct(product)
                                          : model.removeProduct(product);
                                    },
                                    icon: Icon(product.quantity == 1
                                        ? Icons.delete
                                        : Icons.remove)),
                                Text(product.quantity.toString()),
                                
                              ],
                            ),
                            
                    ],
                  )
                : SizedBox(),
          ],
        ));
  }

  payTotalBill(AppProvider model) async {
    setState(() {
      isLoading = true;
      price = 0.0;
      docIds = [];
    });
    model.cartProducts.forEach((element) async {
      price = price + double.parse(element.price) * element.quantity;
      docIds.add(element.docId);
      print("doc $element");
    });
    price = price / rate;
    print("price $price");
    await payCartBill(
        cartItems: model.cartProducts,
        docIDs: docIds,
        price: price.toStringAsFixed(0),
        model: model);
    setState(() {
      isLoading = false;
    });
  }
}
