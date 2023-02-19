import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Header extends StatelessWidget {
  bool? extraButton;
  String? extraButtonName;
  final double dW;
  final double tS;
  final String pageName;
  VoidCallback? extraButtononTap;
  Header({
    super.key,
    this.extraButton = false,
    this.extraButtonName = '',
    required this.dW,
    required this.tS,
    required this.pageName,
    this.extraButtononTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffe5e9f0),
      padding:
          EdgeInsets.symmetric(vertical: dW * 0.022, horizontal: dW * 0.06),
      width: dW,
      child: extraButton!
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  pageName,
                  style: TextStyle(
                    fontSize: 20 * tS,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: extraButtononTap,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.8)),
                    padding: EdgeInsets.symmetric(
                        horizontal: dW * 0.015, vertical: dW * 0.015),
                    child: Center(
                      child: Text(extraButtonName!,
                          style: TextStyle(
                            fontSize: 14 * tS,
                          )),
                    ),
                  ),
                )
              ],
            )
          : Text(pageName,
              style: TextStyle(
                fontSize: 20 * tS,
              ),
              textAlign: TextAlign.center),
    );
  }
}
