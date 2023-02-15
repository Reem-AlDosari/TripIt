import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:trip_it/dashboard.dart';
import 'package:trip_it/home_page/home_page_widget.dart';
import 'package:trip_it/passenger_registration/passenger_registration_widget.dart';
import 'package:trip_it/providers/app_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://mipmap/ic_launcher',
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ]);
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // Insert here your friendly dialog box before call the request method
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  AwesomeNotifications().actionStream.listen((receivedNotification) {
    Get.to(DashBoard());
  });
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Stream<TripItFirebaseUser> userStream;
  TripItFirebaseUser initialUser;

  @override
  void initState() {
    super.initState();
    userStream = tripItFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
      ],
      child: GetMaterialApp(
          title: 'TripIt',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', '')],
          theme: ThemeData(primarySwatch: Colors.blue),
          home: initialUser == null
              ? Center(
                  /*  child: Builder(
                      /*  builder: (context) => Image.asset(
                      'assets/images/splash@2x.png',
                      width: MediaQuery.of(context).size.width / 2,
                      fit: BoxFit.fitWidth,
                    ),*/
                      ),*/
                  )
              : currentUser.loggedIn
                  ? HomePageWidget()
                  : HomePageWidget()),
    );
  }
}
