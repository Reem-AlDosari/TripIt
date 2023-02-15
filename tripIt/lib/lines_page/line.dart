import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:trip_it/backend/backend.dart';
import 'package:trip_it/cart/cart_page.dart';
import 'package:trip_it/cartdashboard.dart';
import 'package:trip_it/confimmembership/confimmembership_widget.dart';
import 'package:trip_it/models/cart_item.dart';
import 'package:trip_it/models/currency.dart';
import 'package:trip_it/models/trip_model.dart';
import 'package:trip_it/providers/app_provider.dart';
import 'package:trip_it/utils/cached_image.dart';
import 'package:trip_it/utils/paypal_payment/pay_pal_payment.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

class LinePage extends StatefulWidget {
  final DocumentSnapshot doc;
  LinePage({@required this.doc});

  @override
  _LinePageState createState() => _LinePageState();
}

class _LinePageState extends State<LinePage> {
  Product product;
  int quant=1;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double rate = 3.75;
  double price;
  DateTime now = DateTime.now();
  Future<void> convertCurrency(String url) async {
    setState(() {
      isLoading = true;
    });
    try {
      Uri uri = Uri.parse(url);
      var response = await http.post(
        uri,
      );

      var jsonResponse = json.decode(response.body);
      Currency currency = Currency.fromJson(jsonResponse);

      rate = currency.quotes.uSDSAR;
      price = double.parse(widget.doc['Price']) / rate;
      print("price ${widget.doc['Price']}");
      print("rate ${currency.quotes.uSDSAR}");
      print("usd  price  $price");
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print(error);
    }
  }

  bool isLoading = false;
  var appProvider = Provider.of<AppProvider>(Get.context, listen: false);
  @override
  void initState() {
    // TODO: implement initState
    product = Product(
        type: 0,
        startDate: Timestamp.now(),
        endDate:
            Timestamp.fromDate(DateTime(now.year, now.month, now.day, 23, 59)),
        quantity: 1,
        //quantity:quant,
        name: widget.doc['Line'],
        price: widget.doc['Price'],
        userEmail: appProvider.userData.email);
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
          appBar: AppBar(
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
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Get.height * .02),
                  child: Center(
                    child: Text(
                      '${widget.doc['Line'].toString().toUpperCase()} line ',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: Get.height * .5,
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedImage(
                      imageUrl: widget.doc['Image'],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Price: ',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              
                              fontSize: 25,
                                
        color: Colors.black,
                              
                            ),
                          ),
                          Text(
                            '${widget.doc['Price']} SR',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                            color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      model.isLoading
                          ? CircularProgressIndicator(
                              color: Colors.blue,
                            )
                          : FFButtonWidget(
                              onPressed: () async {
                                model.cartProducts
                                        .where((element) =>
                                            element.name == widget.doc['Line'])
                                        .toList()
                                        .isNotEmpty
                                    ? Get.to(cartDashBoard())
                                    : model.addToCart(product);
                              },
                              text: model.cartProducts
                                      .where((element) =>
                                          element.name == widget.doc['Line'])
                                      .toList()
                                      .isNotEmpty
                                  ? 'Go to Cart'
                                  : 'Add to cart',
                              options: FFButtonOptions(
                                width: 100,
                                height: 30,
                                color: Color(0xFF0D67B5),
                                textStyle: FlutterFlowTheme.subtitle2.override(
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
                            )
                    ],
                  ),
                ),
            
          Column(
                 
                 
                 children:[ Container(
                   
                          margin: EdgeInsets.only(top: Get.height * .025),
                          height: Get.height,
                         
                          child: ListView.builder(
                            
                              itemCount: model.cartProducts.where((element) =>
                                          element.name == widget.doc['Line']).toList().length,
                              itemBuilder: (context, index) {
                                //Product product = model.cartProducts[index];
                                   List<Product> product = model.cartProducts.where((element) =>
                                          element.name == widget.doc['Line']).toList();
                                return cartItem(product, model);
                              }),
                        ),
                 ]
                 ),
                     
                  
                
         /*   Column(
          children: [
            
            product.type == 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(""),
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
                                          : product.quantity=product.quantity-1; //model.removeProduct(product);
                                    },
                                    icon: Icon(product.quantity == 1
                                        ? Icons.delete
                                        : Icons.remove)),
                                  
                                
                                Text(product.quantity.toString()),
                                IconButton(
                                    onPressed: () {
                                      
                                      
                                      product.quantity=product.quantity+1;
                                     return cartItem(product, model);

                                      //model.addProduct(product);
                                    },

                                    icon: Icon(Icons.add)),
                                     

                              ],
                            ),
                            
                    ],
                  ):
                            
                SizedBox(),
              
               
           
          ],
        ),*/
             
              ],
            ),
          ),
          
        );
      },
    );
    
  }
 add(){
return Text(product.quantity.toString());




 }

  Widget cartItem(List<Product> product1, AppProvider model) {
    Product product;
    product=product1[0];
    return Container(
        
            
        child: Column(
          children: [
          
          
            if (product.type == 0) Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(""),
                      
                          Row(
                              children: [
                              
                                IconButton(
                                    onPressed: () {
                                      if(product.quantity > 1)
                                          model.removeProduct(product);
                                    },
                                    icon: Icon(
                                     
                                         
                                         Icons.remove)),
                                Text(product.quantity.toString()),
                                IconButton(
                                    onPressed: () {
                                      model.addProduct(product);
                                    },
                                    icon: Icon(Icons.add)),
                              ],
                            ),
                            
                    ],
                  ) else SizedBox(),
          ],
        ));
  }

  Future<void> payTripBill({String docID, String price}) async {
    print("initializing payment");
    var transId = Timestamp.now().millisecondsSinceEpoch.toString();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaypalPayment(
          docId: docID,
          transId: transId,
          isTrip: true,
          price: price,
          onFinish: (val) async {
            print("payment finished");
            Get.to(() => ConfirmMembershipWidget());
          },
        ),
      ),
    );
  }
}
