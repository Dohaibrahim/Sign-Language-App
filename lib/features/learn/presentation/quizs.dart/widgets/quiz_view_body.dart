import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_lang_app/features/learn/data/models/question_response.dart';
import 'package:sign_lang_app/features/learn/data/models/question_response.dart' as model;
import 'package:sign_lang_app/features/learn/presentation/manager/fetch_question_cubit.dart/fetch_question_cubit.dart';
import 'package:sign_lang_app/features/learn/presentation/quizs.dart/widgets/quiz.dart';
import 'package:sign_lang_app/features/learn/presentation/quizs.dart/widgets/result.dart';
import 'package:sign_lang_app/features/learn/presentation/widgets/continue_button.dart';

class QuizViewBody extends StatefulWidget {
  const QuizViewBody({super.key, required this.levelId});
  final String levelId; // Store the levelId

  @override
  State<QuizViewBody> createState() => _QuizViewBodyState();
}

class _QuizViewBodyState extends State<QuizViewBody> {
  var _questionIndex = 0;
  var _totalScore = 0;
  int? _selectedAnswerIndex;
  bool _showFeedback = false;
  bool _showContinueButton = false; // Flag to show continue button

  @override
  void initState() {
    super.initState();
    context.read<FetchQuestionCubit>().fetchDictionaryList(widget.levelId);
  }

  void _answerQuestion(int score, int answerIndex) {
    setState(() {
      _selectedAnswerIndex = answerIndex;
      _showFeedback = true;

      if (score == 10) {
        _totalScore += score;
      }
    });
  }

void _checkForContinueButton(List<model.Question> questions) {
  if (_questionIndex < questions.length) {
    if (questions[_questionIndex].options.isEmpty || questions[_questionIndex].type == 'drag_drop') {
      _showContinueButton = true;  // Show "Continue" button for drag-drop questions
    } else {
      _showContinueButton = false; // Hide for other types
    }
  }
}

void _goToNextQuestion() {
  setState(() {
    _selectedAnswerIndex = null;
    _showFeedback = false;
    _questionIndex += 1;

    // Reset continue button visibility
    _showContinueButton = false;

    // Delay to ensure UI updates correctly
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {}); 
    });
  });
}



  void _resetQuiz() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _questionIndex = 0;
        _totalScore = 0;
        _showContinueButton = false; // Reset the continue button flag
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: BlocBuilder<FetchQuestionCubit, FetchQuestionState>(
            builder: (context, state) {
              if (state is FetchQuestionLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchQuestionFailure) {
                return Center(
                    child: Text(
                  'Error: ${state.errmessage}',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ));
              } else if (state is FetchQuestionSuccess) {
                final questions = state.questions;

                // Check for the continue button condition
                _checkForContinueButton(questions);

                return _questionIndex < questions.length
                    ? Column(
                        children: [
                          Quiz(
                            answerQuestion: (score, index) =>
                                _answerQuestion(score, index),
                            questionIndex: _questionIndex,
                            questions: questions,
                            selectedAnswerIndex: _selectedAnswerIndex,
                            showFeedback: _showFeedback,
                            onNextQuestion: _goToNextQuestion,
                          ),
                         
                        ],
                      )
                    : Result(_totalScore, _resetQuiz);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}