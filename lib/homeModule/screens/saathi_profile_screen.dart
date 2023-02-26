import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:heda_saathi/authModule/providers/family_provider.dart';
import 'package:heda_saathi/authModule/widgets/app_bar.dart';
import 'package:heda_saathi/featuresModule/providers/search_provider.dart';
import 'package:heda_saathi/featuresModule/widgets/genreric_header.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/saathi_model.dart';

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
  TextEditingController state = TextEditingController();
  TextEditingController pincode = TextEditingController();
  late Saathi user;
  bool err = false;
  String msgErr = '';
  bool loading = false;

  @override
  void initState() {
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
    email.text = user.email.toLowerCase();
    dob.text = DateFormat('dd MMMM yyyy').format(user.dob);
    // if (user.married) {
    //   anniv.text =
    //       '${user.anniv!.day}/${user.anniv!.month}/${user.anniv!.year}';
    // }
    profession.text = user.profession;
    city.text = user.city;
    state.text = user.state;
    pincode.text = user.pincode;

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
            height: dW * 1.55,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
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
                      image: user.avatar!,
                      placeholder: user.gender == 'Male'
                          ? 'assets/images/indian_men.png'
                          : 'assets/images/indian_women.png',
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: dW * 0.55,
                          height: dW * 0.5,
                          color: Colors.cyan.shade100,
                          padding: user.gender == 'Male'
                              ? const EdgeInsets.all(0)
                              : EdgeInsets.symmetric(
                                  horizontal: dW * 0.0265,
                                ),
                          child: Image.asset(
                            user.gender == 'Male'
                                ? 'assets/images/indian_men.png'
                                : 'assets/images/indian_women.png',
                            fit: BoxFit.fitHeight,
                          ),
                        );
                      },
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    height: dW * 0.1,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: dW * 0.04),
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
                          enabled: false,
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
                          enabled: false,
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
                        TextFormField(
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
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
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  40),
                          enabled: false,
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
                          enabled: false,
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
                          controller: state,
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  40),
                          enabled: false,
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
                          height: 12,
                        ),
                        TextFormField(
                          controller: pincode,
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  40),
                          enabled: false,
                          style: const TextStyle(fontSize: 22),
                          decoration: InputDecoration(
                              filled: true,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              labelText: 'Pincode',
                              fillColor:
                                  Colors.amber.shade400.withOpacity(0.2)),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: dW * 0.2,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: dW * 1.24,
        margin: EdgeInsets.only(bottom: dW * 0.05),
        child: Row(
          children: [
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(4)),
              onPressed: (() async {
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(4)),
              onPressed: (() async {
                bool whatsapp = await FlutterLaunch.hasApp(name: "whatsapp");

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
      ),
    );
  }
}
