import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:heda_saathi/authModule/widgets/custom_button.dart';

import '../../authModule/widgets/app_bar.dart';
import '../widgets/genreric_header.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  TextEditingController requestContent = TextEditingController();
  FocusNode fN = FocusNode();
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: customAppBar(dW),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            dW: dW,
            tS: tS,
            pageName: 'ABHMS HELP',
          ),
          Container(
            padding: EdgeInsets.only(left: dW * 0.04, right: dW * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: dW * 0.1,
                ),
                Text(
                  'SEND YOUR REQUEST:',
                  style: TextStyle(fontSize: 16 * tS),
                ),
                SizedBox(
                  height: dW * 0.03,
                ),
                Form(
                  key: key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        onEditingComplete: (() => {fN.unfocus()}),
                        focusNode: fN,
                        onSaved: (_) {},
                        maxLength: 600,
                        maxLines: 10,
                        controller: requestContent,
                        style: TextStyle(
                            fontSize: 18 * tS, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.yellow.shade900)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: dW * 0.04,
                ),
              ],
            ),
          ),
          SizedBox(
            height: dW * 0.04,
          ),
          Center(
              child: CustomAuthButton(
                  onTap: () {
                    if (requestContent.text.isNotEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                elevation: 4,
                                child: Container(
                                  width: dW * 0.55,
                                  height: dW * 0.55,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: dW * 0.04,
                                    vertical: dW * 0.04,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Your Request will be reviewed by our staff and responeded in 2 buisness days.',
                                        style: TextStyle(
                                            fontSize: 20 * tS,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.amber.shade800),
                                      ),
                                      const Spacer(),
                                      CustomAuthButton(
                                          onTap: () {
                                            requestContent.clear();
                                            fN.unfocus();
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          buttonLabel: 'OK')
                                    ],
                                  ),
                                ),
                              ));
                    }
                  },
                  buttonLabel: 'SEND'))
        ],
      ),
    );
  }
}
