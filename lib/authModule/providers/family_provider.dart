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

  loadFamilyandRelations(String familyId, String userId) async {
    familyMembers.clear();
    _family = Family(id: '', memberIds: [], metaData: [[]]);

    await fetchFamily(familyId: familyId);

    await fetchMembers(userId: userId);

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
        print(id);
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
      print(responseData);
      loadSaathis(responseData, familyMembers, 'saathis');
    } catch (e) {
      print(e);
    }
  }

  loadRelations(userId) {
    int i = 0;
    for (var id in family.memberIds) {
      if (i == userIndex) {
        familyMembers.removeAt(i);
        i++;
        continue;
      }
      var metaDataId = family.metaData[userIndex][i];
      var flag = 1;
      if (metaDataId < 0) {
        metaDataId = metaDataId * (-1);
        flag = 0;
      }
      familyMembers.firstWhere((saathi) => saathi.userId == id).relation =
          _relations[metaDataId][flag];
      i++;
    }
  }

  // /*IMP!*/
  static const List<List<String>> _relations = [
    ['SELF', 'SELF'],
    ['HUSBAND', 'WIFE'],
    ['FATHER', 'SON'],
    ['FATHER', 'DAUGHTER'],
    ['MOTHER', 'SON'],
    ['MOTHER', 'DAUGHTER'],
    ['BROTHER', 'SISTER'],
    ['BROTHER', 'BROTHER'],
    ['UNCLE', 'NIECE'],
    ['AUNT', 'NIECE'],
    ['COUSIN', 'COUSIN'],
    ['GRANDFATHER', 'GRANDSON'],
    ['GRANDMOTHER', 'GRANDSON'],
    ['GRANDFATHER', 'GRANDDAUGHTER'],
    ['GRANDMOTHER', 'GRANDDAUGHTER'],
    ['FATHER IN LAW', 'SON-IN-LAW'],
    ['FATHER IN LAW', 'DAUGHTER-IN-LAW']
  ];
}
