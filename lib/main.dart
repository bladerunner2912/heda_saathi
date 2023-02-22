import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:heda_saathi/api.dart';
import 'package:heda_saathi/authModule/providers/advertisment_provider.dart';
import 'package:heda_saathi/authModule/providers/auth_provider.dart';
import 'package:heda_saathi/authModule/providers/family_provider.dart';
import 'package:heda_saathi/featuresModule/providers/search_provider.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'authModule/screens/splash_screen.dart';
import 'featuresModule/providers/notifications_provider.dart';

final LocalStorage storage = LocalStorage('HedaSaathi');

awaitStorageReady() async {
  await storage.ready;
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'hedaji-2b9e8', // id
  'hedaji', // title
  importance: Importance.high,
);

Future<void> _storeNotifications(RemoteNotification notification) async {
  var url = "${webApi["domain"]}/notifications/createNotification";
  var str = {
    "title": notification.title,
    "content": notification.body,
    "webUrl": notification.android!.link ?? "",
    "imageUrl": notification.android!.imageUrl ?? ""
  };
  try {
    await http.post(Uri.parse(url), body: str);
    // print(response.body);
  } catch (e) {
    // print(e);
    return;
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  _storeNotifications(message.notification!);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await firebaseMessaging.setForegroundNotificationPresentationOptions(
    alert: true,
    sound: true,
    badge: true,
  );

  onSelectNotification(dynamic payload) async {
  }

  // // onDidRecieveLocalNotification(
  // //     int id, String? title, String? body, String? payload) {
  // //   print('received');
  // // }

  var initializationSettingsAndroid = const AndroidInitializationSettings(
      '@mipmap/heda_saathi'); // <- default icon name is @mipmap/ic_launcher

  // // var initializationSettingsIOS = DarwinInitializationSettings(
  // //     onDidReceiveLocalNotification: onDidRecieveLocalNotification);

  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification);

  // !  If message comes what should happen. NotificationDetails is widget responsible for the hovering thing.
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    // print(notification);
    // print(android);
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              priority: Priority.high,
            ),
          ));

      _storeNotifications(notification);
    }
  });

  // await Firebase.initializeApp();
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // print(fcmToken);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  // print('User granted permission: ${settings.authorizationStatus}');

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message}');

  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  // });

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');

  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  // });

  // FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //     alert: true, badge: true, sound: true);

//    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   _firebaseMessaging.configure(
//     onMessage: (Map<String, dynamic> message) async {
//       print("onMessage: $message");
//     },
//     onLaunch: (Map<String, dynamic> message) async {
//       print("onLaunch: $message");
//     },
//     onResume: (Map<String, dynamic> message) async {
//       print("onResume: $message");
//     },
//   );

//  var initializationSettingsAndroid =
//       AndroidInitializationSettings('app_icon');
//   var initializationSettingsIOS = DarwinInitializationSettings(
//       onDidReceiveLocalNotification: (int id, String title, String body, String payload) =>
//           onSelectNotification(payload));
//   var initializationSettings = InitializationSettings(
//     android :  initializationSettingsAndroid,iOS: initializationSettingsIOS);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: onSelectNotification);
// }

// Future onSelectNotification(String payload) async {
// }

// _firebaseMessaging.requestNotificationPermissions();
//   _firebaseMessaging.getToken().then((String token) {
//     assert(token != null);
//     print("Firebase Messaging Token: $token");
//   });

//   firebaseMessaging.configure(
//     onMessage: (Map<String, dynamic> message) async {
//       print("onMessage: $message");
//       var notification = message['notification'];
//       var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'your channel id',
//         'your channel name',
//         'your channel description',
//         importance: Importance.Max,
//         priority: Priority.High,
//       );
//       var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//       var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iOSFlutterLocalNotificationsPlugin);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FamiliesProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => AdvertismentProvider())
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
