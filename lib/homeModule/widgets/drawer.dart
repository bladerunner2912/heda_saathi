// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:heda_saathi/authModule/providers/auth_provider.dart';
import 'package:heda_saathi/authModule/providers/family_provider.dart';
import 'package:heda_saathi/authModule/screens/phone_number_login_screen.dart';
import 'package:heda_saathi/common_functions.dart';
import 'package:heda_saathi/featuresModule/screens/anniversary_screen.dart';
import 'package:heda_saathi/featuresModule/screens/birthday_screen.dart';
import 'package:heda_saathi/featuresModule/screens/help_screen.dart';
import 'package:heda_saathi/featuresModule/screens/profile_screen.dart';
import 'package:heda_saathi/featuresModule/screens/search_screen.dart';
import 'package:heda_saathi/homeModule/screens/home_screen.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final double dW;
  final double tS;
  const CustomDrawer({super.key, required this.dW, required this.tS});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Drawer(
      width: dW * 0.7,
      child: SizedBox(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: dW * 0.04, top: dW * 0.1),
            margin: EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: dW * 0.1,
                  child: Image.asset('assets/images/index.jpg'),
                ),
                SizedBox(
                  width: dW * 0.04,
                ),
                SizedBox(
                  height: dW * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        auth.loadedUser.name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 22 * tS,
                            fontWeight: FontWeight.w800,
                            color: Colors.redAccent),
                      ),
                      const Spacer(),
                      Text(
                        auth.loadedUser.city.toUpperCase(),
                        style: TextStyle(fontSize: 16 * tS),
                      ),
                      const Spacer(),
                      Text(
                        auth.loadedUser.profession,
                        style: TextStyle(fontSize: 16 * tS),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.5,
          ),
          Container(
            width: dW,
            padding: EdgeInsets.only(left: dW * 0.04, top: dW * 0.02),
            // EdgeInsets.only(left: widget.dW * 0.04, top: widget.dW * 0.08),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              drawerTile('PROFILE', ProfileScreen(), context),
              drawerTile('ABHMS SEARCH', SearchScreen(), context),
              drawerTile('ABHMS HELP', HelpScreen(), context),
              drawerTile('BIRTHDAY & ANNIVERSARY', BirthdayScreen(), context),
            ]),
          ),
          const Spacer(),
          Container(
            width: dW,
            padding: EdgeInsets.only(left: dW * 0.04, top: dW * 0.04),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              drawerTile('ABHMS INFORMATION', '', context),
              drawerTile('OUR WEBSITE', '', context),
              drawerTile('ABHMS NOTIFICATIONS', HomeScreenWidget(), context)
            ]),
          ),
          const Spacer(),
          Container(
            width: dW,
            padding: EdgeInsets.only(left: dW * 0.04, top: dW * 0.04),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              drawerTile('MAHASABHA SCHEMES', '', context),
              drawerTile('SAATHI REGISTERATION', '', context),
              drawerTile('CONTACT US', 'onPressed', context)
            ]),
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.24,
          ),
          GestureDetector(
            onTap: () {
              auth.logout(context);
            },
            child: Padding(
                padding: EdgeInsets.only(
                    left: dW * 0.04, top: dW * 0.015, bottom: dW * 0.04),
                child: drawerTile(
                    'LOGOUT >>>', PhoneNumberLoginScreen(), context,
                    isLogout: true)),
          )
        ],
      )),
    );
  }
}

drawerTile(name, onPressed, context, {bool isLogout = false}) =>
    GestureDetector(
      // style: ButtonStyle(
      //     backgroundColor: MaterialStateProperty.resolveWith((states) {
      //   if (states.contains(MaterialState.pressed)) {
      //     return isLogout ? Colors.green : Colors.red;
      //   }
      //   return isLogout ? Colors.redAccent : Color.fromARGB(255, 111, 108, 108);
      // })),
      onTap: () => navigator(context, onPressed),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 12,
          top: 12,
        ),
        child: Container(
          width: 240,
          child: Text(
            name,
            style: TextStyle(fontSize: isLogout ? 22 : 18),
          ),
        ),
      ),
    );
