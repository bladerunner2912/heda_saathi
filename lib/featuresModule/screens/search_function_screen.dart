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
  TextEditingController search = TextEditingController();

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
                        controller: search,
                        maxLines: 1,
                        onChanged: ((value) {
                          if (value.length > 2) {
                            error = false;
                          } else {
                            error = true;
                          }
                          setState(() {});
                        }),
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.red,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () => {search.clear(), setState(() {})},
                              child: const Icon(Icons.close),
                            ),
                            filled: true,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            hintText:
                                'Saathi name, phone, city, state, profession or pincode,',
                            fillColor: Colors.amber.shade400.withOpacity(0.2)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (error)
                        const Text(
                          "Please enter than two more characters.",
                          style: TextStyle(color: Colors.red),
                        ),
                      SizedBox(
                        height: dW * .5,
                      ),
                      elevatedButton(
                          width: dW * 0.4,
                          height: dW * 0.2,
                          label: 'Search Saathi',
                          buttonFunction: (() async {
                            if (search.text.length > 2) {
                              loading = true;
                              setState(() {});
                              Provider.of<SearchProvider>(context,
                                      listen: false)
                                  .clear();
                              await Provider.of<SearchProvider>(context,
                                      listen: false)
                                  .searchSaathi(search.text);
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
                      SizedBox(
                        height: dW * 0.2,
                      ),
                    ]),
                  ),
                ],
              ));
  }
}
