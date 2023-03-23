import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/widgets/app_bar.dart';
import 'package:heda_saathi/common_functions.dart';
import 'package:heda_saathi/featuresModule/widgets/genreric_header.dart';
import 'package:url_launcher/url_launcher.dart';

class AddSaathiScreen extends StatelessWidget {
  const AddSaathiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(dW),
      body: Column(children: [
        Header(dW: dW, tS: tS, pageName: 'ADD SAATHI'),
        const Spacer(),
        Center(
          child: elevatedButton(
            buttonColor: Colors.blue.shade400,
            width: dW * 0.5,
            height: dW * 0.2,
            label: 'Saathi Registration Form',
            buttonFunction: () async {
              String url =
                  "https://docs.google.com/forms/d/e/1FAIpQLSckpF9w-QPHJvLFnbewDXvZuoRBd5gW-ZLnolEXGYFg0gd5yg/viewform?usp=sf_link";
              bool urllaunchable = await canLaunchUrl(
                  Uri.parse(url)); //canLaunch is from url_launcher package
              if (urllaunchable) {
                await launchUrl(Uri.parse(
                    url)); //launch is from url_launcher package to launch URL
              } else {
                if (kDebugMode) {
                  print("URL can't be launched.");
                }
              }
            },
          ),
        ),
        const Spacer(),
        const Spacer(),
      ]),
    );
  }
}
