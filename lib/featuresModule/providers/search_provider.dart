import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:heda_saathi/homeModule/models/saathi_model.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '/api.dart';

class SearchProvider with ChangeNotifier {
  List<Saathi> _searchedMembers = [];
  int limit = 10;
  int skip = 0;

  List<Saathi> get searchedMembers => _searchedMembers;

  clear() {
    _searchedMembers = [];
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
      sendStr.addAll({'dob': DateFormat('dd/MM/yyyy').format(birth)});
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
        headers: {"Content-Type": "application/json",},
      );

      var responseData = json.decode(response.body);
      print(responseData);
      // print(responseData['users'][0]['_id']);
      for (int i = 0; i < responseData['users'].length; i++) {
        var rs = responseData['users'][i];
        searchedMembers.add(Saathi(
            userId: rs['userId'],
            dob: DateTime.now(),
            email: rs['email'],
            profession: rs['profession'] ?? 'DOCTORRR',
            place: rs['place'] ?? 'DOCTORRR',
            phone: rs['phone'] ?? 'DOCTORRR',
            gender: rs['gender'] ?? 'DOCTORRR',
            avatar: rs['avatar']??'',
            name: rs['name'] ?? 'DOCTORRR'));
      }

      skip += limit;
      notifyListeners();
      return searchedMembers;
    } catch (e) {
      print(e);
      return searchedMembers;
    }
  }
}
