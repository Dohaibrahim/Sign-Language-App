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

class DragDropQuestionItem extends StatelessWidget {
  final String gifLink;

  const DragDropQuestionItem(this.gifLink, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(height: screenHeight * 0.05),

        Image.network(
          gifLink.replaceFirst("http://localhost:3000", ApiUrls.baseURL),
          width: screenWidth * 0.90,
          height: screenHeight * 0.25,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: screenWidth * 0.90,
              height: screenHeight * 0.1,
              color: Colors.grey,
              child: Center(
                child: Text(gifLink.replaceFirst("http://localhost:3000", ApiUrls.baseURL)),
              ),
            );
          },
        ),
      ],
    );
  }
}
