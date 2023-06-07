import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common_functions.dart';
import '../../homeModule/screens/home_screen.dart';
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
  bool isLoading = false;

  @override
  void initState() {
    myInit();
    super.initState();
  }

  myInit() async {
    await storage.ready;
    setState(() {
      isLoading = true;
    });
    if (mounted) {
      loadAdvertisments(context);
      final accessTokenString = storage.getItem('accessToken');
      if (accessTokenString == null) {
        setState(() {
          isLoading = false;
        });
        pushPhoneNumberScreen(context);
        return;
      }
      var accessToken = json.decode(accessTokenString);
      if (accessToken != null) {
        setState(() {
          isLoading = false;
        });
        pushPhoneNumberScreen(context);
        return;
      }
      setState(() {
        isLoading = false;
      });
      if (accessToken['phone'] != '' && accessToken['phone'] != null) {
        Provider.of<AuthProvider>(context, listen: false).phone =
            accessToken['phone'];
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const HomeScreenWidget()));
        return;
      }
      pushPhoneNumberScreen(context);
      return;
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
            const Spacer(),
            const Spacer(),
            Image.asset(
              'assets/images/index.jpg',
              scale: dW * 0.005,
            ),
            const SizedBox(
              height: 16,
            ),
            isLoading
                ? const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  )
                : const SizedBox(
                    height: 14,
                    width: 14,
                  ),
            const Spacer(),
            SizedBox(
              height: dW * .2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    'Powered By : ',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                      height: dW * 0.1,
                      width: dW * 0.5,
                      color: Colors.transparent,
                      child: Image.asset(
                        'assets/images/index2.jpeg',
                        fit: BoxFit.cover,
                      )),
                  const Text(
                    'Made with ❤️ in India',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: dW * 0.06,
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
