import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    Key? key,
    required this.dW,
    required this.tS,
  }) : super(key: key);

  final double dW;
  final double tS;
  

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context).loadedUser;
    return Container(
      // color: Colors.teal.shade50,
      color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.4),
      margin: EdgeInsets.only(top: widget.dW * 0.01),
      padding: EdgeInsets.symmetric(
          horizontal: widget.dW * 0.05, vertical: widget.dW * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            height: widget.dW * 0.27,
            width: widget.dW * 0.27,
            child: FadeInImage(
              height: widget.dW * 0.27,
              width: widget.dW * 0.27,
              image: Image.network(
                user.avatar,
                fit: BoxFit.contain,
              ).image,
              placeholder: AssetImage(user.gender == 'Male'
                  ? 'assets/images/indian_men.png'
                  : 'assets/images/indian_women.png'),
              imageErrorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.white,
                  padding: user.gender == 'Male'
                      ? const EdgeInsets.all(0)
                      : EdgeInsets.symmetric(
                          horizontal: widget.dW * 0.0265,
                        ),
                  width: widget.dW * 0.27,
                  height: widget.dW * 0.27,
                  child: Image.asset(
                    user.gender == 'Male'
                        ? 'assets/images/indian_men.png'
                        : 'assets/images/indian_women.png',
                  ),
                );
              },
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            width: widget.dW * 0.04,
          ),
          SizedBox(
            height: widget.dW * 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                      fontSize: 24 * widget.tS, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  user.city,
                  style: TextStyle(
                      fontSize: 16 * widget.tS, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Text(
                  user.phone,
                  style: TextStyle(
                      fontSize: 16 * widget.tS, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          const Spacer(),
          const Spacer(),
          SizedBox(
            height: widget.dW * 0.15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.red,
                  size: widget.dW * 0.1,
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
