import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:heda_saathi/common_functions.dart';
import 'package:heda_saathi/homeModule/models/saathi_model.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '/api.dart';

class SearchProvider with ChangeNotifier {
  List<Saathi> _searchedMembers = [];
  List<Saathi> presentEvents = [];
  List<Saathi> pastEvents = [];
  List<Saathi> upcomingEvents = [];

  int limit = 10;
  int skip = 0;

  late Saathi birthdayFetchUser;

  List<Saathi> get searchedMembers => _searchedMembers;

  clear() {
    _searchedMembers = [];
  }

  allEventsUserSearch(String userId) {
    List<Saathi> allEventFetched = [];
    allEventFetched.addAll(presentEvents);
    allEventFetched.addAll(pastEvents);
    allEventFetched.addAll(upcomingEvents);

    return allEventFetched.firstWhere((user) => user.userId == userId);
  }

  searchMember({
    String? name = '',
    required String gender,
    String? place = '',
    String? profession = '',
    String? mobileNo = '',
    DateTime? birth,
  }) async {
    var url = '${webApi['domain']}/users/searchMembers';

    Map<String, String> sendStr;

    sendStr = {
      'gender': gender,
    };

    if (birth != null) {
      sendStr.addAll({'dob': birth.toIso8601String()});
      //  /.ad({'dob': DateFormat('dd/MM/yyyy').format(birth)});
    }

    if (mobileNo != '' && mobileNo != null) {
      sendStr.addAll({'phone': mobileNo});
    }

    if (name != '' && name != null) {
      sendStr.addAll({'name': name});
    }

    if (place != '' && place != null) {
      sendStr.addAll({'city': place});
    }

    if (profession != '' && profession != null) {
      sendStr.addAll({'profession': profession});
    }

    var str = json.encode(sendStr);

    try {
      final response = await http.post(
        Uri.parse(url),
        body: str,
        headers: {
          "Content-Type": "application/json",
        },
      );

      var responseData = json.decode(response.body);
      print(responseData);
      // print(responseData['users'][0]['_id']);
      loadSaathis(responseData, searchedMembers, 'users');

      skip += limit;
      notifyListeners();
      return searchedMembers;
    } catch (e) {
      print(e);
      return searchedMembers;
    }
  }

  fetchBirthdaysAndAnniversary() async {
    presentEvents.clear();
    pastEvents.clear();
    upcomingEvents.clear();

    var url = '${webApi['domain']}/users/birthdayAnniversary';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );
      var responseData = json.decode(response.body);
      print(responseData);
      loadSaathis(responseData, presentEvents, 'presentEvents');
      loadSaathis(responseData, pastEvents, 'pastEvents');
      loadSaathis(responseData, upcomingEvents, 'upcomingEvents');
    } catch (e) {
      throw e;
    }
  }
}
