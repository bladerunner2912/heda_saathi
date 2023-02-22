import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/widgets/custom_button.dart';
import 'package:heda_saathi/featuresModule/providers/search_provider.dart';
import 'package:heda_saathi/featuresModule/screens/search_result_screen.dart';
import 'package:heda_saathi/featuresModule/widgets/search_field_label.dart';
import 'package:heda_saathi/featuresModule/widgets/search_form_field.dart';
import 'package:provider/provider.dart';

import '../../authModule/widgets/app_bar.dart';
import '../widgets/genreric_header.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController anniversary = TextEditingController();
  TextEditingController phone = TextEditingController();

  FocusNode nameNode = FocusNode();
  FocusNode genderNode = FocusNode();
  FocusNode placeNode = FocusNode();
  FocusNode professionNode = FocusNode();
  FocusNode dobNode = FocusNode();
  FocusNode anniversaryNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: customAppBar(dW),
      body: SearchScreenBody(
        dW: dW,
        tS: tS,
        name: name,
        nameNode: nameNode,
        genderNode: genderNode,
        gender: gender,
        placeNode: placeNode,
        place: place,
        professionNode: professionNode,
        profession: profession,
        dobNode: dobNode,
        dob: dob,
        anniversaryNode: anniversaryNode,
        anniversary: anniversary,
        phoneNode: phoneNode,
        phone: phone,
        formKey: formkey,
      ),
    );
  }
}

class SearchScreenBody extends StatefulWidget {
  const SearchScreenBody({
    Key? key,
    required this.dW,
    required this.tS,
    required this.name,
    required this.nameNode,
    required this.genderNode,
    required this.gender,
    required this.placeNode,
    required this.place,
    required this.professionNode,
    required this.profession,
    required this.dobNode,
    required this.dob,
    required this.anniversaryNode,
    required this.anniversary,
    required this.phoneNode,
    required this.phone,
    required this.formKey,
  }) : super(key: key);

  final double dW;
  final double tS;
  final TextEditingController name;
  final FocusNode nameNode;
  final FocusNode genderNode;
  final TextEditingController gender;
  final FocusNode placeNode;
  final TextEditingController place;
  final FocusNode professionNode;
  final TextEditingController profession;
  final FocusNode dobNode;
  final TextEditingController dob;
  final FocusNode anniversaryNode;
  final TextEditingController anniversary;
  final FocusNode phoneNode;
  final TextEditingController phone;
  final GlobalKey<FormState> formKey;

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  var _currentSelectedValue = 'Male';
  bool loading = false;
  final _genders = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Header(
                dW: widget.dW,
                tS: widget.tS,
                pageName: 'ABHMS SEARCH',
              ),
              SizedBox(
                height: widget.dW * 0.08,
              ),
              Form(
                key: widget.formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 8, horizontal: widget.dW * 0.07),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: widget.dW,
                        width: widget.dW * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SearchFieldLabel('NAME', widget.tS),
                            SearchFieldLabel('GENDER', widget.tS),
                            SearchFieldLabel('PLACE', widget.tS),
                            SearchFieldLabel('PROFESSION', widget.tS),
                            SearchFieldLabel('DATE OF BIRTH', widget.tS),
                            // SearchFieldLabel('ANNIVERSARY', widget.tS),
                            SearchFieldLabel('MOBILE NO.', widget.tS),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: widget.dW,
                        width: widget.dW * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SearchFormField(
                                hintText: '',
                                controller: widget.name,
                                tS: widget.tS,
                                node: widget.nameNode,
                                nextFocusNode: widget.genderNode),

                            FormField(builder: (FormFieldState<String> state) {
                              return DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                value: _currentSelectedValue,
                                isDense: true,
                                onChanged: (newValue)
                                    // =>
                                    {
                                  _currentSelectedValue = newValue!;
                                  state.didChange(newValue);
                                  setState(() {});
                                },
                                items: _genders.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ));
                            }),
                            // SearchFormField(
                            //   hintText: '',
                            //   controller: widget.gender,
                            //   tS: widget.tS,
                            //   node: widget.genderNode,
                            //   nextFocusNode: widget.placeNode,
                            // ),
                            SearchFormField(
                                hintText: 'CITY , STATE , ADDRESS',
                                controller: widget.place,
                                tS: widget.tS,
                                node: widget.placeNode,
                                nextFocusNode: widget.professionNode),
                            SearchFormField(
                              hintText: 'DOCTOR , LAWYER , TRADER',
                              controller: widget.profession,
                              tS: widget.tS,
                              node: widget.professionNode,
                              nextFocusNode: widget.dobNode,
                            ),
                            SearchFormField(
                                hintText: 'DD/MM/YYYY',
                                controller: widget.dob,
                                tS: widget.tS,
                                node: widget.dobNode,
                                isBirthAnniv: true,
                                nextFocusNode: widget.anniversaryNode),
                            // SearchFormField(
                            //   isBirthAnniv: true,
                            //     hintText: 'DD/MM/YYYY',
                            //     controller: widget.anniversary,
                            //     tS: widget.tS,
                            //     node: widget.anniversaryNode,
                            //     nextFocusNode: widget.phoneNode),
                            SearchFormField(
                              hintText: '9876543210',
                              controller: widget.phone,
                              tS: widget.tS,
                              node: widget.phoneNode,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: widget.dW * 0.15,
              ),
              CustomAuthButton(
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    Provider.of<SearchProvider>(context, listen: false).clear();
                    await Provider.of<SearchProvider>(context, listen: false)
                        .searchMember(
                      gender: _currentSelectedValue,
                      birth: DateTime.tryParse(widget.dob.text),
                      mobileNo: widget.phone.text,
                      name: widget.name.text,
                      place: widget.place.text,
                      profession: widget.profession.text,
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchResultScreen()));
                    loading = false;
                    setState(() {});
                  },
                  buttonLabel: 'SAATHI SEARCH'),
              const Spacer(),
              CustomAuthButton(
                  onTap: () {
                    widget.name.clear();
                    widget.place.clear();
                    _currentSelectedValue = _genders[0];
                    widget.profession.clear();
                    widget.dob.clear();
                    widget.phone.clear();
                    setState(() {});
                  },
                  buttonLabel: 'Clear Filters'),
              const Spacer(),
              const Spacer(),
            ],
          );
  }
}
