import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/widgets/app_bar.dart';
import 'package:heda_saathi/common_functions.dart';
import 'package:heda_saathi/featuresModule/providers/search_provider.dart';
import 'package:heda_saathi/featuresModule/screens/search_result_screen.dart';
import 'package:heda_saathi/featuresModule/widgets/genreric_header.dart';
import 'package:provider/provider.dart';

class SearchFunctionScreen extends StatefulWidget {
  const SearchFunctionScreen({super.key});

  @override
  State<SearchFunctionScreen> createState() => _SearchFunctionScreenState();
}

class _SearchFunctionScreenState extends State<SearchFunctionScreen> {
  bool error = false;
  bool loading = false;
  TextEditingController name = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController profession = TextEditingController();

  errorGauge() {
    if (name.text.length > 2 ||
        place.text.length > 2 ||
        phone.text.length > 2 ||
        profession.text.length > 2) {
      setState(() {
        error = false;
      });
    } else {
      setState(() {
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: customAppBar(dW),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Header(dW: dW, tS: tS, pageName: "Search Saathi"),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: dW * 0.04),
                    height: dW * 1.56,
                    child: Column(children: [
                      SizedBox(
                        height: dW * 0.04,
                      ),
                      TextFormField(
                        cursorColor: Colors.red,
                        controller: name,
                        maxLines: 1,
                        onChanged: (_) => {errorGauge()},
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.red,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () => {name.clear(), setState(() {})},
                              child: const Icon(Icons.close),
                            ),
                            filled: true,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            hintText: 'Name',
                            fillColor: Colors.amber.shade400.withOpacity(0.2)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        cursorColor: Colors.red,
                        controller: phone,
                        maxLines: 1,
                        onChanged: (_) {
                          errorGauge();
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: Colors.red,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () => {phone.clear(), setState(() {})},
                              child: const Icon(Icons.close),
                            ),
                            filled: true,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            hintText: 'Phone  - 9284480539',
                            fillColor: Colors.amber.shade400.withOpacity(0.2)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        cursorColor: Colors.red,
                        controller: place,
                        maxLines: 1,
                        onChanged: (_) {
                          errorGauge();
                        },
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.place,
                              color: Colors.red,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () => {place.clear(), setState(() {})},
                              child: const Icon(Icons.close),
                            ),
                            filled: true,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            hintText: 'City, state, pincode,',
                            fillColor: Colors.amber.shade400.withOpacity(0.2)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        cursorColor: Colors.red,
                        controller: profession,
                        maxLines: 1,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.work,
                              color: Colors.red,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () =>
                                  {profession.clear(), setState(() {})},
                              child: const Icon(Icons.close),
                            ),
                            filled: true,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            hintText: 'Profession - Trader , Doctor , Engineer',
                            fillColor: Colors.amber.shade400.withOpacity(0.2)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      if (error)
                        const Text(
                          "Atleast one field must be 3 charachters long",
                          style: TextStyle(color: Colors.red),
                        ),
                      const Spacer(),
                      const Spacer(),
                      const Spacer(),
                      const Spacer(),
                      const Spacer(),
                      elevatedButton(
                          width: dW * 0.4,
                          height: dW * 0.1,
                          label: 'Search Saathi',
                          buttonFunction: (() async {
                            if (name.text.length > 2 ||
                                place.text.length > 2 ||
                                phone.text.length > 2 ||
                                profession.text.length > 2) {
                              loading = true;
                              setState(() {});
                              Provider.of<SearchProvider>(context,
                                      listen: false)
                                  .clear();
                              await Provider.of<SearchProvider>(context,
                                      listen: false)
                                  .searchSaathi(
                                      name: name.text,
                                      place: place.text,
                                      profession: profession.text,
                                      phone: phone.text);
                              loading = false;
                              setState(() {});
                              if (mounted) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchResultScreen()));
                              }
                            } else {
                              setState(() {
                                error = true;
                              });
                            }
                          })),
                      const Spacer(),
                    ]),
                  ),
                ],
              ));
  }
}
