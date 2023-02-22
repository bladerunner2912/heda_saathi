import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/providers/auth_provider.dart';
import 'package:heda_saathi/featuresModule/widgets/notification_tile.dart';
import 'package:heda_saathi/featuresModule/widgets/genreric_header.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<String> unviewedNotifications = [];

  @override
  Widget build(BuildContext context) {
    final dH = MediaQuery.of(context).size.height;
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    unviewedNotifications =
        Provider.of<AuthProvider>(context).unviewedNotifications;
    final notifications = Provider.of<AuthProvider>(context).notifications;
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
                ...List.generate(
                    notifications.length,
                    (index) => NotificationTile(
                          dW: dW,
                          tS: tS,
                          notification: notifications[index],
                          opened: unviewedNotifications
                              .contains(notifications[index].id),
                        )),
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
