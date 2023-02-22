import 'package:flutter/material.dart';
import 'package:heda_saathi/featuresModule/screens/notification_detail_screen.dart';
import 'package:intl/intl.dart';
import '../models/notification.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    Key? key,
    required this.dW,
    required this.tS,
    required this.notification,
    this.opened = false,
  }) : super(key: key);

  final double dW;
  final double tS;
  final Notifications notification;
  final bool opened;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotificationDetailScreen(
                      notification: notification,
                      openedFirstTime: opened,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: dW * 0.02),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        width: dW,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12))),
              height: dW * 0.2,
              width: dW * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${notification.recievedAt.day}',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: tS * 28),
                  ),
                  Text(
                    DateFormat('MMM')
                        .format(notification.recievedAt)
                        .toUpperCase(),
                    style: TextStyle(
                        color: Colors.blue.shade300,
                        fontWeight: FontWeight.w900,
                        fontSize: tS * 16),
                  )
                ],
              ),
            ),
            SizedBox(
              width: dW * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(top: 8, left: 4),
              height: dW * 0.2,
              width: dW * (opened ? 0.48 : 0.7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                      fontSize: 18 * tS,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    notification.content,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                      fontSize: 15 * tS,
                    ),
                  ),
                ],
              ),
            ),
            if (opened)
              Row(
                children: [
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
                      child: const Center(
                          child: Icon(Icons.arrow_forward_ios_sharp))),
                ],
              )
          ],
        ),
      ),
    );
  }
}

// class AnniversaryScreen extends StatefulWidget {
//   const AnniversaryScreen({super.key});

//   @override
//   State<AnniversaryScreen> createState() => _AnniversaryScreenState();
// }

// class _AnniversaryScreenState extends State<AnniversaryScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final dW = MediaQuery.of(context).size.width;
//     final tS = MediaQuery.of(context).textScaleFactor;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: customAppBar(dW),
//       body: Column(
//         children: [
//           Header(
//             dW: dW,
//             tS: tS,
//             pageName: 'ANNIVERSARY',
//           ),
//           SizedBox(
//             height: dW * 0.06,
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: dW * 0.05, vertical: 8),
//             width: dW,
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text(
//                 'Today',
//                 style: TextStyle(fontSize: 20 * tS),
//               ),
//               SizedBox(
//                 height: dW * 0.06,
//               ),
//               Container(
//                   width: dW,
//                   height: dW,
//                   child: SingleChildScrollView(
//                     child: Column(children: [DummyTile(dW: dW, tS: tS)]),
//                   ))
//             ]),
//           )
//         ],
//       ),
//     );
//   }
// }


