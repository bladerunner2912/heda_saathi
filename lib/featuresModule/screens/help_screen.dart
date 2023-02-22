import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/widgets/custom_button.dart';
import 'package:heda_saathi/common_functions.dart';

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
  bool errorFlag = false;

  onSubmitAction(double dW, double tS) {
    if (requestContent.text.length > 10) {
      errorFlag = false;
      fN.unfocus();
      showDialogBox(
          context: context,
          dialogmessage:
              'Your Request has been submitted.Admin will soon post you up with a response.',
          buttonOne: 'OK',
          buttonOneFunction: () {
            Navigator.of(context).pop();
            fN.unfocus();
            requestContent.clear();
          },
          dW: dW,
          tS: tS);
    } else {
      setState(() {
        errorFlag = true;
      });
    }
  }

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
                TextFormField(
                  focusNode: fN,
                  onSaved: (_) {
                    (onSubmitAction(dW, tS));
                  },
                  onFieldSubmitted: (_) {
                    (onSubmitAction(dW, tS));
                  },
                  maxLength: 600,
                  maxLines: 10,
                  controller: requestContent,
                  style:
                      TextStyle(fontSize: 18 * tS, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow.shade900)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    contentPadding: const EdgeInsets.all(16),
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
                    onSubmitAction(dW, tS);
                  },
                  buttonLabel: 'SEND')),
          SizedBox(
            height: dW * 0.05,
          ),
          Visibility(
            visible: errorFlag,
            child: const Center(
              child: Text(
                'Your request content is too short.',
                style: TextStyle(color: Colors.red),
              ),
            ),
          )
        ],
      ),
    );
  }
}
