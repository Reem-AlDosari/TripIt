import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_it/flutter_flow/flutter_flow_theme.dart';

class ConfirmSheet extends StatefulWidget {
  final void Function() onConfirm;
  ConfirmSheet({
    @required this.onConfirm,
  });
  @override
  _ConfirmSheetState createState() => _ConfirmSheetState();
}

class _ConfirmSheetState extends State<ConfirmSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.03),
      height: Get.height * .37,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: Get.height * 0.12,
            child: Image.asset(
              "assets/images/logoutPic.png",
            ),
          ),
          Container(
            width: Get.width * 0.5,
            child: Text(
              "Are you sure,\n You want to logout",
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Lexend Deca',
                fontSize: 20,
                color: Color(0xFF0D67B5),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: Get.width,
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(width: 1, color: Color(0xFF0D67B5)),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text(
                          "No",
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF0D67B5),
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: widget.onConfirm,
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: Get.width,
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Color(0xFF0D67B5),
                        ),
                        child: Text(
                          "Yes",
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
