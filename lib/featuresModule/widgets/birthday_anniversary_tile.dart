import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heda_saathi/homeModule/models/saathi_model.dart';
import 'package:heda_saathi/homeModule/screens/saathi_profile_screen.dart';
import 'package:intl/intl.dart';

class BirthdayAnnivesaryTile extends StatelessWidget {
  const BirthdayAnnivesaryTile({
    Key? key,
    required this.saathi,
    this.isTop = false,
    this.isAnniversary = false,
    this.isPrevious = false,
    required this.dW,
    required this.tS,
  }) : super(key: key);
  final bool isTop;
  final bool isAnniversary;
  final bool isPrevious;
  final double dW;
  final double tS;
  final Saathi saathi;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SaathiProfileScreen(
                      memeberId: saathi.userId,
                      birthDayFetch: true,
                    )));
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: dW * 0.22,
        margin: EdgeInsets.only(
            top: dW * (isTop ? 0.025 : 0.01), bottom: dW * 0.01),
        decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12)),
        width: dW,
        child: Row(
          children: [
            Container(
              width: dW * 0.23,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: FadeInImage.assetNetwork(
                width: dW * 0.23,
                image: saathi.avatar!,
                placeholder: saathi.gender == 'Male'
                    ? 'assets/images/menProfile.jpg'
                    : 'assets/images/womenProfile.png',
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: dW * 0.23,
                    color: Colors.white,
                    padding: saathi.gender == 'Male'
                        ? const EdgeInsets.all(0)
                        : EdgeInsets.symmetric(
                            horizontal: dW * 0.0265,
                          ),
                    child: Image.asset(
                      saathi.gender == 'Male'
                          ? 'assets/images/menProfile.jpg'
                          : 'assets/images/womenProfile2.png',
                      fit: BoxFit.fitHeight,
                    ),
                  );
                },
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: dW * 0.02, top: dW * 0.03),
              width: dW * 0.46,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    saathi.name,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: Colors.orange.shade900,
                      fontSize: 21 * tS,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: dW * 0.015,
                  ),
                  Text(
                    isPrevious
                        ? DateFormat('dd MMMM').format(saathi.dob)
                        : 'Send wishes to ${saathi.name} on the ocassion of his ${!isAnniversary ? 'birthday' : 'anniversary'}',
                    maxLines: 2,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight:
                          isPrevious ? FontWeight.w800 : FontWeight.w500,
                      fontSize: tS * (isPrevious ? 16 : 12),
                      color: isPrevious ? Colors.black : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: dW * 0.23,
              decoration: BoxDecoration(
                  color: Colors.pinkAccent.shade100.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              padding: EdgeInsets.all(dW * 0.04),
              child: SvgPicture.asset(
                "assets/svgIcons/${!isAnniversary ? 'birthday' : 'anniversary'}.svg",
                width: dW * 0.14,
                height: dW * 0.14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
