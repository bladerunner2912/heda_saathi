import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heda_saathi/authModule/providers/auth_provider.dart';
import 'package:heda_saathi/authModule/widgets/app_bar.dart';
import 'package:heda_saathi/authModule/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import '../../common_functions.dart';

// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:heda_saathi/authModule/widgets/app_bar.dart';

class PhoneNumberLoginScreen extends StatefulWidget {
  const PhoneNumberLoginScreen({super.key});

  @override
  State<PhoneNumberLoginScreen> createState() => _PhoneNumberLoginScreenState();
}

class _PhoneNumberLoginScreenState extends State<PhoneNumberLoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  bool errorFlag = false;
  late AuthProvider auth;
  bool isLoading = false;

  toggleErrorFlag() {
    setState(() {
      if (phoneNumberController.text.length == 10) {
        errorFlag = false;
      } else {
        errorFlag = true;
      }
    });
  }

  sendOtp() async {
    if (!errorFlag && phoneNumberController.text.length == 10) {
      setState(() {
        isLoading = true;
      });

      final user = await Provider.of<AuthProvider>(context, listen: false)
          .checkUserExists(phone: phoneNumberController.text);

      if (mounted) {
        if (user) {
          loadEvents(context);
          await auth.sendOtp(phoneNumber: phoneNumberController.text);
          isLoading = false;
          auth.phone = phoneNumberController.text;
          setState(() {});
          if (mounted) pushOtpScreen(context, phoneNumberController.text);
        }
        //tester Scenario
        else if (phoneNumberController.text == '1234567890') {
          loadEvents(context);
          isLoading = false;
          setState(() {});
          pushOtpScreen(context, phoneNumberController.text);
        }
        //error scenario
        else {
          errorFlag = !errorFlag;
          isLoading = false;
          setState(() {});
        }
      }
    }
  }

  @override
  void initState() {
    auth = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final dH = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: customAppBar(dW),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              height: dH,
              width: dW,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  Text(
                    'Login',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 26 * tS),
                  ),
                  SizedBox(
                    height: dW * 0.04,
                  ),
                  Container(
                    width: dW,
                    decoration: BoxDecoration(border: Border.all(width: 1)),
                    child: Row(
                      children: [
                        const SizedBox(
                          // color: Colors.black,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, bottom: 8.0, left: 8.0, right: 6),
                            child: Text(
                              '+91',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          height: dW * 0.12,
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.8)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            width: dW * 0.8,
                            child: TextField(
                              onChanged: (_) => toggleErrorFlag(),
                              onSubmitted: (value) async {
                                FocusScope.of(context).unfocus();
                              },
                              inputFormatters: [
                                //input type
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'),
                                ),
                              ],
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                  fontSize: 16 * tS,
                                  fontWeight: FontWeight.w500),
                              controller: phoneNumberController,
                              decoration: const InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  fillColor: Colors.black,
                                  counterStyle: TextStyle(color: Colors.black),
                                  // focusedBorder: InputBorder(borderSide: BorderSide(bottom : )),
                                  focusColor: Colors.black,
                                  hoverColor: Colors.black,
                                  hintText:
                                      'Enter your registered mobile number.'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: errorFlag,
                      child: Container(
                        padding: EdgeInsets.only(top: dW * 0.01),
                        width: dW,
                        child: Text(
                          phoneNumberController.text.length == 10
                              ? 'User is not registered with Heda Saathi. Contact Admin!'
                              : 'Invalid Phone Number',
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )),
                  SizedBox(
                    height: errorFlag ? dW * 0.02 : dW * 0.07,
                  ),
                  // Visibility(
                  //   visible: errorFlag,
                  //   child: SizedBox(
                  //     height: dW * 0.045,
                  //   ),
                  // ),
                  // Visibility(
                  //     visible: !errorFlag,
                  //     child: Container(
                  //       margin: EdgeInsets.only(top: dW * 0.015, bottom: dW * 0.0065),
                  //       alignment: Alignment.topLeft,
                  //       // height: dW * 0.03,
                  //       child: const Text(
                  //         'Invalid Phone Number',
                  //         style: TextStyle(color: Colors.red),
                  //         textAlign: TextAlign.left,
                  //       ),
                  //     )),
                  CustomAuthButton(
                    onTap: sendOtp,
                    buttonLabel: 'SEND OTP',
                  ),
                  SizedBox(
                    height: dW * 0.15,
                  ),
                  Container(
                    height: dW * 0.6,
                    width: dW,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 2.0,
                        left: 4,
                        bottom: 6,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 18 * tS,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const Spacer(),
                            Text(
                                '1. To register your family with ABHMS please\nfill up the registeration form from the below link\nhttps://www.abhms.org/directory_registeration',
                                style: TextStyle(
                                    fontSize: 16 * tS,
                                    fontWeight: FontWeight.w500)),
                            const Spacer(),
                            Text(
                                '2. You will receive a message after successful\nregisteration within 3-4 days after data checking',
                                style: TextStyle(
                                    fontSize: 16 * tS,
                                    fontWeight: FontWeight.w500)),
                            const Spacer(),
                            Text(
                                '3. You can then login with your registered\nmobile no. after confirmation message',
                                style: TextStyle(
                                    fontSize: 16 * tS,
                                    fontWeight: FontWeight.w500)),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: dW * 0.2,
                  ),
                  Text(
                      'Contact Us\n------------------\nmail us at\nhelp@abhms.org\n\nXXXX Heda\n+91 92844xxxxx',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16 * tS, fontWeight: FontWeight.w500))
                ]),
              ),
            ),
    );
  }
}
