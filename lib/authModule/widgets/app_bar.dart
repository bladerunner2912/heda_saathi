import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(double dW) {
  return AppBar(
    toolbarHeight: dW * 0.23,
    elevation: 0,
    backgroundColor: Colors.white,

    // leading: Padding(
    //   padding: const EdgeInsets.only(left: 4.0),
    //   child: Image.asset('assets/images/index.jpg'),
    // ),
    leadingWidth: 0,
    title: SizedBox(
      width: dW,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'assets/images/index.jpg',
            width: dW * 0.2,
          ),
          const Text(
            'Akhil Bhartiya Heda\nMaheshwari Sangathan',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ],
      ),
    ),
  );
}
