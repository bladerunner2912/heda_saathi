import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:heda_saathi/authModule/models/family_model.dart';
import 'package:heda_saathi/common_functions.dart';
import 'package:heda_saathi/homeModule/models/saathi_model.dart';
import 'package:http/http.dart' as http;
import '../../api.dart';

class FamiliesProvider with ChangeNotifier {
  List<Saathi> familyMembers = [];

  // ignore: prefer_typing_uninitialized_variables
  var userIndex;

  // ignore: prefer_final_fields
  Family _family = Family(id: '1', memberIds: [], metaData: [[]]);

  Family get family => _family;

// ! MAIN FUNCTION
  loadFamilyandRelations(String familyId, String userId) async {
    familyMembers.clear();
    _family = Family(id: '', memberIds: [], metaData: [[]]);

    // fetches the family from database
    await fetchFamily(familyId: familyId);

    // fetches the members data from database
    await fetchMembers(userId: userId);

    // loads the relations based on the _relations array.
    loadRelations(userId);
    notifyListeners();
  }

  fetchFamily({String familyId = ''}) async {
    //fetchFamilyQuery.
    try {
      var url = '${webApi['domain']}/families/family/';

      var str = json.encode({"familyId": familyId});
      final response = await http.post(
        Uri.parse(url),
        body: str,
      );

      var responseBody = json.decode(response.body);
      List<String> membersIdsString = [];
      for (int i = 0; i < responseBody["family"]["memberIds"].length; i++) {
        var id = responseBody["family"]["memberIds"][i].toString();
        membersIdsString.add(id);
      }
      _family = Family(
        id: responseBody['family']["_id"],
        memberIds: membersIdsString,
        metaData: responseBody['family']['metaData'],
      );
    } catch (error) {
      _family = Family(id: '', memberIds: [], metaData: [[]]);
    }
  }

  fetchMembers({required String userId}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };

    var url = "${webApi['domain']}/users/fetchMembers";
    var ids = family.memberIds;
    userIndex = family.memberIds.indexOf(userId);
    var str = json.encode({"ids": ids});

    try {
      var response =
          await http.post(Uri.parse(url), body: str, headers: headers);
      var responseData = (json.decode(response.body));
      loadSaathis(responseData, familyMembers, 'saathis');
    } catch (e) {
      return;
    }
  }

  loadRelations(userId) {
    int i = 0;
    //iterates over all the members present in the family
    for (var id in family.memberIds) {
      // ? if index == userIndex then remove that from members list as we dont need to see our own profile.
      if (i == userIndex) {
        familyMembers.removeAt(i);
        i++;
        continue;
      }

      // ? checks the relation metadataId for the family.
      var metaDataId = family.metaData[userIndex][i];

      // ? flag to control reverse
      var flag = 0;

      // ?
      if (metaDataId < 0) {
        metaDataId = metaDataId * (-1);
        flag = 1;
      }

      familyMembers.firstWhere((saathi) => saathi.userId == id).relation =
          _relations[metaDataId][flag];
      i++;
    }
  }

  // /*IMP!*/
  static const List<List<String>> _relations = [
    ['Self', 'Self'],
    ['Husband', 'Wife'],
    ['Father', 'Son'],
    ['Mother', 'Son'],
    ['Father', 'Daughter'],
    ['Mother', 'Daughter'],
    ["Father I/L", "Daughter I/L"],
    ["Mother I/L", "Daughter I/L"],
    ["Grand Father", "Grand Son"],
    ["Grand Mother", "Grand Son"],
    ["Grand Father", "Grand Daughter"],
    ["Grand Mother", "Grand Daughter"],
    ["Grand Father I/L", "Grand Daughter I/L"],
    ["Grand Mother I/L", "Grand Daughter I/L"],
    ["Uncle", "Nephew"],
    ["Aunt", "Nephew"],
    ["Uncle", "Neice"],
    ["Aunt", "Neice"],
    ["Brother", "Brother"],
    ["Brother", "Sister"],
    ["Sister", "Sister"],
    ["Brother I/L", "Sister I/L"],
    ["Sister I/L", "Sister I/L"],
    ["Cousin", "Cousin"],
    ["Father I/L", "Son I/L"],
    ["Mother I/L", "Son I/L"],
    ["Brother I/L", "Brother I/L"],
  ];
}
