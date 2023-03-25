// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/providers/auth_provider.dart';
import 'package:heda_saathi/common_functions.dart';
import 'package:heda_saathi/featuresModule/screens/birthday_screen.dart';
import 'package:heda_saathi/featuresModule/screens/help_screen.dart';
import 'package:heda_saathi/featuresModule/screens/profile_screen.dart';
import 'package:heda_saathi/featuresModule/screens/search_function_screen.dart';
import 'package:heda_saathi/homeModule/screens/add_saathi_screen.dart';
import 'package:heda_saathi/homeModule/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  final double dW;
  final double tS;
  const CustomDrawer({super.key, required this.dW, required this.tS});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final auth = Provider.of<AuthProvider>(context);
    drawerTile(name, onPressed, context,
            {bool isLogout = false, bool isWebPage = false}) =>
        GestureDetector(
          // style: ButtonStyle(
          //     backgroundColor: MaterialStateProperty.resolveWith((states) {
          //   if (states.contains(MaterialState.pressed)) {
          //     return isLogout ? Colors.green : Colors.red;
          //   }
          //   return isLogout ? Colors.redAccent : Color.fromARGB(255, 111, 108, 108);
          // })),
          onTap: isWebPage
              ? () async {
                  String url = onPressed;
                  var urllaunchable = await canLaunchUrl(
                      Uri.parse(url)); //canLaunch is from url_launcher package
                  if (urllaunchable) {
                    await launchUrl(Uri.parse(
                        url)); //launch is from url_launcher package to launch URL
                  } else {
                    ScaffoldMessenger.of(scaffoldKey.currentState!.context)
                        .showSnackBar(const SnackBar(
                      content: Text(
                        "Error! Please try again later.",
                      ),
                      backgroundColor: Colors.red,
                    ));
                  }
                }
              : () => navigator(context, onPressed),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 12,
              top: 12,
            ),
            child: SizedBox(
              width: 240,
              child: Text(
                name,
                style: TextStyle(fontSize: isLogout ? 22 : 18),
              ),
            ),
          ),
        );

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
              drawerTile('ABHMS SEARCH', SearchFunctionScreen(), context),
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
              drawerTile(
                  'ABHMS INFORMATION', 'https://www.techredo.in', context,
                  isWebPage: true),
              drawerTile('OUR WEBSITE', "https://www.techredo.in", context,
                  isWebPage: true),
              drawerTile('ABHMS NOTIFICATIONS',
                  HomeScreenWidget(currentIndex: 2), context)
            ]),
          ),
          const Spacer(),
          Container(
            width: dW,
            padding: EdgeInsets.only(left: dW * 0.04, top: dW * 0.04),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              drawerTile(
                  'MAHASABHA SCHEMES', 'https://www.techredo.in', context,
                  isWebPage: true),
              drawerTile('SAATHI REGISTERATION', AddSaathiScreen(), context),
              drawerTile(
                  'CONTACT US', 'https://www.techredo.in/Contact_Us/', context,
                  isWebPage: true)
            ]),
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.24,
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: dW * 0.04, top: dW * 0.015, bottom: dW * 0.04),
              child: GestureDetector(
                // style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.resolveWith((states) {
                //   if (states.contains(MaterialState.pressed)) {
                //     return isLogout ? Colors.green : Colors.red;
                //   }
                //   return isLogout ? Colors.redAccent : Color.fromARGB(255, 111, 108, 108);
                // })),
                onTap: () {
                  auth.logout(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 12,
                    top: 12,
                  ),
                  child: SizedBox(
                    width: 240,
                    child: Text(
                      'LOGOUT',
                      style: TextStyle(fontSize: 22, color: Colors.red),
                    ),
                  ),
                ),
              ))
        ],
      )),
    );
  }
}
