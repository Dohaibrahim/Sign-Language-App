import 'package:flutter/cupertino.dart';
import 'package:sign_lang_app/core/widgets/onboarding.dart';

class OnboardingPage1ViewBody extends StatelessWidget {
  const OnboardingPage1ViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Onboarding(
      imageUrl: 'assets/images/onboarding_person.png',
      title: 'AI-Powered Translation',
      subTitle:
          'Seamlessly translate sign language into text using cutting-edge AI. Communicate effortlessly with real-time accuracy.',
    );
  }
}
