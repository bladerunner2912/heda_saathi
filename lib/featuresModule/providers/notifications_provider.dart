import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:heda_saathi/api.dart';
import 'package:heda_saathi/featuresModule/models/notification.dart';

class NotificationProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Notifications> _notifications = [];
  List<Notifications> get notifications => _notifications;
  List<String> unviewedNotifications = [];

  fetchNotifications() async {
    var url = "${webApi["domain"]}/notifications/fetchNotifications";
    try {
      var response = await http.get(Uri.parse(url));
      var responseBody = json.decode(response.body);
      print(responseBody.length);
      for (int i = 0; i < responseBody.length; i++) {
        var rs = responseBody[i];
        _notifications.add(Notifications(
          id: rs['_id'],
          content: rs['content'],
          title: rs['title'],
          webUrl: rs['webUrl'],
          recievedAt: DateTime.parse(rs['createdAt']),
        ));
        notifyListeners();
      }
    } catch (e) {
      print(e);
      return;
    }
  }

  viewedANotification(String id, String nid) async {
    // ? query to remove that notificationId from unviewedNotifications ,user will have a field unviewedNotification  which will be list of ids of unviewed notification.
    var url = "${webApi["domain"]}/notifications/viewedANotification";
    var str = json.encode({
      "uid": id,
      "nid": nid,
    });
    try {
      var response = await http.post(Uri.parse(url), body: str);
      var responseBody = json.decode(response.body);
      if (responseBody) {
        unviewedNotifications.removeWhere(
          (unid) => unid == nid,
        );
        notifyListeners();
      }
    } catch (e) {
      print(e);
      return;
    }
  }
}
