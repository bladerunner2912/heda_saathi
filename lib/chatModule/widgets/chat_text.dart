import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatText extends StatefulWidget {
  final double dW;
  final double tS;
  final String chatText;
  final String dateTime;
  final bool isDelieverd;
  final bool byUser;

  const ChatText({
    super.key,
    required this.dW,
    required this.tS,
    required this.chatText,
    required this.dateTime,
    required this.isDelieverd,
    required this.byUser,
  });

  @override
  State<ChatText> createState() => _ChatTextState();
}

class _ChatTextState extends State<ChatText> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.byUser?Alignment.centerRight:Alignment.centerLeft,
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: widget.dW * 0.85,
            minWidth: 24,
          ),
          child: Stack(
            children: [
              Container(
                // ignore: prefer_const_constructors
                margin: EdgeInsets.symmetric(
                    horizontal: 5,vertical :  4),
                decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    color: widget.byUser? const Color.fromARGB(247, 254, 228, 126)
                        : Colors.white ),
                padding:  EdgeInsets.only(
                    left: 10, right: widget.chatText.length < 10 ? 50 : 10 , top: 6, bottom: 12),
                child: Text(
                  widget.chatText,
                  style: TextStyle(
                    fontSize: 19 * widget.tS,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Positioned(
                  bottom: 4,
                  right: 6,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.dateTime,style: const TextStyle(fontSize: 10),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                  widget.byUser?    Icon(
                        Icons.check,
                        color: widget.isDelieverd ? Colors.red : Colors.white,
                      ) : SizedBox.shrink()
                    ],
                  ))
            ],
          )
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
    
          //   SizedBox(width: widget.dW * 0.05,),
          //   SizedBox(
          //     height: widget.dW * 0.07,
          //     width: widget.dW * 0.12,
          //     child: Column(
          //       children: [
          //       const Spacer(),
          //         Row(
          //           crossAxisAlignment: CrossAxisAlignment.end,
          //           children: [
          //             Text(widget.dateTime,style: TextStyle(fontSize: 10 * widget.tS),),
          //             const Spacer(),
          //             Icon(
          //               Icons.check,
          //               size: widget.dW * 0.05,
          //               color: widget.isDelieverd ? Colors.redAccent : Colors.white,
          //             )
          //           ],
          //         ),
          //       ],
          //     ),
          //   )
          // ]),
          ),
    );
  }
}
