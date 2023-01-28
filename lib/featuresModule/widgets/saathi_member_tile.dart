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
        width: dW,
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
            SizedBox(
              height: dW * 0.22,
              width: dW * 0.22,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12))),
                width: dW * 0.22,
                child: FadeInImage(
                  width: dW * 0.22,
                  image: Image.network(
                    saathi.avatar ?? '',
                    fit: BoxFit.cover,
                  ).image,
                  placeholder: AssetImage(''),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: dW * 0.22,
                      width: dW * 0.22,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12)),
                          image: DecorationImage(
                              image: Image.asset(
                            saathi.gender == 'Male'
                                ? 'assets/images/menProfile.jpg'
                                : 'assets/images/womenProfile2.png',
                          ).image)),
                    );

                    //  Container(
                    //   decoration: const BoxDecoration(
                    //       borderRadius: BorderRadius.only(
                    //           topLeft: Radius.circular(12),
                    //           bottomLeft: Radius.circular(12))),
                    //   padding: saathi.gender == 'Male'
                    //       ? const EdgeInsets.all(0)
                    //       : EdgeInsets.symmetric(
                    //           horizontal: dW * 0.0265,
                    //         ),
                    //   width: dW * 0.22,
                    //   height: dW * 0.22,
                    //   child: Image.asset(
                    //     saathi.gender == 'Male'
                    //         ? 'assets/images/menProfile.jpg'
                    //         : 'assets/images/womenProfile2.png',
                    //   ),
                    // );
                  },
                  fit: BoxFit.contain,
                ),
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
                    saathi.place,
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
