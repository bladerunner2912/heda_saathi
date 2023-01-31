import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'homeModule/models/saathi_model.dart';

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
        place: rs['place'] ?? 'DOCTORRR',
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
        fixedSize: MaterialStatePropertyAll<Size>(Size(width, height)),
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
    // transitionDuration: const Duration(milliseconds: 300),
    // transitionBuilder: (_, anim, __, child) {
    //   Tween<Offset> tween;
    //   if (anim.status == AnimationStatus.reverse) {
    //     tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
    //   } else {
    //     tween = Tween(begin: Offset(1, 0), end: Offset.zero);
    //   }

    //   return SlideTransition(
    //     position: tween.animate(anim),
    //     child: FadeTransition(
    //       opacity: anim,
    //       child: child,
    //     ),
    //   );
    // },
  );
}
