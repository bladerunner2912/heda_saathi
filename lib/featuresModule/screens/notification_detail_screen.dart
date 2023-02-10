import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/widgets/app_bar.dart';
import 'package:heda_saathi/featuresModule/widgets/genreric_header.dart';

class NotificationDetailScreen extends StatelessWidget {
  const NotificationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: customAppBar(dW),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Header(dW: dW, tS: tS, pageName: 'Notification Details'),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 4, bottom: dW * 0.15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                  ),
                  child: Text(
                    'TITLE',
                    style: TextStyle(
                        fontSize: 24 * tS, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  'Papa this was going so well what i can tell you about my experiences there. Enjoying food with best studemts in the world all too very pretty beauty and what not.',
                  style: TextStyle(fontSize: 19 * tS),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 4, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                  ),
                  child: Text(
                    'DETAILS',
                    style: TextStyle(
                        fontSize: 24 * tS, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quis neque non massa interdum viverra. Duis ac mauris ultrices, egestas odio et, rhoncus nulla. Nunc vel mollis risus. Donec vitae orci orci. Donec velit lorem, luctus eu scelerisque ut, porttitor porta arcu. Sed sed ante quis tellus sodales rhoncus quis ut dolor. In sit amet lorem eu justo tincidunt congue eu accumsan tortor. Cras maximus non arcu lacinia convallis. Nullam interdum, diam vel iaculis porttitor, turpis neque rutrum libero, ac elementum orci turpis quis ante. Integer consectetur vestibulum luctus. Mauris lobortis quam nisl, vitae hendrerit orci porta nec. Etiam nec orci aliquet ante sodales tempus. Integer accumsan lorem eu tortor tempor, sed consectetur tortor ultricies. Integer maximus lectus quis cursus tristique. Nam et ultrices lectus, sed commodo dui. ',
                  style: TextStyle(fontSize: 19 * tS),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
