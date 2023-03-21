import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/models/advertisment_model.dart';
import 'package:heda_saathi/common_functions.dart';
import 'package:heda_saathi/homeModule/screens/add_saathi_screen.dart';
import 'package:heda_saathi/homeModule/screens/saathi_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../authModule/providers/auth_provider.dart';
import '../../featuresModule/screens/profile_screen.dart';
import '../models/saathi_model.dart';
import '../widgets/family_widget.dart';
import '../widgets/profile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.dW,
    required this.dH,
    required this.tS,
    required this.familyMembers,
    required this.advertisments,
  }) : super(key: key);

  final double dW;
  final double dH;
  final double tS;
  final List<Saathi> familyMembers;
  final List<Advertisment> advertisments;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context).loadedUser;
    return Container(
      color: Colors.white,
      width: widget.dW,
      height: widget.dH,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: widget.dW * 0.005,
        ),
        Center(
          child: Text(
            'SMARIKA REGISTERATION NO : 2022123${user.id.substring(1, 3).toUpperCase()}',
            style: TextStyle(fontSize: 14 * widget.tS),
          ),
        ),
        SizedBox(
          height: widget.dW * 0.005,
        ),
        GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileScreen())),
          child: ProfileWidget(
            dW: widget.dW,
            tS: widget.tS,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: widget.dW * 0.02,
              left: widget.dW * 0.05,
              bottom: widget.dW * 0.02),
          child: Text(
            'My Family',
            style: TextStyle(
              fontSize: 20 * widget.tS,
            ),
          ),
        ),
        SizedBox(
          // color: Colors.teal.shade50.withOpacity(0.3),
          width: widget.dW,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              ...List.generate(
                  widget.familyMembers.length,
                  (index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SaathiProfileScreen(
                                        memeberId:
                                            widget.familyMembers[index].userId,
                                        isFamilyMember: true,
                                      )));
                        },
                        child: FamilyWidget(
                          dW: widget.dW,
                          tS: widget.tS,
                          saathi: widget.familyMembers[index],
                          first: index == 0 ? true : false,
                          last: index == (widget.familyMembers.length - 1)
                              ? true
                              : false,
                        ),
                      )),
              GestureDetector(
                onTap: () {
                  navigator(context, const AddSaathiScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(0.2),
                  ),
                  margin: EdgeInsets.only(
                      left: widget.familyMembers.isEmpty
                          ? widget.dW * 0.035
                          : widget.dW * 0.02,
                      right: widget.dW * (0.37)),
                  padding: EdgeInsets.only(
                      bottom: widget.dW * 0.005,
                      left: widget.dW * 0.06,
                      right: widget.dW * 0.06,
                      top: widget.dW * 0.04),
                  width: widget.dW * 0.42,
                  height: widget.dW * 0.5,
                  child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                        Icon(Icons.add_sharp),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Add your Family  Members',
                          textAlign: TextAlign.center,
                        )
                      ])),
                ),
              ),
            ]),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: widget.dW * 0.025,
              left: widget.dW * 0.05,
              bottom: widget.dW * 0.02),
          child: Text(
            'Advertisment',
            style: TextStyle(
              fontSize: 20 * widget.tS,
            ),
          ),
        ),
        CarouselSlider(
            items: List.generate(
                widget.advertisments.length,
                (index) => GestureDetector(
                      onTap: () async {
                        String url = widget.advertisments[index].websiteUrl;
                        var urllaunchable = await canLaunchUrl(
                          Uri.parse(url),
                        ); //canLaunch is from url_launcher package
                        if (urllaunchable) {
                          await launchUrl(
                              Uri.parse(
                                url,
                              ),
                              mode: LaunchMode
                                  .externalApplication); //launch is from url_launcher package to launch URL
                        } else if (mounted) {
                          showDialogBox(
                              context: context,
                              dialogmessage:
                                  'Cant open the website due to some issues',
                              buttonOne: 'Ok',
                              buttonOneFunction: () {
                                Navigator.pop(context);
                              },
                              dW: widget.dW,
                              tS: widget.tS);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Image.network(
                                        widget.advertisments[index].posterUrl)
                                    .image,
                                fit: BoxFit.fill,
                                filterQuality: FilterQuality.high)),
                        margin: EdgeInsets.symmetric(
                          vertical: widget.dW * 0.01,
                        ),
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
