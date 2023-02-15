import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:trip_it/chat/inbox.dart';
import 'package:trip_it/providers/app_provider.dart';

class AdminInbox extends StatelessWidget {
  const AdminInbox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, _) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF0D67B5),
            centerTitle: true,
            title: Text(
              "Inbox",
            ),
          ),
          body: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("ChatRooms")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot doc = snapshot.data.docs[index];
                              return card(appProvider, doc);
                            });
                      })),
            ],
          ));
    });
  }

  Widget card(AppProvider appProvider, DocumentSnapshot doc) {
    return InkWell(
      onTap: () {
        Get.to(() => Inbox(
              email: doc['users'][0],
              userEmail: appProvider.adminEmail,
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: Get.height * .007, horizontal: Get.width * .05),
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * .03, vertical: Get.height * .02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.blue,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doc['users'][0],
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
