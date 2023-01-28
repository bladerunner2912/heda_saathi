import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heda_saathi/homeModule/screens/chat_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../../main.dart';

class ChatScreen extends StatefulWidget {
  final double dW;
  final double dH;
  final double tS;
  const ChatScreen(
      {required this.dW, required this.dH, required this.tS, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ImagePicker _picker = ImagePicker();
  var _image;

  pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: widget.dW * 0.4,
      maxHeight: widget.dH * 0.4,
      imageQuality: 100,
    );

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  switchConnectScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) =>
                ConnectScreen(dH: widget.dH, dW: widget.dW, tS: widget.tS))));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.dH,
      width: widget.dW,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/coming.png'),
            Container(
              color: Colors.black,
              height: widget.dW * 0.5,
              width: widget.dW * 0.8,
              child: _image != null
                  ? Image.file(_image)
                  : Container(
                      color: Colors.red,
                    ),
            ),
            ElevatedButton(
                onPressed: () => pickImage(),
                child: const Text('Upload Image')),
            // Container(
            //   color: const Color(0xffe5e9f0),
            //   padding: EdgeInsets.symmetric(
            //       vertical: widget.dW * 0.022, horizontal: widget.dW * 0.06),
            //   width: widget.dW,
            //   child:

            //    Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'MESSAGE',
            //         style: TextStyle(
            //           fontSize: 20 * widget.tS,
            //         ),
            //       ),
            //       GestureDetector(
            //         onTap: (() => switchConnectScreen()),
            //         child: Container(
            //           decoration: BoxDecoration(
            //               border: Border.all(color: Colors.black, width: 0.8)),
            //           padding: EdgeInsets.symmetric(
            //               horizontal: widget.dW * 0.015,
            //               vertical: widget.dW * 0.015),
            //           child: Center(
            //             child: Text('CONNECT',
            //                 style: TextStyle(
            //                   fontSize: 14 * widget.tS,
            //                 )),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Container(
            //   height: widget.dH * 0.73,
            //   padding: EdgeInsets.symmetric(horizontal: widget.dW * 0.04),
            //   child: SingleChildScrollView(
            //       scrollDirection: Axis.vertical,
            //       child: Column(
            //         children: [
            //           SizedBox(
            //             height: widget.dW * 0.04,
            //           ),
            //           ChatTile(
            //             talkingTo: 'Yash Heda',
            //             dW: widget.dW,
            //             tS: widget.tS,
            //             avatar: '',
            //             uneadedMessages: 2,
            //             lastMessageTime: DateTime.now(),
            //             city: 'Bhusawal',
            //             state: 'MH',
            //             gender: 'Male',
            //             lastMessage: 'Happy Birthday Yash Hope You will be there.',
            //             dH : widget.dH,
            //           ),
            //           // ChatTile(
            //           //   talkingTo: 'Yash Heda',
            //           //   dW: widget.dW,
            //           //   tS: widget.tS,
            //           //   avatar: '',
            //           //   uneadedMessages: 2,
            //           //   lastMessageTime: DateTime.now(),
            //           //   city: 'Bhusawal',
            //           //   state: 'MH',
            //           //   gender: 'Male',
            //           //   lastMessage: 'Happy Birthday Yash Hope You will be there.',
            //           // ),
            //           // ChatTile(
            //           //   talkingTo: 'Yash Heda',
            //           //   dW: widget.dW,
            //           //   tS: widget.tS,
            //           //   avatar: '',
            //           //   uneadedMessages: 2,
            //           //   lastMessageTime: DateTime.now(),
            //           //   city: 'Bhusawal',
            //           //   state: 'MH',
            //           //   gender: 'Male',
            //           //   lastMessage: 'Happy Birthday Yash Hope You will be there.',
            //           // ),
            //           // ChatTile(
            //           //   talkingTo: 'Yash Heda',
            //           //   dW: widget.dW,
            //           //   tS: widget.tS,
            //           //   avatar: '',
            //           //   uneadedMessages: 2,
            //           //   lastMessageTime: DateTime.now(),
            //           //   city: 'Bhusawal',
            //           //   state: 'MH',
            //           //   gender: 'Male',
            //           //   lastMessage: 'Happy Birthday Yash Hope You will be there.',
            //           // ),
            //           // ChatTile(
            //           //   talkingTo: 'Yash Heda',
            //           //   dW: widget.dW,
            //           //   tS: widget.tS,
            //           //   avatar: '',
            //           //   uneadedMessages: 2,
            //           //   lastMessageTime: DateTime.now(),
            //           //   city: 'Bhusawal',
            //           //   state: 'MH',
            //           //   gender: 'Male',
            //           //   lastMessage: 'Happy Birthday Yash Hope You will be there.',
            //           // ),
            //           // ChatTile(
            //           //   talkingTo: 'Yash Heda',
            //           //   dW: widget.dW,
            //           //   tS: widget.tS,
            //           //   avatar: '',
            //           //   uneadedMessages: 2,
            //           //   lastMessageTime: DateTime.now(),
            //           //   city: 'Bhusawal',
            //           //   state: 'MH',
            //           //   gender: 'Male',
            //           //   lastMessage: 'Happy Birthday Yash Hope You will be there.',
            //           // ),
            //           // ChatTile(
            //           //   talkingTo: 'Yash Heda',
            //           //   dW: widget.dW,
            //           //   tS: widget.tS,
            //           //   avatar: '',
            //           //   uneadedMessages: 2,
            //           //   lastMessageTime: DateTime.now(),
            //           //   city: 'Bhusawal',
            //           //   state: 'MH',
            //           //   gender: 'Male',
            //           //   lastMessage: 'Happy Birthday Yash Hope You will be there.',
            //           // ),
            //         ],
            //       )),
            // ),
          ]),
    );
  }
}
