import 'package:flutter/material.dart';
import 'package:sign_lang_app/core/widgets/custom_background_color.dart';
import 'package:sign_lang_app/features/translation/presentation/widgets/before_translation_view_body.dart';

class BeforeTranslationView extends StatelessWidget {
  const BeforeTranslationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomStack(child: SafeArea(child: BeforeTranslationViewBody())),
    );
  }
}
