import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../../authModule/widgets/app_bar.dart';
import '../widgets/genreric_header.dart';

class AnniversaryScreen extends StatefulWidget {
  const AnniversaryScreen({super.key});

  @override
  State<AnniversaryScreen> createState() => _AnniversaryScreenState();
}

class _AnniversaryScreenState extends State<AnniversaryScreen> {
  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(dW),
      body: Column(
        children: [
          Header(
            dW: dW,
            tS: tS,
            pageName: 'ANNIVERSARY',
          ),
          SizedBox(
            height: dW * 0.06,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: dW * 0.05, vertical: 8),
            width: dW,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Today',
                style: TextStyle(fontSize: 20 * tS),
              ),
              SizedBox(
                height: dW * 0.06,
              ),
              Container(
                  width: dW,
                  height: dW,
                  child: SingleChildScrollView(
                    child: Column(children: [DummyTile(dW: dW, tS: tS)]),
                  ))
            ]),
          )
        ],
      ),
    );
  }
}

class DummyTile extends StatelessWidget {
  const DummyTile({
    Key? key,
    required this.dW,
    required this.tS,
  }) : super(key: key);

  final double dW;
  final double tS;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: dW * 0.02),
      decoration: BoxDecoration(
          color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12),),
      width: dW,
      child: Row(
        children: [
           Container(
                            decoration: BoxDecoration(
                           color: Colors.blue.withOpacity(0.3), 
                            borderRadius:const  BorderRadius.only(topLeft : Radius.circular(12),
              bottomLeft: Radius.circular(12))),
                          height : dW * 0.2,
                          width: dW * 0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${DateTime.now().day}',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600,fontSize: tS * 28),),
                              Text(DateFormat('MMM').format(DateTime.now()).toUpperCase(),style: TextStyle(color: Colors.blue.shade300,fontWeight: FontWeight.w900,fontSize: tS * 16),)
                            ],
                          ),
                          ),
SizedBox(width: dW * 0.02,),
          Container(
            padding: const EdgeInsets.only(top : 8,left: 4),
                                      height: dW * 0.2,

            width: dW * 0.48,
            child: Text(
              'This is the new process thats allows notification to come via your Heda Saathi Application.',
              maxLines: 3,
              textAlign: TextAlign.start,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                fontSize: 16 * tS,
              ),
            ),
          ),
SizedBox(
            width: dW * 0.02,
          ),

          Container(
                                      height: dW * 0.2,

             width: dW * 0.2,
            decoration: BoxDecoration(
                color: Colors.pinkAccent.shade100.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            padding: EdgeInsets.all(dW * 0.04),
            child: const Center(child: Icon(Icons.arrow_forward_ios_sharp)))
        
        ],
      ),
    );
  }
}
