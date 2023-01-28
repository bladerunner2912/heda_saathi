import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


class Header extends StatelessWidget {
  bool? chatSection;
  final double dW;
  final double tS;
  final String pageName;
  VoidCallback? onTap;
  Header({
    super.key,
    this.chatSection = false,
    required this.dW,
    required this.tS,
    required this.pageName, 
    this.onTap ,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffe5e9f0),
      padding:
          EdgeInsets.symmetric(vertical: dW * 0.022, horizontal: dW * 0.06),
      width: dW,
      child: chatSection!
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pageName,
                  style: TextStyle(
                    fontSize: 20 * tS,
                  ),
                ),
                GestureDetector(
                  onTap: (() => onTap),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.8)),
                    padding: EdgeInsets.symmetric(
                        horizontal: dW * 0.015, vertical: dW * 0.015),
                    child: Center(
                      child: Text('CONNECT',
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
