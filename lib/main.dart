import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/providers/auth_provider.dart';
import 'package:heda_saathi/authModule/providers/family_provider.dart';
import 'package:heda_saathi/featuresModule/providers/search_provider.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'authModule/screens/splash_screen.dart';

final LocalStorage storage = LocalStorage('HedaSaathi');

awaitStorageReady() async {
  await storage.ready;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 final fcmToken = await FirebaseMessaging.instance.getToken();
 FirebaseMessaging messaging = FirebaseMessaging.instance;
 
   NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FamiliesProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Heda Saathi',
      theme: ThemeData(
        //configure as early as possible
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
