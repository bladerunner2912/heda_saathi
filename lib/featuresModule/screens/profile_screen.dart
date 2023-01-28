import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/providers/auth_provider.dart';

import 'package:heda_saathi/authModule/widgets/app_bar.dart';
import 'package:heda_saathi/authModule/widgets/custom_button.dart';
import 'package:heda_saathi/featuresModule/widgets/genreric_header.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../authModule/models/user_modal.dart';
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

  void dateChanger(
    TextEditingController textController,
  ) async {
    DateTime? selectedDate = user.dob;

    selectedDate = await showDatePicker(
        context: context,
        initialDate: DateFormat('dd/MM/yy').parse('${user.dob.day}/${user.dob.month}/${user.dob.year}'),
        firstDate: DateTime(1930),
        lastDate: DateTime.now()) as DateTime;

    if (selectedDate != user.dob) {
      textController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      edited = true;
      setState(() {});
    }
  }

  sendRequest(
    double dW,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: Container(
            padding: EdgeInsets.only(
                left: dW * 0.05, top: dW * 0.03, right: dW * 0.05),
            width: dW * 0.5,
            height: dW * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                    child: Text(
                        'Your Profile edit request is submitted. Changes would be reflected after administrator approval.')),
                const Spacer(),
                CustomAuthButton(
                    onTap: () {
                      Navigator.pop(context);
                      auth.toggleProfileEdit();
                    },
                    buttonLabel: 'OK'),
                const Spacer(),
              ],
            )),
      ),
    );
  }

  @override
  void initState() {
    auth = Provider.of<AuthProvider>(context, listen: false);
    user = auth.loadedUser;
    // TODO: implement initState
    name.text = user.name;
    mobileNo.text = user.phone;
    email.text = user.email;
    dob.text = '${user.dob.day}/${user.dob.month}/${user.dob.year}';
    if(user.married)
{    anniv.text = '${user.anniv!.day}/${user.anniv!.month}/${user.anniv!.year}';
}    profilePic = user.avatar;
  }

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
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
                    height: dW * 0.27,
                    width: dW * 0.27,
                    child: FadeInImage(
                      width: dW * 0.27,
                      image: NetworkImage(profilePic,),
                      placeholder: AssetImage(user.gender == 'Male'
                          ? 'assets/images/menProfile.jpg'
                          : 'assets/images/womenProfile.png' , ),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.white,
                         padding : user.gender == 'Male'? EdgeInsets.all(0) : EdgeInsets.symmetric(horizontal:dW * 0.0265,),
                          width: dW * 0.27,
                          height: dW * 0.27,
                          child: Image.asset(
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
                height: dW*0.8 ,
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
                                      if(user.married)
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
                        if(
                          name.text!=user.name||
                          mobileNo.text!=user.phone||
                          email.text != user.email || edited
                        )  sendRequest(dW);
                        },
                        buttonLabel: 'SEND REQUEST'),
                    SizedBox(
                      height: dW * 0.1,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'NOTE - CHANGE IN PROFILE INFORMATION OTHER\nTHAN THIS WILL BE DONE BY EMAIL',
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




