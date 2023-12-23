import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/providers/auth_provider.dart';
import 'package:heda_saathi/authModule/widgets/app_bar.dart';
import 'package:heda_saathi/common_functions.dart';
import 'package:heda_saathi/featuresModule/widgets/genreric_header.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../authModule/models/user_modal.dart';
import '../../homeModule/widgets/custom_dialog.dart';

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
  TextEditingController profession = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AuthProvider auth;
  String profilePic = '';
  late User user;
  bool edited = false;
  double dW = 0;
  double tS = 0;
  final ImagePicker _picker = ImagePicker();
  late ImageSource source;
  File? _image;
  bool editable = false;

  List<TextEditingController> s = [];
  pickImage() async {
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
        ),
        elevation: 3,
        context: context,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16))),
            child: Row(
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
                        const Spacer(),
                        Icon(
                          Icons.camera,
                          size: dW * 0.1,
                          color: Colors.blue,
                        ),
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
                        const Spacer(),
                        Icon(
                          Icons.browse_gallery,
                          size: dW * 0.1,
                          color: Colors.red,
                        ),
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
          );
        });

    final XFile? image = await _picker.pickImage(
      source: source,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 100,
    );

    // ! ignore: use_build_context_synchronously

    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 1000,
        maxHeight: 1000,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            statusBarColor: Colors.deepOrange.shade900,
            activeControlsWidgetColor: Colors.deepOrange.shade900,
          ),
          IOSUiSettings(
            title: 'Crop Image',
            cancelButtonTitle: 'Cancel',
            doneButtonTitle: 'Save',
            aspectRatioLockEnabled: true,
            aspectRatioPickerButtonHidden: true,
            minimumAspectRatio: 1.0,
          ),
        ],
      );

      _image = File(croppedFile!.path);
      String objectName = fileName(_image!);
      String objectType = fileType(_image!);
      if (objectType != "png" && objectType != "jpg" && objectType != "jpeg") {
        _image = null;
        return;
      }
      // print('uploading');
      await auth.uploadToS3Bucket(
          image: _image!, objectName: objectName, objectType: objectType);
      setState(() {});
      ScaffoldMessenger.of(_scaffoldKey.currentState!.context)
          .showSnackBar(SnackBar(
        content: const Text('Image Upload Succesful'),
        backgroundColor: Colors.green.shade400,
      ));
    } else {
      ScaffoldMessenger.of(_scaffoldKey.currentState!.context)
          .showSnackBar(SnackBar(
        content: const Text('Image Upload Failed'),
        backgroundColor: Colors.red.shade400,
      ));
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
        ScaffoldMessenger.of(_scaffoldKey.currentState!.context)
            .showSnackBar(const SnackBar(
          content: Text("Permission request was denied for uploading photo."),
          backgroundColor: Colors.redAccent,
        ));
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
        firstDate: DateTime(0),
        lastDate: DateTime.now()) as DateTime;

    if (selectedDate != user.dob) {
      textController.text = DateFormat('dd MMMM yyyy').format(selectedDate);
      edited = true;
      setState(() {});
    }
  }

  // sendRequest(
  //   double dW,
  // ) {
  //   showDialogBox(
  //       context: context,
  //       dialogmessage: 'Are you sure you want these changes in your profile.',
  //       buttonOne: 'Yes',
  //       buttonOneFunction: () {
  //         Navigator.of(context).pop();
  //         showDialogBox(
  //             context: context,
  //             dialogmessage: 'Your Request Has Been Accepted',
  //             buttonOne: 'Ok',
  //             buttonOneFunction: () {
  //               Navigator.of(context).pop();
  //             },
  //             dW: dW,
  //             tS: tS);
  //       },
  //       buttonTwo: 'No',
  //       buttonTwoFunction: () {
  //         myInit(user);
  //         Navigator.of(context).pop();
  //       },
  //       dW: dW,
  //       tS: tS);
  // }

  toggleEdit() {
    if (editable == true &&
        (name.text != user.name ||
            email.text != user.email ||
            profession.text != user.profession ||
            dob.text != DateFormat('dd MMMM yyyy').format(user.dob) ||
            city.text != user.city ||
            state.text != user.state)) {
      for (var ss in s) {
        if (ss.text == '') {
          editable = false;
          myInit(user);
          setState(() {});
          ScaffoldMessenger.of(_scaffoldKey.currentState!.context)
              .showSnackBar(const SnackBar(
            content: Text("You cant update with empty information."),
            backgroundColor: Colors.red,
          ));
          return;
        }
      }
      showDialogBox(
          context: context,
          dialogmessage: 'Are you sure you want these changes in your profile.',
          buttonOne: 'Yes',
          buttonOneFunction: () async {
            var result = await auth.editUser(
                birth: DateFormat('dd MMMM yyyy').parse(dob.text),
                city: city.text,
                email: email.text,
                name: name.text,
                profession: profession.text,
                state: state.text);
            if (mounted) Navigator.of(context).pop();
            ScaffoldMessenger.of(_scaffoldKey.currentState!.context)
                .showSnackBar(SnackBar(
              content: Text(result
                  ? 'Profile Updated Succesfully'
                  : "Profile update failed. Please try again after some time."),
              backgroundColor: result ? Colors.greenAccent : Colors.redAccent,
            ));
          },
          buttonTwo: 'No',
          buttonTwoFunction: () {
            myInit(user);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(_scaffoldKey.currentState!.context)
                .showSnackBar(const SnackBar(
              content: Text("Profile update canceled"),
              backgroundColor: Colors.yellowAccent,
            ));
          },
          dW: dW,
          tS: tS);
    }

    setState(() {
      editable = !editable;
    });
  }

  myInit(User user) {
    name.text = user.name;
    mobileNo.text = user.phone;
    email.text = user.email;
    dob.text = DateFormat('dd MMMM yyyy').format(user.dob);
    // if (user.married) {
    //   anniv.text =
    //       '${user.anniv!.day}/${user.anniv!.month}/${user.anniv!.year}';
    // }
    profilePic = user.avatar;
    profession.text = user.profession;
    city.text = user.city;
    state.text = user.state;

    s.add(
      name,
    );
    s.add(
      mobileNo,
    );
    s.add(email);
    s.add(
      dob,
    );
    s.add(
      city,
    );
    s.add(state);
    s.add(profession);
  }

  @override
  void initState() {
    super.initState();
    auth = Provider.of<AuthProvider>(context, listen: false);
    user = auth.loadedUser;
    myInit(user);
  }

  @override
  void dispose() {
    super.dispose();
    for (var element in s) {
      element.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    dW = MediaQuery.of(context).size.width;
    tS = MediaQuery.of(context).textScaleFactor;
    user = Provider.of<AuthProvider>(
      context,
    ).loadedUser;

    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: customAppBar(dW),
        body: Column(children: [
          Header(
            dW: dW,
            tS: tS,
            pageName: 'PROFILE',
            extraButton: true,
            extraButtonName: editable ? 'Save' : 'Edit',
            extraButtononTap: toggleEdit,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'SMARIKA REGISTERATION NO : 2022123${user.id.substring(1, 3).toUpperCase()}',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14 * tS),
            ),
          ),
          SizedBox(
            height: dW * 1.54,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: dW * 0.04,
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    width: dW * 0.55,
                    height: dW * 0.5,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: FadeInImage.assetNetwork(
                      width: dW * 0.55,
                      height: dW * 0.5,
                      image: user.avatar,
                      // placeholder: user.gender == 'Male'
                      //     ? 'assets/images/indian_men.png'
                      //     : 'assets/images/indian_women.png',

                      placeholder: 'assets/images/indian_men.png',
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: dW * 0.55,
                          height: dW * 0.5,
                          color: Colors.black,
                          padding: const EdgeInsets.all(0),

                          // user.gender == 'Male'
                          //     ? const EdgeInsets.all(0)
                          //     : EdgeInsets.symmetric(
                          //         horizontal: dW * 0.0265,
                          //       ),
                          child: Image.asset(
                            // user.gender == 'Male'
                            //     ? 'assets/images/indian_men.png'
                            //     : 'assets/images/indian_women.png',
                            "assets/images/indian_men.png",
                            fit: BoxFit.fitHeight,
                          ),
                        );
                      },
                      fit: BoxFit.fitHeight,
                    ),
                  ),

                  // CircleAvatar(
                  //   radius: dW * 0.2,
                  //   foregroundImage: NetworkImage(
                  //     user.avatar,
                  //     // scale: 1,
                  //   ),
                  //   backgroundImage:
                  //       const AssetImage("assets/images/indian_men.png"),
                  // ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextButton(
                    onPressed: pickImage,
                    child: const Text("Change Profile Photo"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      child: Column(children: [
                        TextFormField(
                          enabled: false,
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  40),
                          controller: mobileNo,
                          style: const TextStyle(fontSize: 22),
                          decoration: InputDecoration(
                              filled: true,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              labelText: 'Phone',
                              fillColor:
                                  Colors.amber.shade400.withOpacity(0.2)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          enabled: editable,
                          controller: name,
                          style: const TextStyle(fontSize: 22),
                          decoration: InputDecoration(
                              filled: true,
                              labelStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              labelText: 'Name',
                              fillColor:
                                  Colors.amber.shade300.withOpacity(0.2)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  40),
                          enabled: editable,
                          controller: email,
                          style: const TextStyle(fontSize: 22),
                          decoration: InputDecoration(
                              filled: true,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              labelText: 'Email',
                              fillColor:
                                  Colors.amber.shade400.withOpacity(0.2)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        GestureDetector(
                          onTap: () => (editable ? dateChanger(dob) : () {}),
                          child: TextFormField(
                            scrollPadding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                        40),
                            enabled: false,
                            controller: dob,
                            style: const TextStyle(fontSize: 22),
                            decoration: InputDecoration(
                                filled: true,
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                labelText: 'Birthday',
                                fillColor:
                                    Colors.amber.shade400.withOpacity(0.2)),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  40),
                          enabled: editable,
                          controller: profession,
                          style: const TextStyle(fontSize: 22),
                          decoration: InputDecoration(
                              filled: true,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              labelText: 'Profession',
                              fillColor:
                                  Colors.amber.shade400.withOpacity(0.2)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          enabled: editable,
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  40),
                          controller: city,
                          style: const TextStyle(fontSize: 22),
                          decoration: InputDecoration(
                              filled: true,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              labelText: 'City/Town/Village',
                              fillColor:
                                  Colors.amber.shade400.withOpacity(0.2)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  40),
                          enabled: editable,
                          controller: state,
                          style: const TextStyle(fontSize: 22),
                          decoration: InputDecoration(
                              filled: true,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              labelText: 'State',
                              fillColor:
                                  Colors.amber.shade400.withOpacity(0.2)),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Note - Phone number cannot be changed. For that contact via ABHMS Help or hedasangathanaapp@gmail.com',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14 * tS,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom,
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          )
          // Container(
          //     padding: EdgeInsets.symmetric(
          //       horizontal: dW * 0.075,
          //     ),
          //     width: dW,
          //     child: Row(
          //       children: [
          //         Container(
          //           color: Colors.black,
          //           child: FadeInImage(
          //             height: dW * 0.27,
          //             width: dW * 0.27,
          //             image: Image.network(
          //               user.avatar,
          //               fit: BoxFit.cover,
          //             ).image,
          //             placeholder: AssetImage(
          //               user.gender == 'Male'
          //                   ? 'assets/images/indian_men.png'
          //                   : 'assets/images/indian_women.png',
          //             ),
          //             imageErrorBuilder: (context, error, stackTrace) {
          //               return Container(
          //                 color: Colors.white,
          //                 padding: user.gender == 'Male'
          //                     ? const EdgeInsets.all(0)
          //                     : EdgeInsets.symmetric(
          //                         horizontal: dW * 0.0265,
          //                       ),
          //                 width: _image != null ? dW * 0.35 : dW * 0.27,
          //                 height: dW * 0.27,
          //                 child: _image != null
          //                     ? Image.file(
          //                         _image!,
          //                         fit: BoxFit.cover,
          //                       )
          //                     : Image.asset(
          //                         user.gender == 'Male'
          //                             ? 'assets/images/indian_men.png'
          //                             : 'assets/images/indian_women.png',
          //                       ),
          //               );
          //             },
          //             fit: BoxFit.scaleDown,
          //           ),
          //         ),
          //         const Spacer(),
          //         GestureDetector(
          //           onTap: () => pickImage(),
          //           child: Text(
          //             'Change profile photo',
          //             style: TextStyle(
          //               fontSize: 18 * tS,
          //               decoration: TextDecoration.underline,
          //             ),
          //           ),
          //         ),
          //         const Spacer(),
          //         const Spacer()
          //       ],
          //     )),
          // user.editRequest
          //     ? SizedBox(
          //         height: dW * 0.8,
          //         child: Center(
          //           child: Padding(
          //             padding: const EdgeInsets.all(32.0),
          //             child: Text(
          //               'YOUR EDIT REQUEST IS IN VERFICATION PROCESS.PLEASE WAIT FOR THE REPSONSE.FOR FURHTER QUERIES\nCONTACT ADMIN: 9224480539',
          //               style: TextStyle(
          //                   fontSize: 14 * tS, fontWeight: FontWeight.w500),
          //             ),
          //           ),
          //         ),
          //       )
          //     : Column(
          //         children: [
          //           Form(
          //             child: Container(
          //                 margin: EdgeInsets.only(top: dW * 0.08),
          //                 width: dW,
          //                 child: Row(
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     const Spacer(),
          //                     SizedBox(
          //                       height: dW * 0.6,
          //                       width: dW * 0.4,
          //                       child: Column(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceAround,
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         // ignore: prefer_const_literals_to_create_immutables
          //                         children: [
          //                           const Text('NAME :'),
          //                           const Text('MOBILE NO. :'),
          //                           const Text('EMAIL :'),
          //                           const Text('DATE OF BIRTHDAY :'),
          //                           if (user.married)
          //                             const Text('ANNIVERSARY :'),
          //                         ],
          //                       ),
          //                     ),
          //                     const Spacer(),
          //                     SizedBox(
          //                       height: dW * 0.6,
          //                       width: dW * 0.4,
          //                       child: Form(
          //                         child: Column(
          //                           mainAxisAlignment:
          //                               MainAxisAlignment.spaceAround,
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.start,
          //                           // ignore: prefer_const_literals_to_create_immutables
          //                           children: [
          //                             ProfileTextFormField(
          //                               tS: tS,
          //                               controller: name,
          //                               tIA: TextInputType.name,
          //                             ),
          //                             ProfileTextFormField(
          //                               tS: tS,
          //                               controller: mobileNo,
          //                               tIA: TextInputType.phone,
          //                             ),
          //                             ProfileTextFormField(
          //                               tS: tS,
          //                               controller: email,
          //                               tIA: TextInputType.emailAddress,
          //                             ),
          //                             GestureDetector(
          //                               onTap: (() => dateChanger(dob)),
          //                               child: ProfileTextFormField(
          //                                 tS: tS,
          //                                 controller: dob,
          //                                 tIA: TextInputType.datetime,
          //                                 unenabled: true,
          //                               ),
          //                             ),
          //                             if (user.married)
          //                               GestureDetector(
          //                                 onTap: (() => dateChanger(anniv)),
          //                                 child: ProfileTextFormField(
          //                                   tS: tS,
          //                                   controller: anniv,
          //                                   tIA: TextInputType.text,
          //                                   unenabled: true,
          //                                 ),
          //                               ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                     const Spacer(),
          //                   ],
          //                 )),
          //           ),
          //           SizedBox(
          //             height: dW * 0.1,
          //           ),
          //           CustomAuthButton(
          //               onTap: () {
          //                 if (name.text != user.name ||
          //                     mobileNo.text != user.phone ||
          //                     email.text != user.email ||
          //                     edited) sendRequest(dW);
          //               },
          //               buttonLabel: 'SEND REQUEST'),
          //           SizedBox(
          //             height: dW * 0.1,
          //           ),
          //           Center(
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Text(
          //                 'Note - Changes other than this can be carried out by sending email. Your changes will reflect in meantime.',
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                     fontSize: 14 * tS, fontWeight: FontWeight.w500),
          //               ),
          //             ),
          //           ),
          //         ],
          //       )
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
