import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:heda_saathi/authModule/widgets/app_bar.dart';
import 'package:heda_saathi/authModule/widgets/custom_button.dart';
import 'package:heda_saathi/homeModule/screens/home_screen.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/family_provider.dart';

class OtpScreen extends StatefulWidget {
  final String number;
  OtpScreen({
    required this.number,
    super.key,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late String otp;
  TextEditingController phoneNumberController = TextEditingController();
  OtpTimerButtonController controller = OtpTimerButtonController();
  bool errorFlag = false;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    phoneNumberController.text = widget.number;
    super.initState();
  }

  loadFamily(familyId, id) async {
    await Provider.of<FamiliesProvider>(context, listen: false)
        .loadFamilyandRelations(familyId, id);
  }

  loadUserAndFamily() async {
    final user = await Provider.of<AuthProvider>(context, listen: false)
        .loginUser(phone: phoneNumberController.text);
    loadFamily(user.familyId, user.id);
  }

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final dH = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: customAppBar(dW),
      body: SizedBox(
        width: dW,
        height: dH,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text(
              'Login',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 26 * tS),
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
                            fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    height: dW * 0.12,
                    decoration: BoxDecoration(border: Border.all(width: 0.8)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      width: dW * 0.8,
                      child: TextField(
                        enabled: false,
                        onEditingComplete: () => {},
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            fontSize: 16 * tS, fontWeight: FontWeight.w500),
                        controller: phoneNumberController,
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          fillColor: Colors.black,
                          counterStyle: TextStyle(color: Colors.black),
                          // focusedBorder: InputBorder(borderSide: BorderSide(bottom : )),
                          focusColor: Colors.black,
                          hoverColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: dW * 0.05,
            ),
            SizedBox(
              width: dW * 0.6,
              child: OtpTimerButton(
                height: dW * 0.12,
                backgroundColor: Colors.redAccent,
                radius: 22,
                controller: controller,
                onPressed: () async {
                  controller.startTimer();
                  await auth.sendOtp(phoneNumber: widget.number);
                },
                text: const Text(
                  'RESEND OTP',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                duration: 60,
              ),
            ),
            SizedBox(
              height: dW * 0.1,
            ),
            Text(
              'ENTER OTP',
              style: TextStyle(fontSize: 19 * tS),
            ),
            SizedBox(
              height: dW * 0.025,
            ),
            OtpTextField(
              onSubmit: ((value) {
                otp = value;
                setState(() => {});
              }),
              enabledBorderColor: Colors.black,
              textStyle:
                  TextStyle(fontSize: 20 * tS, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: dW * 0.02,
            ),
            Visibility(
                visible: errorFlag,
                child: const Text('Invalid OTP!.Please try with proper otp',
                    style: TextStyle(color: Colors.red))),
            SizedBox(
              height: dW * 0.1,
            ),
            CustomAuthButton(
                onTap: () async {
                  if (auth.otp == otp) {
                    await loadUserAndFamily();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => HomeScreenWidget()));
                    return;
                  }
                  errorFlag = true;
                  setState(
                    () => {},
                  );
                },
                buttonLabel: 'SUBMIT'),
          ]),
        ),
      ),
    );
  }
}
