import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/models/family_model.dart';
import 'package:heda_saathi/authModule/providers/advertisment_provider.dart';
import 'package:heda_saathi/authModule/providers/auth_provider.dart';
import 'package:heda_saathi/featuresModule/screens/notifications_screen.dart';
import 'package:heda_saathi/homeModule/screens/home_widget.dart';
import 'package:heda_saathi/homeModule/widgets/chat_screen_section.dart';
import 'package:heda_saathi/homeModule/widgets/drawer.dart';
import 'package:provider/provider.dart';
import '../../authModule/models/user_modal.dart';
import '../../authModule/providers/family_provider.dart';
import '../widgets/custom_home_screen_app_bar.dart';

class HomeScreenWidget extends StatefulWidget {
  int? currentIndex;
  HomeScreenWidget({super.key, this.currentIndex = 0});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  late int currentIndex;
  late AuthProvider auth;
  late User user;
  late Family family;
 

  switchBottomNavBar(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  myInit() async {
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   print(notification);
    //   print(android);
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             priority: Priority.high,
    //           ),
    //         ));
    //   }
    // });
    currentIndex = widget.currentIndex!;
    auth = Provider.of<AuthProvider>(context, listen: false);
    user = auth.loadedUser;
  }

  @override
  void initState() {
    myInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final dW = MediaQuery.of(context).size.width;
    final dH = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;
    final advertisments =
        Provider.of<AdvertismentProvider>(context).advertsiments;
    final familyMembers = Provider.of<FamiliesProvider>(context).familyMembers;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      drawer: CustomDrawer(dW: dW, tS: tS),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(dW * 0.2),
        child: CustomHomeScreenAppBar(dW: dW, scaffoldKey: scaffoldKey, tS: tS),
      ),
      body: currentIndex != 0
          ? currentIndex != 2
              ? ChatScreen(dW: dW, dH: dH, tS: tS)
              : const NotificationsScreen()
          : HomePage(
              dW: dW,
              dH: dH,
              tS: tS,
              auth: auth,
              advertisments: advertisments,
              familyMembers: familyMembers),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 3,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle:
            // ignore: prefer_const_constructors
            TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        selectedLabelStyle:
            // ignore: prefer_const_constructors
            TextStyle(color: Colors.red, fontWeight: FontWeight.w400),
        selectedIconTheme:
            IconThemeData(size: dW * 0.1, color: Colors.redAccent),
        unselectedIconTheme:
            IconThemeData(color: Colors.black, size: dW * 0.08),
        items: [
          BottomNavigationBarItem(
              activeIcon: Container(
                color: Colors.amber.shade300,
                height: dW * 0.15,
                width: dW * 0.33,
                child: const Icon(
                  Icons.home_filled,
                ),
              ),
              label: 'Home',
              icon: GestureDetector(
                onTap: () => switchBottomNavBar(0),
                child: SizedBox(
                  width: dW * 0.33,
                  child: const Icon(
                    Icons.home_outlined,
                  ),
                ),
              )),
          BottomNavigationBarItem(
            label: 'Chat',
            activeIcon: Container(
              width: dW * 0.33,
              height: dW * 0.15,
              color: Colors.amber.shade300,
              child: const Icon(
                Icons.chat_bubble,
              ),
            ),
            icon: SizedBox(
              width: dW * 0.33,
              child: GestureDetector(
                onTap: () {
                  switchBottomNavBar(1);
                },
                child: SizedBox(
                  width: dW * 0.33,
                  child: const Icon(
                    Icons.chat_bubble_outline_outlined,
                  ),
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Notifications',
            activeIcon: Container(
                color: Colors.amber.shade300,
                width: dW * 0.33,
                height: dW * 0.15,
                child: const Icon(Icons.notifications)),
            icon: GestureDetector(
              onTap: () => switchBottomNavBar(2),
              child: SizedBox(
                width: dW * 0.33,
                child: const Icon(
                  Icons.notifications_none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({
//     Key? key,
//     required this.dW,
//     required this.dH,
//     required this.user,
//     required this.tS,
//     required this.auth,
//   }) : super(key: key);

//   final double dW;
//   final double dH;
//   final User user;
//   final double tS;
//   final AuthProvider auth;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.white,
//         width: dW,
//         height: dH,
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: dW * 0.005,
//               ),
//               Center(
//                 child: Text(
//                   'SMARIKA REGISTERATION NO : 2022123${user.id.substring(1, 3).toUpperCase()}',
//                   style: TextStyle(fontSize: 14 * tS),
//                 ),
//               ),
//               SizedBox(
//                 height: dW * 0.005,
//               ),
//               GestureDetector(
//                 onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const ProfileScreen())),
//                 child: ProfileWidget(
//                   dW: dW,
//                   profilePic: user.avatar,
//                   name: user.profileName,
//                   tS: tS,
//                   city: user.city,
//                   mobileNo: user.phone,
//                   gender: user.gender,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     top: dW * 0.02, left: dW * 0.05, bottom: dW * 0.02),
//                 child: Text(
//                   'My Family',
//                   style: TextStyle(
//                     decoration: TextDecoration.underline,
//                     fontSize: 20 * tS,
//                   ),
//                 ),
//               ),
//               // Container(
//               //   color: Colors.teal.shade50.withOpacity(0.3),
//               //   width: dW,
//               //   child: SingleChildScrollView(
//               //     scrollDirection: Axis.horizontal,
//               //     child: Row(children: [
//               //       ...List.generate(
//               //           auth.familyMembers.length,
//               //           (index) => GestureDetector(
//               //                 onTap: () {
//               //                   Navigator.push(
//               //                       context,
//               //                       MaterialPageRoute(
//               //                           builder: (context) =>
//               //                               SaathiProfileScreen(
//               //                                 memeberId: auth
//               //                                     .familyMembers[index]
//               //                                     .userId,
//               //                               )));
//               //                 },
//               //                 child: FamilyWidget(
//               //                   dW: dW,
//               //                   tS: tS,
//               //                   image: auth.familyMembers[index].imageUrl,
//               //                   name: auth.familyMembers[index].name,
//               //                   relation:
//               //                       auth.familyMembers[index].relation,
//               //                   first: index == 0 ? true : false,
//               //                   last: index ==
//               //                           (auth.familyMembers.length - 1)
//               //                       ? true
//               //                       : false,
//               //                 ),
//               //               ))
//               //     ]),
//               //   ),
//               // ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     top: dW * 0.025, left: dW * 0.05, bottom: dW * 0.02),
//                 child: Text(
//                   'Advertisment',
//                   style: TextStyle(
//                     decoration: TextDecoration.underline,
//                     fontSize: 20 * tS,
//                   ),
//                 ),
//               ),
//               CarouselSlider(
//                   items: List.generate(
//                       auth.advertisments.length,
//                       (index) => Container(
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image: Image.network(
//                                             auth.advertisments[index])
//                                         .image,
//                                     fit: BoxFit.fill,
//                                     filterQuality: FilterQuality.high)),
//                             margin: EdgeInsets.symmetric(
//                               vertical: dW * 0.01,
//                             ),
//                           )),
//                   options: CarouselOptions(
//                       viewportFraction: 1,
//                       autoPlay: true,
//                       autoPlayInterval: const Duration(seconds: 3)))
//             ]),
//       );
//   }
// }

// _appBarButtonStyle() {
//   return ButtonStyle(
//     fixedSize: MaterialStateProperty.resolveWith((states) {
//       if (states.contains(MaterialState.pressed)) {
//         return const Size.fromWidth(0);
//       } else {}
//     }),
//     elevation: MaterialStateProperty.resolveWith((states) {
//       if (states.contains(MaterialState.pressed)) {
//         return 0;
//       }
//       return 0;
//     }),
//     backgroundColor: MaterialStateProperty.resolveWith((states) {
//       // If the button is pressed, return green, otherwise blue
//       if (states.contains(MaterialState.pressed)) {
//         return Colors.red;
//       }
//       return Colors.white;
//     }),
//   );
// }
