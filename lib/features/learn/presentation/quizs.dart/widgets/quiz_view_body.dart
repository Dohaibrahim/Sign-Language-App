import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_lang_app/features/learn/data/models/question_response.dart' as model;
import 'package:sign_lang_app/features/learn/presentation/manager/fetch_question_cubit.dart/fetch_question_cubit.dart';
import 'package:sign_lang_app/features/learn/presentation/quizs.dart/widgets/quiz.dart';
import 'package:sign_lang_app/features/learn/presentation/quizs.dart/widgets/result.dart';

class QuizViewBody extends StatefulWidget {
  const QuizViewBody({super.key, required this.levelId});
  final String levelId;

  @override
  State<QuizViewBody> createState() => _QuizViewBodyState();
}

class _QuizViewBodyState extends State<QuizViewBody> {
  var _questionIndex = 0;
  var _totalScore = 0;
  int? _selectedAnswerIndex;
  bool _showFeedback = false;
  bool _isRetryMode = false;
  List<model.Question> incorrectQuestions = [];
  List<model.Question> originalQuestions = []; // Store original questions
  List<model.Question> currentQuestions = []; // Use this list dynamically

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
      } else {
        // Only add unique incorrect questions
        if (!incorrectQuestions.contains(currentQuestions[_questionIndex])) {
          incorrectQuestions.add(currentQuestions[_questionIndex]);
        }
      }
    });
  }

  void _goToNextQuestion() {
    setState(() {
      _selectedAnswerIndex = null;
      _showFeedback = false;

      if (_questionIndex < currentQuestions.length - 1) {
        _questionIndex++;
      } else if (!_isRetryMode && incorrectQuestions.isNotEmpty) {
        // If first attempt ends and mistakes exist, retry only those
        currentQuestions = List.from(incorrectQuestions);
        incorrectQuestions.clear();
        _questionIndex = 0;
        _isRetryMode = true;
      } else {
        // If there are no more incorrect questions, end the quiz
        _isRetryMode = false;
        _questionIndex = currentQuestions.length; // This ensures Result() is shown
      }
    });
  }

  void _resetQuiz() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _questionIndex = 0;
        _totalScore = 0;
        incorrectQuestions.clear();
        _isRetryMode = false;
        currentQuestions = List.from(originalQuestions); // Restore original questions
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
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                );
              } else if (state is FetchQuestionSuccess) {
                if (originalQuestions.isEmpty) {
                  originalQuestions = state.questions;
                  currentQuestions = List.from(originalQuestions);
                }

                return Column(
                  children: [
                    if (_isRetryMode) // Show message when retrying mistaken questions
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "These are the questions you answered incorrectly. Try again!",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    _questionIndex < currentQuestions.length
                        ? Quiz(
                            answerQuestion: _answerQuestion,
                            questionIndex: _questionIndex,
                            questions: currentQuestions,
                            selectedAnswerIndex: _selectedAnswerIndex,
                            showFeedback: _showFeedback,
                            onNextQuestion: _goToNextQuestion,

                          )
                        : Result(_totalScore, _resetQuiz),
                  ],
                );

              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
