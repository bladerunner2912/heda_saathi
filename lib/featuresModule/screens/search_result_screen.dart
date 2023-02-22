import 'package:flutter/material.dart';
import 'package:heda_saathi/authModule/widgets/app_bar.dart';
import 'package:heda_saathi/homeModule/models/saathi_model.dart';
import 'package:heda_saathi/featuresModule/providers/search_provider.dart';
import 'package:heda_saathi/featuresModule/widgets/genreric_header.dart';
import 'package:heda_saathi/featuresModule/widgets/saathi_member_tile.dart';
import 'package:provider/provider.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  List<Saathi> searchedMembers = [];

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final dH = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;
    searchedMembers = Provider.of<SearchProvider>(context).searchedMembers;
    return Scaffold(
      appBar: customAppBar(dW),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(dW: dW, tS: tS, pageName: 'SEARCH RESULTS'),
          SizedBox(
            height: dW * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 12, bottom: 16),
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
                    physics: const BouncingScrollPhysics(),
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
                        SizedBox(height: dW * 0.4)
                      ],
                    )),
          )
        ],
      ),
    );
  }
}
