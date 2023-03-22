// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:heda_saathi/authModule/widgets/app_bar.dart';
// import 'package:heda_saathi/authModule/widgets/custom_button.dart';
// import 'package:heda_saathi/homeModule/screens/home_screen.dart';

// class ConnectScreen extends StatefulWidget {
//   final double dH;
//   final double dW;
//   final double tS;
//   const ConnectScreen(
//       {super.key, required this.dH, required this.dW, required this.tS});

//   @override
//   State<ConnectScreen> createState() => _ConnectScreenState();
// }

// class _ConnectScreenState extends State<ConnectScreen> {
//   TextEditingController state = TextEditingController();
//   TextEditingController name = TextEditingController();
//   TextEditingController city = TextEditingController();
//   TextEditingController phone = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
  
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: customAppBar(widget.dW),
//       body: SizedBox(
//         height: widget.dH*0.8,
//         child: Column(children: [
//           Container(
//             color: const Color(0xffe5e9f0),
//             padding: EdgeInsets.symmetric(horizontal: widget.dW * 0.06,vertical: widget.dW * 0.02),
//             width: widget.dW,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 GestureDetector(onTap:  () {
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                             builder: ((context) => const HomeScreenWidget(
//                             currentIndex: 1,
//                           ))));
//                 },child: const Icon(Icons.arrow_back_sharp),),
//                 SizedBox(width: widget.dW * 0.03,),
//                 Text(
//                   'CONNECT WITH HEDA SAATHI',
//                   style: TextStyle(
//                     fontSize: 20 * widget.tS,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: widget.dW * 0.02,
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 0.1),
//             width: widget.dW * 0.98,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black, width: 0.8),
//             ),
//             child: Center(
//               child: Text(
//                 'SEARCH FOR HEDA SAATHI',
//                 style: TextStyle(
//                   fontSize: 16 * widget.tS,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: widget.dW * 0.02,
//           ),
//           Form(
//               child: Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: widget.dW * 0.02),
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: TextFormField(
                  
//                   keyboardType: TextInputType.phone,
//                   controller: phone,
//                  inputFormatters: [
//                     //input type
//                     FilteringTextInputFormatter.allow(
//                       RegExp(r'[0-9]'),
//                     ),
//                   ],
//                   decoration: const InputDecoration(
                  
//                     label: Text('By Phone Number'),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: widget.dW * 0.1,
//               ),
//               const Text(
//                 'OR',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(
//                 height: widget.dW * 0.1,
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: widget.dW * 0.02),
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: TextFormField(
//                   decoration: const InputDecoration(
//                     label: Text('By Name'),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: widget.dW * 0.02),
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: TextFormField(
//                   decoration: const InputDecoration(
//                     label: Text('By City'),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: widget.dW * 0.02),
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: TextFormField(
//                   decoration: const InputDecoration(
//                     label: Text('By State'),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: widget.dW * 0.04,
//               ),
//               CustomAuthButton(onTap: () {}, buttonLabel: 'Search')
//             ],
//           ))
//         ]),
//       ),
//     );
//   }
// }
