import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authModule/providers/advertisment_provider.dart';
import 'authModule/providers/family_provider.dart';
import 'authModule/screens/confirm_otp_screen.dart';
import 'authModule/screens/phone_number_login_screen.dart';
import 'featuresModule/providers/search_provider.dart';
import 'homeModule/models/saathi_model.dart';
import 'homeModule/screens/home_screen.dart';

navigator(BuildContext context, Widget route) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => route));
  });
}

loadSaathis(responseData, members, fetchType) {
  for (int i = 0; i < responseData[fetchType].length; i++) {
    var rs = responseData[fetchType][i];
    members.add(Saathi(
        userId: rs['userId'],
        dob: DateTime.parse(rs['dob']),
        email: rs['email'],
        profession: rs['profession'] ?? 'DOCTORRR',
        city: rs['city'] ?? 'DOCTORRR',
        pincode: rs['pincode'] ?? 'DOCTORRR',
        state: rs['state'] ?? 'DOCTORRR',
        phone: rs['phone'] ?? 'DOCTORRR',
        gender: rs['gender'] ?? 'DOCTORRR',
        avatar: rs['avatar'] ?? '',
        name: rs['name'] ?? 'DOCTORRR'));
  }
}

elevatedButton({
  double? fontSize = 19,
  required double width,
  required double height,
  VoidCallback? buttonFunction,
  required String label,
  Color? textColor,
  Color? buttonColor,
}) {
  return ElevatedButton(
    style: ButtonStyle(
        textStyle: MaterialStatePropertyAll<TextStyle>(TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
        )),
        minimumSize: MaterialStatePropertyAll<Size>(Size(width, height)),
        maximumSize:
            MaterialStatePropertyAll<Size>(Size(width * 2, height * 2)),
        backgroundColor:
            MaterialStatePropertyAll<Color>(buttonColor ?? Colors.amber),
        foregroundColor:
            MaterialStateProperty.all<Color>(textColor ?? Colors.white)),
    onPressed: buttonFunction ?? () {},
    child: Text(label),
  );
}

showDialogBox({
  required BuildContext context,
  required String dialogmessage,
  required String buttonOne,
  required VoidCallback buttonOneFunction,
  String? buttonTwo,
  VoidCallback? buttonTwoFunction,
  required double dW,
  required double tS,
}) {
  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        backgroundColor: Colors.black,
        child: Container(
            height: dW * 0.7,
            width: dW * 0.85,
            padding: const EdgeInsets.only(left: 20, right: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: dW * 0.05,
                ),
                Text(
                  'ALERT',
                  style: TextStyle(
                      fontSize: tS * 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                SizedBox(
                  height: dW * 0.05,
                ),
                Text(
                  dialogmessage,
                  style: TextStyle(fontSize: 20 * tS),
                ),
                const Spacer(),
                const Spacer(),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: buttonTwo == null
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      elevatedButton(
                          buttonFunction: buttonOneFunction,
                          width: dW * 0.3,
                          label: buttonOne,
                          height: dW * 0.1),
                      if (buttonTwo != null) const Spacer(),
                      if (buttonTwo != null)
                        (elevatedButton(
                            buttonColor: Colors.black12,
                            buttonFunction: buttonTwoFunction ?? () {},
                            width: dW * 0.3,
                            height: dW * 0.1,
                            label: buttonTwo))
                    ],
                  ),
                ),
                const Spacer(),
              ],
            )),
      );
    },
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
  );
}

pushOtpScreen(BuildContext context, phone) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => OtpScreen(
                number: phone,
              )));
}

pushPhoneNumberScreen(
  context,
) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: ((context) => const PhoneNumberLoginScreen())));
}

pushHomeScreen(context) {
  Navigator.of(context).pushReplacement<void, void>(MaterialPageRoute<void>(
    builder: (BuildContext context) => const HomeScreenWidget(),
  ));
}

loadFamily(familyId, id, context) async {
  await Provider.of<FamiliesProvider>(context, listen: false)
      .loadFamilyandRelations(familyId, id);
}

loadEvents(context) async {
  await Provider.of<SearchProvider>(context, listen: false)
      .fetchBirthdaysAndAnniversary();
}

loadAdvertisments(context) async {
  await Provider.of<AdvertismentProvider>(context, listen: false)
      .fetchAdvertisment();
}

String fileName(File file) {
  return file.path.split("/").last;
}

String fileType(File file) {
  return file.path.split(".").last;
}
