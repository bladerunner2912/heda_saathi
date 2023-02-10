import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heda_saathi/featuresModule/providers/search_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../authModule/widgets/app_bar.dart';
import '../widgets/birthday_anniversary_tile.dart';
import '../widgets/genreric_header.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  var presentEvents = [];
  var pastEvents = [];
  var upcomingEvents = [];

  myInit() async {
    var searcher = Provider.of<SearchProvider>(context, listen: false);
    presentEvents = searcher.presentEvents;
    pastEvents = searcher.pastEvents;
    upcomingEvents = searcher.upcomingEvents;
  }

  @override
  void initState() {
    // TODO: implement initState
    myInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final dH = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(dW),
      body: Column(
        children: [
          Header(
            dW: dW,
            tS: tS,
            pageName: 'BIRTHDAYS',
          ),
          SizedBox(
            height: dH * 0.8,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: dW * 0.04),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: dW * 0.01,
                  ),

                  if (presentEvents.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: dW * 0.01, vertical: dW * 0.005),
                      child: Text(
                        'Today',
                        style: TextStyle(fontSize: 18 * tS),
                      ),
                    ),
                  ...List.generate(
                    presentEvents.length,
                    (index) => BirthdayAnnivesaryTile(
                        saathi: presentEvents[index], dW: dW, tS: tS),
                  ),

                  if (pastEvents.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                          left: dW * 0.01, top: dW * 0.04, bottom: dW * 0.005),
                      child: Text(
                        'Previous',
                        style: TextStyle(fontSize: 18 * tS),
                      ),
                    ),
                  ...List.generate(
                    pastEvents.length,
                    (index) => BirthdayAnnivesaryTile(
                        saathi: pastEvents[index], dW: dW, tS: tS),
                  ),

                  if (upcomingEvents.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                          left: dW * 0.01, top: dW * 0.04, bottom: dW * 0.005),
                      child: Text(
                        'Upcoming',
                        style: TextStyle(fontSize: 18 * tS),
                      ),
                    ),
                  ...List.generate(
                    upcomingEvents.length,
                    (index) => BirthdayAnnivesaryTile(
                        saathi: upcomingEvents[index], dW: dW, tS: tS),
                  ),
                  SizedBox(
                    height: dW * 0.1,
                  ),
                  //   SizedBox(
                  //     width: dW,
                  //     height: dH * 0.8,
                  //     child:
                  //         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  //       Padding(padding: EdgeInsets.only(left: dW * 0.06,top: dW * 0.005,bottom: dW * 0.003),child: Text('Today', style: TextStyle(fontSize: 16 * tS,decoration: TextDecoration.underline,),),),
                  //       Container(
                  //                 padding: EdgeInsets.symmetric(horizontal: dW * 0.05, ),

                  //           width: dW,
                  //           height: dH * 0.3,
                  //           child: SingleChildScrollView(
                  //             child: Column(
                  //                 children: [
                  //                   BirthdayAnnivesaryTile(dW: dW, tS: tS,isTop: true,),
                  //                   BirthdayAnnivesaryTile(dW: dW, tS: tS,),
                  //                   BirthdayAnnivesaryTile(dW: dW, tS: tS,),
                  //                   BirthdayAnnivesaryTile(dW: dW, tS: tS,),
                  //                   BirthdayAnnivesaryTile(dW: dW, tS: tS,),
                  //                   BirthdayAnnivesaryTile(dW: dW, tS: tS,),
                  //                   BirthdayAnnivesaryTile(dW: dW, tS: tS,),

                  //                   ], ),
                  //           ))

                  // ,
                  // const Spacer(),
                  //       Padding(padding: EdgeInsets.only(left: dW * 0.06,top: dW * 0.005,bottom: dW * 0.003),child: Text('Previous Birthdays And Anniversary'),),

                  //       Container(
                  //                 padding: EdgeInsets.symmetric(horizontal: dW * 0.05, ),

                  //           width: dW,
                  //           height: dH * 0.44,
                  //           child: SingleChildScrollView(
                  //             child: Column(
                  //                 children: [
                  //                   BirthdayAnnivesaryTile(dW: dW, tS: tS,isTop: true,),
                  //                   BirthdayAnnivesaryTile(dW: dW, tS: tS,),
                  //                   BirthdayAnnivesaryTile(dW: dW, tS: tS,),
                  //                   BirthdayAnnivesaryTile(dW: dW, tS: tS,),
                  //                   BirthdayAnnivesaryTile(dW: dW, tS: tS,),
                  //                   BirthdayAnnivesaryTile(dW: dW, tS: tS,),
                  //                   BirthdayAnnivesaryTile(dW: dW, tS: tS,),

                  //                   ], ),
                  //           ))
                  //     ]),
                  //   )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  Container(
//                             decoration: BoxDecoration(
//                            color: Colors.red.shade400.withOpacity(0.3),

//                             borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),bottomLeft:Radius.circular(12))),
//                           height : dW * 0.2,
//                           width: dW * 0.2,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text('${DateTime.now().day}',style: TextStyle(color: Colors.red.shade300,fontWeight: FontWeight.w600,fontSize: tS * 28),),
//                               Text(DateFormat('MMM').format(DateTime.now()).toUpperCase(),style: TextStyle(color: Colors.red.shade300,fontWeight: FontWeight.w900,fontSize: tS * 16),)
//                             ],
//                           ),
//                           ),
