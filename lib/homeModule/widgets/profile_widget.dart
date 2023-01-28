import 'dart:math';

import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    Key? key,
    required this.dW,
    required this.profilePic,
    required this.name,
    required this.tS,
    required this.city,
    required this.mobileNo,
    required this.gender,
  }) : super(key: key);

  final double dW;
  final String profilePic;
  final String name;
  final double tS;
  final String city;
  final String mobileNo;
  final String gender;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.teal.shade50,
      color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.4),
      margin: EdgeInsets.only(top: widget.dW * 0.01),
      padding: EdgeInsets.symmetric(horizontal: widget.dW * 0.05, vertical: widget.dW * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: widget.dW * 0.27,
            width: widget.dW * 0.27,
            child: FadeInImage(
              width: widget.dW * 0.2,
              image: NetworkImage(widget.profilePic),
              placeholder: AssetImage(widget.gender == 'Male'
                  ? 'assets/images/menProfile.jpg'
                  : 'assets/images/womenProfile.png'),
              imageErrorBuilder: (context, error, stackTrace) {
                return Container(
                   color: Colors.white,
                  padding : widget.gender == 'Male'? const EdgeInsets.all(0) : EdgeInsets.symmetric(horizontal:widget.dW * 0.0265,),
                  width: widget.dW * 0.27,
                  height: widget.dW * 0.27,
                  child: Image.asset(
                    
                    widget.gender == 'Male'
                        ? 'assets/images/menProfile.jpg'
                        : 'assets/images/womenProfile.png',
                  ),
                );
              },
              fit: BoxFit.fitWidth,
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
                  widget.name,
                  style:
                      TextStyle(fontSize: 24 * widget.tS, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  widget.city,
                  style:
                      TextStyle(fontSize: 16 * widget.tS, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Text(
                  widget.mobileNo,
                  style:
                      TextStyle(fontSize: 16 * widget.tS, fontWeight: FontWeight.w500),
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