import 'package:flutter/cupertino.dart';
import 'package:sign_lang_app/core/widgets/onboarding.dart';

class OnboardingPage3ViewBody extends StatelessWidget {
  const OnboardingPage3ViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Onboarding(
        imageUrl: 'assets/images/onboarding3.png',
        title: 'Sign Language Dictionary',
        subTitle:
            'Access a curated dictionary of signs. Look up words for accurate translations and better understanding.');
  }
}
