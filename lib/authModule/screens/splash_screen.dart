// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/providers/family_provider.dart';
import 'package:heda_saathi/authModule/screens/phone_number_login_screen.dart';
import 'package:heda_saathi/homeModule/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  pushPhoneNumberScreen() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: ((context) => PhoneNumberLoginScreen())));
  }

  pushHomeScreen() {
    Navigator.of(context).pushReplacement<void, void>(MaterialPageRoute<void>(
      builder: (BuildContext context) => HomeScreenWidget(),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    myInit();
    super.initState();
  }

  myInit() async {
    await Future.delayed(const Duration(seconds: 2));
    await storage.ready;
    final accessTokenString = storage.getItem('accessToken');

    if (accessTokenString == null) {
      pushPhoneNumberScreen();
      return;
    }

    var accessToken = json.decode(accessTokenString);

    if (accessToken == null) {
      pushPhoneNumberScreen();
      return;
    }

    final user = await Provider.of<AuthProvider>(context, listen: false)
        .loginUser(phone: accessToken['phone']);

    if (user!=null) {
      // ignore: use_build_context_synchronously
      Provider.of<FamiliesProvider>(context, listen: false).loadFamilyandRelations(user.familyId, user.id);
      pushHomeScreen();
      return;
    } else {
      pushPhoneNumberScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Spacer(),
            GestureDetector(
              onTap: (() {
                pushPhoneNumberScreen();
              }),
              child: Image.asset(
                'assets/images/index.jpg',
                scale: dW * 0.005,
              ),
            ),
            Spacer(),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    'Powered By : ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                      height: dW * 0.1035,
                      width: dW * 0.4,
                      color: Colors.black,
                      child: Image.asset(
                        'assets/images/index2.jpeg',
                        fit: BoxFit.contain,
                      )),
                  Text(
                    'Made with ❤️ in India',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: dW * 0.04,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
