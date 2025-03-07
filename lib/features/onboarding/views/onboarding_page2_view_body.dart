import 'package:flutter/material.dart';
import 'package:sign_lang_app/core/widgets/onboarding.dart';

class OnboardingPage2ViewBody extends StatelessWidget {
  const OnboardingPage2ViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Onboarding(
        imageUrl: isDark
            ? 'assets/images/onboarding2.png'
            : 'assets/images/Frame 247.png',
        title: 'Interactive Learning',
        subTitle:
            'Learn sign language step by step through units and levels, answer questions, and earn points as you progress.');
  }
}
