import 'package:flutter/material.dart';
import 'dart:math';

import '../models/saathi_model.dart';

class FamilyWidget extends StatelessWidget {
  final double dW;
  final double tS;
  final Saathi saathi;
  final bool first;
  final bool last;
  const FamilyWidget({
    required this.dW,
    required this.tS,
    super.key,
    required this.saathi,
    this.first = false,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color:
            Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2),
      ),
      margin: EdgeInsets.only(
          left: first ? dW * 0.035 : dW * 0.02,
          right: dW * (last ? 0.035 : 0.02)),
      padding: EdgeInsets.only(
          bottom: dW * 0.005,
          left: dW * 0.06,
          right: dW * 0.06,
          top: dW * 0.04),
      width: dW * 0.42,
      height: dW * 0.5,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: dW * 0.12,
          child: FittedBox(
            clipBehavior: Clip.hardEdge,
            child: FadeInImage(
              height: dW * 0.27,
              width: dW * 0.27,
              image: Image.network(saathi.avatar!).image,
              placeholder: AssetImage(saathi.gender == 'Male'
                  ? 'assets/images/indian_men.png'
                  : 'assets/images/indian_women.png'),
              imageErrorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.white,
                  padding: saathi.gender == 'Male'
                      ? const EdgeInsets.all(0)
                      : EdgeInsets.symmetric(
                          horizontal: dW * 0.0265,
                        ),
                  width: dW * 0.27,
                  height: dW * 0.27,
                  child: Image.asset(
                    saathi.gender == 'Male'
                        ? 'assets/images/indian_men.png'
                        : 'assets/images/indian_women.png',
                  ),
                );
              },
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        const Spacer(),
        const Spacer(),
        SizedBox(
          child: Text(
            saathi.name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontSize: 18 * tS,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Spacer(),
        const Spacer(),
        Text(
          saathi.relation!,
          style: TextStyle(fontSize: 14 * tS, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        const Spacer(),
      ]),
    );
  }
}
