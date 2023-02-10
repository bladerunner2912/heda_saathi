import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/providers/auth_provider.dart';

import 'package:heda_saathi/authModule/widgets/app_bar.dart';
import 'package:heda_saathi/authModule/widgets/custom_button.dart';
import 'package:heda_saathi/common_functions.dart';
import 'package:heda_saathi/featuresModule/widgets/genreric_header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../authModule/models/user_modal.dart';
import '../../homeModule/widgets/custom_dialog.dart';
import '../../homeModule/widgets/profile_text_form_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController anniv = TextEditingController();
  late AuthProvider auth;
  String profilePic = '';
  late User user;
  bool edited = false;
  double dW = 0;
  double tS = 0;
  final ImagePicker _picker = ImagePicker();
  late ImageSource source;
  File? _image;

  pickImage() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(children: [
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      source = ImageSource.camera;
                    });
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: dW * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.camera, size: dW * 0.1),
                        const Spacer(),
                        const Text('Camera'),
                        const Spacer(),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      source = ImageSource.gallery;
                    });
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: dW * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.browse_gallery, size: dW * 0.1),
                        const Spacer(),
                        const Text('Gallery'),
                        const Spacer(),
                        const Spacer()
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                const Spacer(),
              ],
            ),
          ]);
        });

    final XFile? image = await _picker.pickImage(
      source: source,
      maxWidth: dW * 0.5,
      maxHeight: dW * 0.5,
      imageQuality: 100,
    );

    // ! ignore: use_build_context_synchronously

    if (image != null) {
      _image = File(image.path);
      String objectName = fileName(_image!);
      String objectType = fileType(_image!);
      if (objectType != "png" && objectType != "jpg" && objectType != "jpeg") {
        _image = null;
        return;
      }
      print('uploading');
      auth.uploadToS3Bucket(
          image: _image!, objectName: objectName, objectType: objectType);
      setState(() {});
      const SnackBar(content: Text('Image Upload Succesful'));
    } else {
      return const SnackBar(content: Text('Image Upload Failed'));
    }
  }

  onAddPhotoClicked(context) async {
    Permission permission;

    if (Platform.isIOS) {
      permission = Permission.photos;
    } else {
      permission = Permission.storage;
    }
    PermissionStatus permissionStatus = await permission.request();

    print(permissionStatus);

    if (permissionStatus == PermissionStatus.restricted) {
      _showOpenAppSettingsDialog(context);
      permissionStatus = await permission.status;
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }

    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      _showOpenAppSettingsDialog(context);

      permissionStatus = await permission.status;

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.denied) {
      if (Platform.isIOS) {
        _showOpenAppSettingsDialog(context);
      } else {
        permissionStatus = await permission.request();
      }

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.granted) {
      pickImage();
    }
  }

  _showOpenAppSettingsDialog(context) {
    return CustomDialog.show(
      context,
      'Permission needed',
      'Photos permission is needed to select photos',
      'Open settings',
      openAppSettings,
    );
  }

  void dateChanger(
    TextEditingController textController,
  ) async {
    DateTime? selectedDate = user.dob;

    selectedDate = await showDatePicker(
        context: context,
        initialDate: user.dob,
        firstDate: DateTime(1930),
        lastDate: DateTime.now()) as DateTime;

    if (selectedDate != user.dob) {
      textController.text = DateFormat('MM/dd/yy').format(selectedDate);
      edited = true;
      setState(() {});
    }
  }

  sendRequest(
    double dW,
  ) {
    showDialogBox(
        context: context,
        dialogmessage: 'Are you sure you want these changes in your profile.',
        buttonOne: 'Yes',
        buttonOneFunction: () {
          Navigator.of(context).pop();
          showDialogBox(
              context: context,
              dialogmessage: 'Your Request Has Been Accepted',
              buttonOne: 'Ok',
              buttonOneFunction: () {
                Navigator.of(context).pop();
              },
              dW: dW,
              tS: tS);
        },
        buttonTwo: 'No',
        buttonTwoFunction: () {
          myInit(user);
          Navigator.of(context).pop();
        },
        dW: dW,
        tS: tS);
  }

  myInit(User user) {
    name.text = user.name;
    mobileNo.text = user.phone;
    email.text = user.email;
    dob.text = DateFormat('dd/MM/yy').format(user.dob);
    if (user.married) {
      anniv.text =
          '${user.anniv!.day}/${user.anniv!.month}/${user.anniv!.year}';
    }
    profilePic = user.avatar;
  }

  @override
  void initState() {
    auth = Provider.of<AuthProvider>(context, listen: false);
    user = auth.loadedUser;
    myInit(user);
  }

  @override
  Widget build(BuildContext context) {
    dW = MediaQuery.of(context).size.width;
    tS = MediaQuery.of(context).textScaleFactor;
    user = Provider.of<AuthProvider>(
      context,
    ).loadedUser;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: customAppBar(dW),
        body: Column(children: [
          Header(
            dW: dW,
            tS: tS,
            pageName: 'PROFILE',
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'SMARIKA REGISTERATION NO : 2022123${user.id.substring(1, 3).toUpperCase()}',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14 * tS),
            ),
          ),
          SizedBox(
            height: dW * 0.04,
          ),
          Container(
              padding: EdgeInsets.symmetric(
                horizontal: dW * 0.075,
              ),
              width: dW,
              child: Row(
                children: [
                  SizedBox(
                    child: FadeInImage(
                      height: dW * 0.27,
                      width: dW * 0.27,
                      image: NetworkImage(
                        user.avatar,
                      ),
                      placeholder: AssetImage(
                        user.gender == 'Male'
                            ? 'assets/images/menProfile.jpg'
                            : 'assets/images/womenProfile.png',
                      ),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.white,
                          padding: user.gender == 'Male'
                              ? EdgeInsets.all(0)
                              : EdgeInsets.symmetric(
                                  horizontal: dW * 0.0265,
                                ),
                          width: _image != null ? dW * 0.35 : dW * 0.27,
                          height: dW * 0.27,
                          child: _image != null
                              ? Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  user.gender == 'Male'
                                      ? 'assets/images/menProfile.jpg'
                                      : 'assets/images/womenProfile2.png',
                                ),
                        );
                      },
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => pickImage(),
                    child: Text(
                      'Change profile photo',
                      style: TextStyle(
                        fontSize: 18 * tS,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Spacer()
                ],
              )),
          user.editRequest
              ? SizedBox(
                  height: dW * 0.8,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        'YOUR EDIT REQUEST IS IN VERFICATION PROCESS.PLEASE WAIT FOR THE REPSONSE.FOR FURHTER QUERIES\nCONTACT ADMIN: 9284480539',
                        style: TextStyle(
                            fontSize: 14 * tS, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    Form(
                      child: Container(
                          margin: EdgeInsets.only(top: dW * 0.08),
                          width: dW,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Spacer(),
                              SizedBox(
                                height: dW * 0.6,
                                width: dW * 0.4,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const Text('NAME :'),
                                    const Text('MOBILE NO. :'),
                                    const Text('EMAIL :'),
                                    const Text('DATE OF BIRTHDAY :'),
                                    if (user.married)
                                      const Text('ANNIVERSARY :'),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                height: dW * 0.6,
                                width: dW * 0.4,
                                child: Form(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      ProfileTextFormField(
                                        tS: tS,
                                        controller: name,
                                        tIA: TextInputType.name,
                                      ),
                                      ProfileTextFormField(
                                        tS: tS,
                                        controller: mobileNo,
                                        tIA: TextInputType.phone,
                                      ),
                                      ProfileTextFormField(
                                        tS: tS,
                                        controller: email,
                                        tIA: TextInputType.emailAddress,
                                      ),
                                      GestureDetector(
                                        onTap: (() => dateChanger(dob)),
                                        child: ProfileTextFormField(
                                          tS: tS,
                                          controller: dob,
                                          tIA: TextInputType.datetime,
                                          unenabled: true,
                                        ),
                                      ),
                                      if (user.married)
                                        GestureDetector(
                                          onTap: (() => dateChanger(anniv)),
                                          child: ProfileTextFormField(
                                            tS: tS,
                                            controller: anniv,
                                            tIA: TextInputType.text,
                                            unenabled: true,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: dW * 0.1,
                    ),
                    CustomAuthButton(
                        onTap: () {
                          if (name.text != user.name ||
                              mobileNo.text != user.phone ||
                              email.text != user.email ||
                              edited) sendRequest(dW);
                        },
                        buttonLabel: 'SEND REQUEST'),
                    SizedBox(
                      height: dW * 0.1,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Note - Changes other than this can be carried out by sending email. Your changes will reflect in meantime.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14 * tS, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                )
        ]));
  }
}

// profileTextLabels(
//   double dW,
//   String fieldName,
// ) =>
//     SizedBox(
//       width: dW,
//       child: Row(children: [
//         const Spacer(),
//         const Text('Name'),
//         const Spacer(),
//         const Spacer(),
//         SizedBox(width: dW * 0.6, child: TextFormField()),
//         const Spacer(),
//         const Spacer(),
//         const Spacer(),
//       ]),
//     );
