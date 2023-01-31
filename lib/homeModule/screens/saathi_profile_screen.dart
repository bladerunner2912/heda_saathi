import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:heda_saathi/authModule/providers/auth_provider.dart';
import 'package:heda_saathi/authModule/providers/family_provider.dart';
import 'package:heda_saathi/authModule/widgets/app_bar.dart';
import 'package:heda_saathi/featuresModule/providers/search_provider.dart';
import 'package:heda_saathi/featuresModule/widgets/genreric_header.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/saathi_model.dart';
import '../widgets/profile_text_form_field.dart';

class SaathiProfileScreen extends StatefulWidget {
  final String memeberId;
  final bool isFamilyMember;
  final bool birthDayFetch;
  const SaathiProfileScreen(
      {this.isFamilyMember = false,
      super.key,
      required this.memeberId,
      this.birthDayFetch = false});

  @override
  State<SaathiProfileScreen> createState() => _SaathiProfileScreenState();
}

class _SaathiProfileScreenState extends State<SaathiProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController anniv = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController city = TextEditingController();
  late Saathi user;
  bool err = false;
  String msgErr = '';
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    if (widget.isFamilyMember) {
      user = Provider.of<FamiliesProvider>(context, listen: false)
          .familyMembers
          .firstWhere((member) => member.userId == widget.memeberId);
    } else if (widget.birthDayFetch) {
      user = Provider.of<SearchProvider>(context, listen: false)
          .allEventsUserSearch(widget.memeberId);
    } else {
      user = Provider.of<SearchProvider>(context, listen: false)
          .searchedMembers
          .firstWhere((element) => element.userId == widget.memeberId);
    }

    name.text = user.name;
    mobileNo.text = user.phone;
    email.text = user.email;
    dob.text = DateFormat('dd/MM/yy').format(user.dob);
    // if (user.married) {
    //   anniv.text =
    //       '${user.anniv!.day}/${user.anniv!.month}/${user.anniv!.year}';
    // }
    profession.text = user.profession;
    city.text = user.place;

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double dW = MediaQuery.of(context).size.width;
    final double tS = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: customAppBar(dW),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Header(
            dW: dW,
            pageName: 'SAATHI PROFILE',
            tS: tS,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'SMARIKA REGISTERATION NO : 2023${user.userId.toString().substring(0, 6).toUpperCase()}',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14 * tS),
            ),
          ),
          SizedBox(
            height: dW * 0.06,
          ),
          SizedBox(
            height: dW * 0.35,
            width: dW * 0.35,
            child: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              width: dW * 0.35,
              child: FadeInImage(
                width: dW * 0.35,
                image: Image.network(
                  '',
                  fit: BoxFit.fitWidth,
                ).image,
                placeholder: AssetImage(
                  user.gender == 'Male'
                      ? 'assets/images/menProfile.jpg'
                      : 'assets/images/womenProfile.png',
                ),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.white,
                    padding: user.gender == 'Male'
                        ? const EdgeInsets.all(0)
                        : EdgeInsets.symmetric(
                            horizontal: dW * 0.0265,
                          ),
                    width: dW * 0.35,
                    height: dW * 0.35,
                    child: Image.asset(
                      user.gender == 'Male'
                          ? 'assets/images/menProfile.jpg'
                          : 'assets/images/womenProfile2.png',
                    ),
                  );
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
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
                          height: dW * 0.7,
                          width: dW * 0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text('NAME :'),
                              const Text('MOBILE NO. :'),
                              const Text('EMAIL :'),
                              const Text('DATE OF BIRTHDAY :'),
                              // if (user.married) const Text('ANNIVERSARY :'),
                              const Text('PROFESSION :'),
                              const Text('PLACE :'),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: dW * 0.7,
                          width: dW * 0.4,
                          child: Form(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                ProfileTextFormField(
                                  tS: tS,
                                  controller: name,
                                  tIA: TextInputType.name,
                                  unenabled: true,
                                ),
                                ProfileTextFormField(
                                  tS: tS,
                                  controller: mobileNo,
                                  tIA: TextInputType.phone,
                                  unenabled: true,
                                ),
                                ProfileTextFormField(
                                  tS: tS,
                                  controller: email,
                                  tIA: TextInputType.emailAddress,
                                  unenabled: true,
                                ),
                                ProfileTextFormField(
                                  tS: tS,
                                  controller: dob,
                                  tIA: TextInputType.datetime,
                                  unenabled: true,
                                ),
                                // if (user.married)
                                //   ProfileTextFormField(
                                //     tS: tS,
                                //     controller: anniv,
                                //     tIA: TextInputType.text,
                                //     unenabled: true,
                                //   ),
                                ProfileTextFormField(
                                  tS: tS,
                                  controller: profession,
                                  tIA: TextInputType.text,
                                  unenabled: true,
                                ),
                                ProfileTextFormField(
                                  tS: tS,
                                  controller: city,
                                  tIA: TextInputType.text,
                                  unenabled: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    )),
              ),
            ],
          ),
          Container(
            width: dW,
            padding:
                EdgeInsets.symmetric(vertical: dW * 0.06, horizontal: dW * 0.1),
            margin: EdgeInsets.only(top: dW * 0.15),
            child: Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: (() async {
                    Uri phoneNo = Uri.parse('tel:+91${mobileNo.text}');
                    if (await canLaunchUrl(phoneNo)) {
                      //dialer opened
                      await launchUrl(phoneNo);
                    } else {
                      throw 'Could not launch $phoneNo';
                      //dailer is not opened
                    }
                  }),
                  child: Icon(
                    Icons.call,
                    size: dW * 0.1,
                    color: Colors.blue,
                  ),
                ),
                const Spacer(),
                const Spacer(),
                GestureDetector(
                  onTap: (() async {
                    bool whatsapp =
                        await FlutterLaunch.hasApp(name: "whatsapp");

                    if (whatsapp) {
                      await FlutterLaunch.launchWhatsapp(
                          phone: "91${mobileNo.text}",
                          message: "Hello,${name.text} ji!");
                    } else {
                      setState(() {
                        err = false;
                        msgErr = '';
                      });
                    }
                  }),
                  // onTap: (() async {
                  //   Uri whatsAppUri =
                  //       Uri.parse("https://wa.me/?text=Hey buddy, try this super cool new app!");
                  //   if (await canLaunchUrl(whatsAppUri)) {
                  //     await launchUrl(whatsAppUri);
                  //   }
                  // }),
                  child: Icon(
                    Icons.whatsapp,
                    size: dW * 0.1,
                    color: Colors.green,
                  ),
                ),
                // const Spacer(),
                // const Spacer(),
                // Icon(
                //   Icons.email_sharp,
                //   color: Colors.blue,
                //   size: dW * 0.1,
                // ),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
