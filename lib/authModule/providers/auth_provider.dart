// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/models/user_modal.dart';
import 'package:heda_saathi/authModule/screens/phone_number_login_screen.dart';
import 'package:heda_saathi/authModule/screens/splash_screen.dart';
import 'package:heda_saathi/main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

import '../../api.dart';
import '../models/family_model.dart';

class AuthProvider with ChangeNotifier {
  final LocalStorage storage = LocalStorage('HedaSaathi');

  late User loadedUser;

  //loginUserAPI
  loginUser({String phone = '', String accessToken = ''}) async {
    print("${webApi['domain']}");
    var url = '${webApi['domain']}/users/loginUser';
    var str = json.encode({
      'phone': phone,
    });

    try {
      final respone = await http.post(Uri.parse(url),
          body: str, headers: {"Content-Type": "application/json"});
      var responeData = jsonDecode(respone.body);
       
      // dob.replaceAll(RegExp('r/'), '-');
      print(responeData);
      loadedUser = User(
        address: responeData['user']['address'],
        city: responeData['user']['city'],
        pincode: responeData['user']['pincode'],
        profession: responeData['user']['profession'] ?? '',
        name: responeData['user']['name'],
        dob: DateTime.parse(responeData['user']['dob']),
        id: responeData['user']['_id'],
        gender: responeData['user']['gender'],
        avatar: responeData['user']['avatar'],
        married: responeData['user']['married'] == 'Married' ? true : false,
        phone: responeData['user']['phone'],
        familyId: responeData['user']['familyId'] ?? '',
        email: responeData['user']['email'],
        state: responeData['user']['state'],
      );

      print(loadedUser);

      // ! having a refreshedAccessToken when logging in each session;
      await storage.ready;

      storage.setItem(
          'accessToken',
          json.encode({
            "token": responeData['accessToken'],
            "phone": responeData['user']['phone'],
          }));

      return loadedUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  logout(context) async {
    await storage.ready;
    storage.deleteItem('accessToken');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: ((context) => const PhoneNumberLoginScreen())),
    );
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  List<User> users = [
    User(
        address: 'Bhusawal',
        city: 'Bhusawal',
        dob: DateTime.now(),
        email: 'kapgatepranav@gmail.com',
        familyId: '1',
        id: '1',
        anniv: DateTime.now(),
        phone: '9422762455',
        pincode: '425201',
        profession: 'Trader',
        name: 'Yash Heda',
        state: 'Maharashtra',
        married: false,
        avatar:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC8KYj8Qss8L7Lx9LxadvSu9nNfHdfqLsuJQ&usqp=CAU',
        gender: 'Male'),
    User(
        address: 'Bhusawal',
        city: 'Bhusawal',
        dob: DateTime.now(),
        email: 'kapgatepranav@gmail.com',
        familyId: '1',
        id: '2',
        anniv: DateTime.now(),
        phone: '9422762455',
        pincode: '425201',
        profession: 'Trader',
        name: 'Raju Heda',
        state: 'Maharashtra',
        married: true,
        avatar:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQI5x6k5q5YKfpLFGxrcRui0giJxnDfMByNNA&usqp=CAU',
        gender: 'Male'),
    User(
        address: 'Bhusawal',
        city: 'Bhusawal',
        dob: DateTime.now(),
        email: 'kapgatepranav@gmail.com',
        familyId: '1',
        id: '3',
        anniv: DateTime.now(),
        phone: '9422762455',
        pincode: '425201',
        profession: 'Trader',
        name: 'Mata Heda',
        state: 'Maharashtra',
        married: true,
        avatar:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQI5x6k5q5YKfpLFGxrcRui0giJxnDfMByNNA&usqp=CAU',
        gender: 'Female'),
    User(
        address: 'Bhusawal',
        city: 'Bhusawal',
        dob: DateTime.now(),
        email: 'kapgatepranav@gmail.com',
        familyId: '1',
        id: '4',
        anniv: DateTime.now(),
        phone: '9422762455',
        pincode: '425201',
        profession: 'Trader',
        name: 'Smita Heda',
        state: 'Maharashtra',
        married: false,
        avatar:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQI5x6k5q5YKfpLFGxrcRui0giJxnDfMByNNA&usqp=CAU',
        gender: 'Female')
  ];

  /*IMP!*/
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

  static const List<String> _advertisments = [
    'https://di-uploads-pod7.dealerinspire.com/mercedesbenzofmyrtlebeach/uploads/2022/03/Banner-1800x760.jpg',
    'https://img.freepik.com/premium-psd/digital-marketing-web-banner-design-template_268949-90.jpg?w=2000',
    'https://img.freepik.com/free-psd/digital-marketing-live-webinar-corporate-facebook-cover-template_120329-3023.jpg?w=2000',
    'https://www.audi.com/content/dam/ci/Guides/Communication_Media/Online_Banner/02_Anwendungsbeispiele/audi-ci-communication-media-online-banners-example1.png?imwidth=2400',
    'https://img.freepik.com/premium-vector/solar-energy-online-banner-template-set-renewable-energy-production-advertisement-horizontal-ad_607579-243.jpg?w=2000'
  ];

  get advertisments => _advertisments;

  toggleProfileEdit() {
    loadedUser.editRequest = true;
    notifyListeners();
  }

  // checkNumber(String pN) {
  //   if (pN == loadedUser.phone) {
  //     return true;
  //   }
  //   return false;
  //   // print(pN);
  // }

  // loadFamily(Family family, String userId) {
  //   final membersCount = family.memberIds.length;

  //     final userIndex =
  //       family.memberIds.indexWhere((element) => element == userId);

  //   for (int i = 0; i < membersCount; i++) {
  //     if (i == userIndex) {
  //       continue;
  //     }

  //     final memberId = family.memberIds[i];
  //     var metaDataId = family.metaData[userIndex][i];
  //     var flag = 1;
  //     if (metaDataId < 0) {
  //       metaDataId = metaDataId * (-1);
  //       flag = 0;
  //     }
  //   }
  // }
  //   familyMembers.add(Member(
  //       memberId,
  //       users.firstWhere((user) => user.id == memberId).name,
  //       _relations[metaDataId][flag],
  //       users.firstWhere((user) => user.id == memberId).avatar));
  // }
  // notifyListeners();
}

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  // ?
  // loadSearchResult(
  //   String? name,
  //   String gender,
  //   String? place,
  //   String? proffession,
  //   String? mobileNo,
  //   DateTime? birth,
  // ) {
  //   List<User> sameGenderUsers = [];

