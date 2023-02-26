import 'package:flutter/material.dart';
import 'package:heda_saathi/homeModule/models/saathi_model.dart';
import 'package:heda_saathi/homeModule/screens/saathi_profile_screen.dart';

class SearchScreenTile extends StatelessWidget {
  final Saathi saathi;
  final double dW;
  final double tS;
  final bool isFirst;
  const SearchScreenTile({
    super.key,
    required this.saathi,
    required this.dW,
    required this.tS,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SaathiProfileScreen(memeberId: saathi.userId)),
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: dW,
        height: dW * 0.23,
        margin: EdgeInsets.only(
          top: dW * (isFirst ? 0.02 : 0.035),
        ),
        decoration: BoxDecoration(
          color: Colors.amberAccent.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              width: dW * 0.23,
              height: dW * 0.23,
              decoration: BoxDecoration(
                color: Colors.cyan.shade100,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: FadeInImage.assetNetwork(
                width: dW * 0.23,
                height: dW * 0.23,
                image: saathi.avatar!,
                placeholder: saathi.gender == 'Male'
                    ? 'assets/images/indian_men.png'
                    : 'assets/images/indian_women.png',
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: dW * 0.23,
                    height: dW * 0.23,
                    color: Colors.cyan.shade100,
                    child: Image.asset(
                      saathi.gender == 'Male'
                          ? 'assets/images/indian_men.png'
                          : 'assets/images/indian_women.png',
                      fit: BoxFit.fitHeight,
                    ),
                  );
                },
                fit: BoxFit.fitHeight,
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: dW * 0.02),
              width: dW * 0.6,
              height: dW * 0.18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    saathi.name,
                    style: TextStyle(
                      fontSize: tS * 22,
                      color: Colors.red,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${saathi.city}, ${saathi.state} - ${saathi.pincode}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
