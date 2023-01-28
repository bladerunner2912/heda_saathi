import 'package:flutter/material.dart';

import '../../featuresModule/screens/search_screen.dart';

class CustomHomeScreenAppBar extends StatelessWidget {
  const CustomHomeScreenAppBar({
    Key? key,
    required this.dW,
    required this.scaffoldKey,
    required this.tS,
  }) : super(key: key);

  final double dW;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final double tS;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: dW * .2,
      leadingWidth: 0,
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: false,
      title: Container(
        height: dW * 0.15,
        width: dW * 0.99,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            border: Border.all(color: Colors.black)),
        child: Row(
          children: [
            const Spacer(),
            GestureDetector(
              onTap: () {
                scaffoldKey.currentState!.openDrawer();
              },
              child: Icon(
                size: dW * 0.07,
                Icons.menu,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Text(
              'HEDA SANGATHAN',
              style: TextStyle(
                color: Colors.red,
                fontSize: 24 * tS,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchScreen())),
              child: Icon(
                size: dW * 0.07,
                Icons.search,
                color: Colors.black,
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
