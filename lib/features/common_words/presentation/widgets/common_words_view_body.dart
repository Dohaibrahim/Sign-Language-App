import 'package:flutter/material.dart';
import 'package:sign_lang_app/core/utils/extentions.dart';
import 'package:sign_lang_app/features/common_words/presentation/widgets/common_words_animation.dart';
import 'package:sign_lang_app/features/learn/presentation/quizs.dart/avatar_sign_before_quiz_view.dart';
import 'package:sign_lang_app/features/learn/presentation/widgets/continue_button.dart';

class CommonWordsViewBody extends StatefulWidget {
  const CommonWordsViewBody({super.key, required this.arguments});
  final Map? arguments;
  @override
  State<CommonWordsViewBody> createState() => _CommonWordsViewBodyState();
}

class _CommonWordsViewBodyState extends State<CommonWordsViewBody> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.25),
        //const CustomRefreshBtn(),
        CommonWordsAnimations(
          videoUrl: widget.arguments?['fileName'],
        ),
        SignName(name: widget.arguments?['text']),
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: ContinueButton(
                text: 'Done',
                onPressed: () {
                  context.pop();
                },
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.05),
      ],
    );
  }
}
