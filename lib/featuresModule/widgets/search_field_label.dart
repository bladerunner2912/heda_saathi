import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchFieldLabel extends StatelessWidget {
  final String labelName;
  final double tS;
  const SearchFieldLabel( this.labelName, this.tS, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      labelName,
      style: TextStyle(fontSize: tS * 16, fontWeight: FontWeight.w400),
    );
  }
}
