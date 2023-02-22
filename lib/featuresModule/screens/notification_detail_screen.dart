import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/providers/auth_provider.dart';
import 'package:heda_saathi/authModule/widgets/app_bar.dart';
import 'package:heda_saathi/featuresModule/widgets/genreric_header.dart';
import 'package:provider/provider.dart';

import '../models/notification.dart';

class NotificationDetailScreen extends StatefulWidget {
  final Notifications notification;
  final bool openedFirstTime;
  const NotificationDetailScreen(
      {required this.notification, required this.openedFirstTime, super.key});

  @override
  State<NotificationDetailScreen> createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.openedFirstTime) myInit();
  }

  myInit() async {
    final uid = Provider.of<AuthProvider>(context, listen: false).loadedUser.id;
    await Provider.of<AuthProvider>(context, listen: false)
        .viewedANotification(uid, widget.notification.id);
    // ignore: use_build_context_synchronously
  }

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: customAppBar(dW),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Header(dW: dW, tS: tS, pageName: 'Notification Details'),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 4, bottom: dW * 0.15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                  ),
                  child: Text(
                    'TITLE',
                    style: TextStyle(
                        fontSize: 24 * tS, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  widget.notification.title,
                  style: TextStyle(fontSize: 19 * tS),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 4, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                  ),
                  child: Text(
                    'DETAILS',
                    style: TextStyle(
                        fontSize: 24 * tS, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  widget.notification.content,
                  style: TextStyle(fontSize: 19 * tS),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
