import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/models/user_modal.dart';
import 'package:heda_saathi/authModule/screens/phone_number_login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import '../../api.dart';
import '../../featuresModule/models/notification.dart';

class AuthProvider with ChangeNotifier {
  final LocalStorage storage = LocalStorage('HedaSaathi');
  late User loadedUser;
  List<String> unviewedNotifications = [];
  String _otp = '';
  final List<Notifications> _notifications = [];
  List<Notifications> get notifications => _notifications;

  String get otp => _otp;

  User dummyUser = User(
      address: 'Bhusawal',
      city: 'Bhusawal',
      dob: DateTime(1999, 12, 29),
      email: 'userrole@gmail.com',
      familyId: '44',
      gender: 'Male',
      id: '123451231321',
      married: false,
      name: 'Test User',
      phone: '1234567890',
      pincode: '425201',
      profession: 'Tester',
      state: 'Maharashtra',
      avatar:
          'https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwiV0Jqwz_b9AhXGwTgGHf7KDh8Q1bUFegQIERAA&url=https%3A%2F%2Fpixabay.com%2Fimages%2Fsearch%2Flink%2F&usg=AOvVaw2Zh_B9UZS2TxR_qOtlnqzF');

  fetchNotifications() async {
    var url = "${webApi["domain"]}/notifications/fetchNotifications";
    try {
      var response = await http.get(Uri.parse(url));
      var responseBody = json.decode(response.body);
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
      return;
    }
  }

  viewedANotification(String id, String nid) async {
    // ? query to remove that notificationId from unviewedNotifications ,user will have a field unviewedNotification  which will be list of ids of unviewed notification.
    var url = "${webApi["domain"]}/notifications/viewedANotification";
    var str = {
      "uid": id,
      "nid": nid,
    };
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
      return;
    }
  }

  // ! loginUser
  loginUser({String phone = '', String accessToken = ''}) async {
    var url = '${webApi['domain']}/users/loginUser';
    var str = json.encode({
      'phone': phone,
    });

    try {
      final respone = await http.post(Uri.parse(url),
          body: str, headers: {"Content-Type": "application/json"});
      var responeData = jsonDecode(respone.body);

      // dob.replaceAll(RegExp('r/'), '-');
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
      for (int i = 0;
          i < responeData['user']['unviewedNotifications'].length;
          i++) {
        unviewedNotifications
            .add(responeData['user']["unviewedNotifications"][i].toString());
      }

      // ? having a refreshedAccessToken when logging in each session;
      await storage.ready;

      storage.setItem(
          'accessToken',
          json.encode({
            "token": responeData['accessToken'],
            "phone": responeData['user']['phone'],
          }));

      return loadedUser;
    } catch (e) {
      return null;
    }
  }

  // ! uploadImageToS3
  uploadToS3Bucket(
      {required File image,
      required String objectName,
      required String objectType}) async {
    var url = '${webApi['domain']}/uploadPicUrl';
    var str = json.encode({
      "userId": loadedUser.id,
      "objectName": objectName,
      "objectType": objectType
    });
    var headers = {
      'Content-Type': 'application/json',
    };
    try {
      var response =
          await http.post(Uri.parse(url), headers: headers, body: str);
      final responseData = json.decode(response.body);
      var uploadResponse = await http.put(Uri.parse(responseData['uploadUrl']),
          body: image.readAsBytesSync());

      if (uploadResponse.statusCode == 200) {
        String bucketName = 'heda-saathi-data';

        String location = "https://$bucketName.s3.amazonaws.com/$objectName";
        loadedUser.avatar = location;
        var url = "${webApi['domain']}/users/update/:${loadedUser.id}";
        var str = ({"avatar": location});
        var response = await http.post(
          Uri.parse(url),
          body: str,
        );
        if (response.statusCode == 200) {
          notifyListeners();
        }
      } else {
        return; // Handle error
      }
    } catch (e) {
      return;
    }
  }

  // ! editUseer
  editUser({
    required String name,
    required String email,
    required String profession,
    required String city,
    required String state,
    required DateTime birth,
  }) async {
    var str = {
      "id": loadedUser.id,
      'name': name,
      'city': city,
      'profession': profession,
      'state': state,
      'email': email,
      'dob': DateFormat('yyyy-MM-dd').format(birth),
    };

    // print(str);
    try {
      var url = "${webApi['domain']}/users/updateUserDetails/";
      var response = await http.post(Uri.parse(url), body: str);
      var responseData = json.decode(response.body);
      if (responseData != null) {
        loadedUser = User(
          address: responseData['user']['address'],
          city: city,
          pincode: responseData['user']['pincode'],
          profession: profession,
          name: name,
          dob: birth,
          id: responseData['user']['_id'],
          gender: responseData['user']['gender'],
          avatar: responseData['user']['avatar'],
          married: responseData['user']['married'] == 'Married' ? true : false,
          phone: responseData['user']['phone'],
          familyId: responseData['user']['familyId'] ?? '',
          email: email,
          state: state,
        );
        notifyListeners();
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
        return false;
      }
    }
    return false;
  }

  // ! logout
  logout(context) async {
    await storage.ready;
    storage.deleteItem('accessToken');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: ((context) => const PhoneNumberLoginScreen())),
    );
  }

  // ! sendOtp
  sendOtp({required String phoneNumber}) async {
    var str = ({
      "phone": phoneNumber,
    });
    try {
      var response = await http
          .post(Uri.parse("${webApi['domain']}/users/sendOtp/"), body: str);
      var responseBody = json.decode(response.body);
      _otp = responseBody['otp'].toString();
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  // ! checkUserExists
  checkUserExists({required String phone}) async {
    var url = "${webApi['domain']}/users/checkUserExists";
    var str = json.encode({
      "phone": phone,
    });

    try {
      var response = await http.post(Uri.parse(url), body: str);
      return json.decode(response.body);
    } catch (e) {
      return false;
    }
  }

  // ! toggleProfileEdit
  toggleProfileEdit() {
    loadedUser.editRequest = true;
    notifyListeners();
  }

  int unviewedNotificationsCount() {
    notifyListeners();
    return unviewedNotifications.length;
  }

  ///
}


////////////////////////////////////////////////////////////   //////////////////////////////////////////////////

  

// ? 
 // var request = http.MultipartRequest('PUT', Uri.parse(url));
    // request.files.add(http.MultipartFile(
    //     'image', image.openRead(), image.lengthSync(),
    //     filename: objectName));
    // request.fields.addAll(str);
