import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

class CustomAuthButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonLabel;
  const CustomAuthButton(
      {super.key, required this.onTap, required this.buttonLabel});

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: dW * 0.025),
        width: dW * 0.55,
        decoration: BoxDecoration(
          color: buttonLabel == 'OTP SENT' ? Colors.grey : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Center(
            child: Text(
          buttonLabel,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        )),
      ),
    );
  }
}
