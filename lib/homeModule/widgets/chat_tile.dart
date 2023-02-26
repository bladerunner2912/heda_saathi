// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:heda_saathi/chatModule/screens/chat_screen.dart';
// import 'package:heda_saathi/homeModule/widgets/chat_screen_section.dart';
// import 'package:intl/intl.dart';

// class ChatTile extends StatefulWidget {
//   final double dW;
//   final double tS;
//   final String lastMessage;
//   final String talkingTo;
//   final String avatar;
//   final int uneadedMessages;
//   final DateTime lastMessageTime;
//   final String city;
//   final String state;
//   final String gender;
//   final double dH;
//   bool isFirst;

//   ChatTile(
//       {required this.talkingTo,
//       required this.dW,
//       required this.tS,
//       super.key,
//       this.isFirst = false,
//       required this.avatar,
//       required this.uneadedMessages,
//       required this.lastMessageTime,
//       required this.city,
//       required this.state,
//       required this.gender,
//       required this.dH,
//       required this.lastMessage});

//   @override
//   State<ChatTile> createState() => _ChatTileState();
// }

// class _ChatTileState extends State<ChatTile> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     ChatScreenInstance(dW: widget.dW, dH: widget.dH, tS: widget.tS)));
//       },
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         margin: EdgeInsets.symmetric(
//             vertical: widget.isFirst ? widget.dW * 0.03 : widget.dW * 0.02),
//         height: widget.dW * 0.22,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.black, width: 0.8),
//         ),
//         child: Row(
//           children: [
//             SizedBox(
//               height: widget.dW * 0.22,
//               width: widget.dW * 0.2,
//               child: ClipRRect(
//                 child: FadeInImage(
//                   width: widget.dW * 0.2,
//                   image: NetworkImage(
//                       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQI5x6k5q5YKfpLFGxrcRui0giJxnDfMByNNA&usqp=CAU'),
//                   placeholder: AssetImage(widget.gender == 'Male'
//                       ? 'assets/images/indian_men.png'
//                       : 'assets/images/indian_women.png'),
//                   imageErrorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       color: Colors.white,
//                       padding: widget.gender == 'Male'
//                           ? const EdgeInsets.all(0)
//                           : EdgeInsets.symmetric(
//                               horizontal: widget.dW * 0.0265,
//                             ),
//                       width: widget.dW * 0.2,
//                       height: widget.dW * 0.22,
//                       child: Image.asset(
//                         widget.gender == 'Male'
//                             ? 'assets/images/indian_men.png'
//                             : 'assets/images/indian_women.png',
//                       ),
//                     );
//                   },
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const Spacer(),
//             const Spacer(),
//             Container(
//               padding: EdgeInsets.symmetric(vertical: 6),
//               width: widget.dW * 0.6,
//               height: widget.dW * 0.22,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         '${widget.talkingTo.toUpperCase()}, ',
//                         style: TextStyle(
//                           fontSize: 16 * widget.tS,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                       Text(
//                         '${widget.city}(${widget.state.toUpperCase()})',
//                         style: TextStyle(
//                           fontSize: 16 * widget.tS,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   SizedBox(
//                     width: widget.dW * 0.5,
//                     child: Text(
//                       widget.lastMessage,
//                       style: TextStyle(
//                         fontSize: 16 * widget.tS,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Spacer(),
//             Container(
//               padding: EdgeInsets.symmetric(vertical: widget.dW * 0.005),
//               height: widget.dW * 0.22,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(DateFormat('hh:mm').format(widget.lastMessageTime)),
//                   const Icon(Icons.check_circle)
//                 ],
//               ),
//             ),
//             const Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }
