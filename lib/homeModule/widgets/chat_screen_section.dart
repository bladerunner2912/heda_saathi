import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/providers/auth_provider.dart';
import 'package:heda_saathi/common_functions.dart';
import 'package:heda_saathi/homeModule/screens/chat_widget.dart';
import 'package:heda_saathi/homeModule/widgets/custom_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
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
  File? _image;
  late ImageSource source;
  late AuthProvider auth;

  // pickImage() async {
  //   await showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return Wrap(children: [
  //           Row(
  //             children: [
  //               const Spacer(),
  //               GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     source = ImageSource.camera;
  //                   });
  //                   Navigator.pop(context);
  //                 },
  //                 child: SizedBox(
  //                   height: widget.dW * 0.2,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Icon(Icons.camera, size: widget.dW * 0.1),
  //                       const Spacer(),
  //                       const Text('Camera'),
  //                       const Spacer(),
  //                       const Spacer(),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               const Spacer(),
  //               GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     source = ImageSource.gallery;
  //                   });
  //                   Navigator.pop(context);
  //                 },
  //                 child: SizedBox(
  //                   height: widget.dW * 0.2,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Icon(Icons.browse_gallery, size: widget.dW * 0.1),
  //                       const Spacer(),
  //                       const Text('Gallery'),
  //                       const Spacer(),
  //                       const Spacer()
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               const Spacer(),
  //               const Spacer(),
  //               const Spacer(),
  //               const Spacer(),
  //               const Spacer(),
  //             ],
  //           ),
  //         ]);
  //       });

  //   final XFile? image = await _picker.pickImage(
  //     source: source,
  //     maxWidth: widget.dW * 0.5,
  //     maxHeight: widget.dH * 0.5,
  //     imageQuality: 100,
  //   );

  //   // ! ignore: use_build_context_synchronously

  //   if (image != null) {
  //     _image = File(image.path);
  //     String objectName = fileName(_image!);
  //     String objectType = fileType(_image!);
  //     if (objectType != "png" && objectType != "jpg" && objectType != "jpeg") {
  //       _image = null;
  //       return;
  //     }
  //     print('uploading');
  //     auth.uploadToS3Bucket(
  //         image: _image!, objectName: objectName, objectType: objectType);
  //     setState(() {});
  //     const SnackBar(content: Text('Image Upload Succesful'));
  //   } else {
  //     return const SnackBar(content: Text('Image Upload Failed'));
  //   }
  // }

  // _showOpenAppSettingsDialog(context) {
  //   return CustomDialog.show(
  //     context,
  //     'Permission needed',
  //     'Photos permission is needed to select photos',
  //     'Open settings',
  //     openAppSettings,
  //   );
  // }

  // onAddPhotoClicked(context) async {
  //   Permission permission;

  //   if (Platform.isIOS) {
  //     permission = Permission.photos;
  //   } else {
  //     permission = Permission.storage;
  //   }
  //   PermissionStatus permissionStatus = await permission.request();

  //   print(permissionStatus);

  //   if (permissionStatus == PermissionStatus.restricted) {
  //     _showOpenAppSettingsDialog(context);
  //     permissionStatus = await permission.status;
  //     if (permissionStatus != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   if (permissionStatus == PermissionStatus.permanentlyDenied) {
  //     _showOpenAppSettingsDialog(context);

  //     permissionStatus = await permission.status;

  //     if (permissionStatus != PermissionStatus.granted) {
  //       //Only continue if permission granted
  //       return;
  //     }
  //   }

  //   if (permissionStatus == PermissionStatus.denied) {
  //     if (Platform.isIOS) {
  //       _showOpenAppSettingsDialog(context);
  //     } else {
  //       permissionStatus = await permission.request();
  //     }

  //     if (permissionStatus != PermissionStatus.granted) {
  //       //Only continue if permission granted
  //       return;
  //     }
  //   }

  //   if (permissionStatus == PermissionStatus.granted) {
  //     pickImage();
  //   }
  // }

  // switchToConnectScreen() {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: ((context) =>
  //               ConnectScreen(dH: widget.dH, dW: widget.dW, tS: widget.tS))));
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.dH,
      width: widget.dW,
      child: Builder(
        builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/coming.png'),
              // Container(
              //   color: Colors.black,
              //   height: widget.dW * 0.5,
              //   width: widget.dW * 0.8,
              //   child: _image != null
              //       ? Image.file(_image!)
              //       : Container(
              //           color: Colors.red,
              //         ),
              // ),
              // ElevatedButton(
              //     onPressed: () => {},
              //     // onPressed: () async {
              //     //   String url = "https://www.google.com";
              //     //   var urllaunchable = await canLaunchUrl(
              //     //       Uri.parse(url)); //canLaunch is from url_launcher package
              //     //   if (urllaunchable) {
              //     //     await launchUrl(Uri.parse(
              //     //         url)); //launch is from url_launcher package to launch URL
              //     //   } else {
              //     //     print("URL can't be launched.");
              //     //   }
              //     // },
              //     // onPressed: () => showDialogBox(
              //     //       dW: widget.dW,
              //     //       tS: widget.tS,
              //     //       buttonOne: 'YES',
              //     //       buttonOneFunction: () {
              //     //         Navigator.of(context).pop();
              //     //       },
              //     //       buttonTwo: 'NO',
              //     //       buttonTwoFunction: () {},
              //     //       dialogmessage:
              //     //           'Are you sure you want the proposed changes in your profile.',
              //     //       context: context,
              //     //     ),
              //     child: const Text('Upload Image')),
            ]),
      ),
    );
  }
}




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