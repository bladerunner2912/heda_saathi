import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:heda_saathi/homeModule/screens/saathi_profile_screen.dart';

import '../../authModule/models/user_modal.dart';
import '../../authModule/providers/auth_provider.dart';
import '../../featuresModule/screens/profile_screen.dart';
import '../models/saathi_model.dart';
import '../widgets/family_widget.dart';
import '../widgets/profile_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.dW,
    required this.dH,
    required this.user,
    required this.tS,
    required this.auth,
    required this.familyMembers,
  }) : super(key: key);

  final double dW;
  final double dH;
  final User user;
  final double tS;
  final List<Saathi> familyMembers;
  final AuthProvider auth;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: dW,
      height: dH,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: dW * 0.005,
        ),
        Center(
          child: Text(
            'SMARIKA REGISTERATION NO : 2022123${user.id.substring(1, 3).toUpperCase()}',
            style: TextStyle(fontSize: 14 * tS),
          ),
        ),
        SizedBox(
          height: dW * 0.005,
        ),
        GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileScreen())),
          child: ProfileWidget(
            dW: dW,
            profilePic: user.avatar,
            name: user.name,
            tS: tS,
            city: user.city,
            mobileNo: user.phone,
            gender: user.gender,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: dW * 0.02, left: dW * 0.05, bottom: dW * 0.02),
          child: Text(
            'My Family',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 20 * tS,
            ),
          ),
        ),
        Container(
          color: Colors.teal.shade50.withOpacity(0.3),
          width: dW,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              ...List.generate(
                  familyMembers.length,
                  (index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SaathiProfileScreen(
                                        memeberId: familyMembers[index]
                                            .userId,
                                            isFamilyMember: true,
                                      )));
                        },
                        child: FamilyWidget(
                          dW: dW,
                          tS: tS,
                          saathi: familyMembers[index],
                          first: index == 0 ? true : false,
                          last: index ==
                                  (familyMembers.length - 1)
                              ? true
                              : false,
                        ),
                      ))
            ]),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: dW * 0.025, left: dW * 0.05, bottom: dW * 0.02),
          child: Text(
            'Advertisment',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 20 * tS,
            ),
          ),
        ),
        CarouselSlider(
            items: List.generate(
                auth.advertisments.length,
                (index) => Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: Image.network(auth.advertisments[index])
                                  .image,
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.high)),
                      margin: EdgeInsets.symmetric(
                        vertical: dW * 0.01,
                      ),
                    )),
            options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3)))
      ]),
    );
  }
}
