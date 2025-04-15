import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_lang_app/core/theming/styles.dart';
import 'package:sign_lang_app/core/utils/constants.dart';
import 'package:sign_lang_app/features/learn/data/models/question_response.dart' as model;
import 'package:sign_lang_app/features/learn/presentation/manager/score_tracker_cubit/score_tracker_cubit.dart';
import 'package:sign_lang_app/features/learn/presentation/quizs.dart/widgets/answer.dart';
import 'package:sign_lang_app/features/learn/presentation/widgets/continue_button.dart';
import 'package:sign_lang_app/features/learn/presentation/widgets/questions_tracker.dart';

class Question extends StatelessWidget {
  final String questionText;
  final String gifLink;

  const Question(this.questionText, this.gifLink, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.027,
        ),

        Image.network(
         gifLink.replaceFirst("http://localhost:3000", ApiUrls.baseURL),
          width: screenWidth * 0.90,
          height: screenHeight * 0.40,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: screenWidth * 0.90,
              height: screenHeight * 0.30,
              color: Colors.grey, // Placeholder color
              child: const Center(child: Text('Video not available')),
            );
          },
        ),
// Text(
//   gifLink,
//   style: TextStyles.font14DarkBlueMedium,
// ),
        Divider(
          height: 2,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          child: Text(
            questionText,
            style: TextStyles.font20WhiteSemiBold.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}