  //   List<Map<String, List<User>?>> filteredUsers = [
  //     {'sameGender': sameGenderUsers}
  //   ];

  //   sameGenderUsers.addAll(users.where(
  //       (element) => element.gender.toLowerCase() == gender.toLowerCase()));

  //   if (name != null) {
  //     filteredUsers.add({
  //       'By Name': sameGenderUsers.where((user) =>
  //               user.profileName.toLowerCase().contains(name.toLowerCase()))
  //           as List<User>
  //     });
  //   }
  //   if (mobileNo != null) {
  //     filteredUsers.add({
  //       'By Mobile No': sameGenderUsers.where((user) => user.phone == mobileNo)
  //           as List<User>
  //     });
  //   }
  //   if (place != null) {
  //     filteredUsers.add({
  //       'By Profession': sameGenderUsers.where(
  //               (user) => user.city.toLowerCase().contains(place.toLowerCase()))
  //           as List<User>
  //     });
  //   }

  //   if (proffession != null) {
  //     filteredUsers.add({
  //       'By Profession': sameGenderUsers.where((user) => user.profession
  //           .toLowerCase()
  //           .contains(proffession.toLowerCase())) as List<User>
  //     });
  //   }
  //   if (birth != null) {
  //     filteredUsers.add({
  //       'By Date Of Birth':
  //           sameGenderUsers.where((user) => user.dob == birth) as List<User>
  //     });
  //   }

  //   return filteredUsers;
  // }
