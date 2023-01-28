import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:heda_saathi/authModule/providers/auth_provider.dart';
import 'package:heda_saathi/authModule/widgets/app_bar.dart';
import 'package:heda_saathi/homeModule/models/saathi_model.dart';
import 'package:heda_saathi/featuresModule/providers/search_provider.dart';
import 'package:heda_saathi/featuresModule/widgets/genreric_header.dart';
import 'package:heda_saathi/featuresModule/widgets/saathi_member_tile.dart';
import 'package:provider/provider.dart';

import '../../authModule/models/user_modal.dart';

class SearchResultScreen extends StatefulWidget {
  final String gender;
  String? name;
  String? place;
  String? profession;
  String? mobileNo;
  DateTime? birth;

  SearchResultScreen(
      {required this.gender,
      this.birth,
      this.name,
      this.place,
      this.profession,
      this.mobileNo,
      super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  List<Saathi> searchedMembers = [];
  bool loaded = false;

  myInit() async {
    await Provider.of<SearchProvider>(context).searchMember(
        gender: widget.gender,
        birth: widget.birth,
        name: widget.name,
        place: widget.place,
        mobileNo: widget.mobileNo,
        profession: widget.profession);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //previous serach results are cleared
    Provider.of<SearchProvider>(context, listen: false).clear();
    
      }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!loaded) {
      myInit();
      loaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final dH = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;
    searchedMembers = Provider.of<SearchProvider>(context).searchedMembers;
    return Scaffold(
      appBar: customAppBar(dW),
      body: !loaded
          ? Container(
              width: dW,
              height: dH,
              color: Colors.grey.shade100.withOpacity(0.9),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                  strokeWidth: 1,
                ),
              ),)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(dW: dW, tS: tS, pageName: 'SEARCH RESULTS'),
                SizedBox(
                  height: dW * 0.01,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, top: 12, bottom: 16),
                  child: Text(
                    'Results based on filter : ${searchedMembers.length}',
                    style: TextStyle(fontSize: 18 * tS),
                  ),
                ),
                SizedBox(
                  width: dW,
                  height: searchedMembers.isEmpty ? dH * 0.5 : dH * 0.74,
                  child: searchedMembers.isEmpty
                      ? Center(
                          child: Text(
                            'No Heda Saathi found based on your filters',
                            style: TextStyle(
                              fontSize: 16 * tS,
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: dW * 0.04),
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: searchedMembers.isEmpty
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.start,
                            children: [
                              ...List.generate(
                                searchedMembers.length,
                                (index) => SearchScreenTile(
                                  dW: dW,
                                  tS: tS,
                                  saathi: searchedMembers[index],
                                  isFirst: index == 0 ? true : false,
                                ),
                              ),
                            ],
                          )),
                )
              ],
            ),
    );
  }
}
