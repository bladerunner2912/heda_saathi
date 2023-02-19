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

class AuthProvider with ChangeNotifier {
  final LocalStorage storage = LocalStorage('HedaSaathi');
  late User loadedUser;
  String otp = '';

  // ! loginUser
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
      print(e);
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
        print('here');
        print(uploadResponse.headers);

        String bucketName = 'heda-saathi-data';

        String location = "https://$bucketName.s3.amazonaws.com/$objectName";
        loadedUser.avatar = location;
        print('here');
        var url = "${webApi['domain']}/users/update/:${loadedUser.id}";
        var str = ({"avatar": location});
        var response = await http.post(
          Uri.parse(url),
          body: str,
        );
        if (response.statusCode == 200) {
          print("Check Image babes");
          notifyListeners();
        }
      } else {
        print('error');
        // Handle error
      }
    } catch (e) {
      print(e);
    }
  }

  // ! editUseer
  editUser({
    String? name,
    String? email,
    String? profession,
    String? city,
    String? state,
    DateTime? birth,
  }) async {
    var str = {
      "id": loadedUser.id,
      'name': name,
      'city': city,
      'profession': profession,
      'state': state,
      'email': email,
      'dob': DateFormat('yyyy-MM-dd').format(birth!),
    };

    // print(str);
    try {
      var url = "${webApi['domain']}/users/updateUserDetails/";
      var response = await http.post(Uri.parse(url), body: str);
      var responseData = json.decode(response.body);
      if (kDebugMode) {
        print(responseData);
      }
      if (responseData != null) {
        loadedUser = User(
          address: responseData['user']['address'],
          city: responseData['user']['city'],
          pincode: responseData['user']['pincode'],
          profession: responseData['user']['profession'] ?? '',
          name: responseData['user']['name'],
          dob: DateTime.parse(responseData['user']['dob']),
          id: responseData['user']['_id'],
          gender: responseData['user']['gender'],
          avatar: responseData['user']['avatar'],
          married: responseData['user']['married'] == 'Married' ? true : false,
          phone: responseData['user']['phone'],
          familyId: responseData['user']['familyId'] ?? '',
          email: responseData['user']['email'],
          state: responseData['user']['state'],
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
      otp = responseBody['otp'].toString();
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
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  

// ? 
 // var request = http.MultipartRequest('PUT', Uri.parse(url));
    // request.files.add(http.MultipartFile(
    //     'image', image.openRead(), image.lengthSync(),
    //     filename: objectName));
    // request.fields.addAll(str);
