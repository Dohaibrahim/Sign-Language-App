import 'package:flutter/material.dart';
import 'package:sign_lang_app/core/theming/styles.dart';

class BeforeTranslationViewBody extends StatelessWidget {
  const BeforeTranslationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Image.asset(
              "assets/images/before_translation_icon.png",
              height: screenHeight * 0.40,
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Text(
              'Tips to Take a good Video ',
              style: TextStyles.font24PrimarySemibold
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            BuildText(
              text:
                  'Focus on your hands and facial expressions for better translation ',
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            BuildText(
              text: 'steady camera',
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            BuildText(
              text: 'clear background',
            ),
          ],
        ),
      ),
    );
  }
}

class BuildText extends StatelessWidget {
  const BuildText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: CircleAvatar(
            radius: 5,
            backgroundColor: Colors.white,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
