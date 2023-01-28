import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class BirthdayAnnivesaryTile extends StatelessWidget {
  BirthdayAnnivesaryTile({
    Key? key,
    this.isTop = false,
    this.isAnniversary = false,
    this.isPrevious = false,
    required this.dW,
    required this.tS,
  }) : super(key: key);
  bool? isTop;
  bool? isAnniversary;
  bool? isPrevious;
  final double dW;
  final double tS;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: dW * (isTop! ? 0.025 : 0.01), bottom: dW * 0.01),
      decoration: BoxDecoration(
          color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12)),
      width: dW,
      child: Row(
        children: [
          Container(
            height: dW * 0.22,
            width: dW * 0.22,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                image: DecorationImage(
                    image: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC8KYj8Qss8L7Lx9LxadvSu9nNfHdfqLsuJQ&usqp=CAU',
                  fit: BoxFit.cover,
                ).image)),
          ),
          Container(
            padding: EdgeInsets.only(left: dW * 0.02, top: dW * 0.03),
            width: dW * 0.46,
            height: dW * 0.22,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Yash Heda',
                  style: TextStyle(
                    color: Colors.orange.shade900,
                    fontSize: 24 * tS,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: dW * 0.015,
                ),
                Text(
                 isPrevious!? DateFormat('dd MMMM').format(DateTime.now())  :'Send wishes to Yash on the ocassion of his ${!isAnniversary! ? 'birthday' : 'anniversary'}',
                  style: TextStyle(
                    fontWeight: isPrevious!? FontWeight.w800 :FontWeight.w500,
                    fontSize:  tS * (isPrevious!? 16 : 12),
                    color: isPrevious!? Colors.black : Colors.black,
                    
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: dW * 0.24,
            decoration: BoxDecoration(
                color: Colors.pinkAccent.shade100.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            padding: EdgeInsets.all(dW * 0.04),
            child: SvgPicture.asset(
              "assets/svgIcons/${!isAnniversary! ? 'birthday' : 'anniversary'}.svg",
              width: dW * 0.14,
              height: dW * 0.14,
            ),
          )
        ],
      ),
    );
  }
}
