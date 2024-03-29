import 'package:flutter/material.dart';
import 'package:heda_saathi/featuresModule/screens/anniversary_screen.dart';
import 'package:heda_saathi/featuresModule/widgets/genreric_header.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // onSelectNotification(dynamic payload) async {
  //   print('clicked');
  // }

  // onDidRecieveLocalNotification(
  //     int id, String? title, String? body, String? payload) {
  //   print('received');
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var initializationSettingsAndroid = const AndroidInitializationSettings(
    //     '@mipmap/heda_saathi'); // <- default icon name is @mipmap/ic_launcher
    // var initializationSettingsIOS = DarwinInitializationSettings(
    //     onDidReceiveLocalNotification: onDidRecieveLocalNotification);

    // var initializationSettings = InitializationSettings(
    //     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onDidReceiveNotificationResponse: onSelectNotification);

    // flutterLocalNotificationsPlugin.show(
    //     0,
    //     'New Post',
    //     'asd',
    //     const NotificationDetails(
    //         android: AndroidNotificationDetails(
    //       'hedaji-2b9e8',
    //       'hedaji',
    //       autoCancel: true,
    //       playSound: true,
    //     )),
    //     payload: 'asdasd');
  }

  @override
  Widget build(BuildContext context) {
    final dH = MediaQuery.of(context).size.height;
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(dW: dW, tS: tS, pageName: 'Notifications'),
        const Padding(
          padding: EdgeInsets.only(left: 12.0, top: 14),
          child: Text('Notifications: ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ),
        Container(
          height: dH * 0.7,
          color: Colors.white,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: dW * 0.04),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(children: [
                DummyTile(dW: dW, tS: tS, opened: true),
                DummyTile(dW: dW, tS: tS, opened: true),
                DummyTile(dW: dW, tS: tS, opened: true),
                DummyTile(dW: dW, tS: tS),
                DummyTile(dW: dW, tS: tS),
                DummyTile(dW: dW, tS: tS),
                DummyTile(dW: dW, tS: tS),
                DummyTile(dW: dW, tS: tS),
                DummyTile(dW: dW, tS: tS),
                SizedBox(
                  height: dW * 0.3,
                ),
              ])
            ]),
          ),
        ),
      ],
    );
  }
}
