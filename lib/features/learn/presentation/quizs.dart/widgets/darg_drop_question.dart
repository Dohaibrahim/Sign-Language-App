import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:sign_lang_app/core/theming/colors.dart';
import 'package:sign_lang_app/core/theming/styles.dart';
import 'package:sign_lang_app/features/learn/data/models/question_response.dart' as model;
import 'package:sign_lang_app/features/learn/presentation/quizs.dart/widgets/draf_drop_question_item.dart';
import 'package:sign_lang_app/features/learn/presentation/quizs.dart/widgets/question.dart';
import 'package:sign_lang_app/features/learn/presentation/widgets/continue_button.dart';
import 'package:sign_lang_app/features/learn/presentation/widgets/questions_tracker.dart';

class DragDropQuestion extends StatefulWidget {
  final model.Question question;
  final VoidCallback onNextQuestion;

  const DragDropQuestion({super.key, required this.question, required this.onNextQuestion});

  @override
  _DragDropQuestionState createState() => _DragDropQuestionState();
}

class _DragDropQuestionState extends State<DragDropQuestion> {
  late List<String> correctWords;
  late List<String?> droppedWords;
  late List<String> choices;
  bool showFeedback = false;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    _initializeQuestion();
  }

  void _initializeQuestion() {
    correctWords = widget.question.correctOptions;
    droppedWords = List.filled(correctWords.length, null);
    choices = widget.question.options.map((option) => option.text).toList();
  }

  @override
  void didUpdateWidget(DragDropQuestion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      _resetState();
    }
  }

  void _resetState() {
    setState(() {
      droppedWords = List.filled(correctWords.length, null);
      choices = widget.question.options.map((option) => option.text).toList();
      showFeedback = false;
      isCorrect = false;
    });
  }

  void checkAnswer() {
    setState(() {
      if (!droppedWords.contains(null)) {
        List<String> filledWords = droppedWords.whereType<String>().toList();
        isCorrect = List.from(filledWords).join() == correctWords.join();
        showFeedback = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
              QuestionsTracker(totalQ: widget.question.options.length),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: List.generate(correctWords.length, (index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: DragDropQuestionItem(
                        widget.question.signUrls[index],
                      ),
                    ),
                    DragTarget<String>(
                      key: ValueKey('${widget.question.id}-$index'),
                      onWillAccept: (word) => true,
                      onAccept: (word) {
                        setState(() {
                          if (droppedWords[index] != null) {
                            choices.add(droppedWords[index]!);
                          }
                          droppedWords[index] = word;
                          choices.remove(word);
                          checkAnswer();
                        });
                      },
                      builder: (context, candidateData, rejectedData) {
                        bool isFilled = droppedWords[index] != null;
                        bool isCorrectWord = correctWords[index] == droppedWords[index];
                        return Container(
                          width: 110,
                          height: 50,
                          margin: EdgeInsets.all(10),
                          child: DottedBorder(
                            color: Colors.grey,
                            strokeWidth: 2,
                            dashPattern: [6, 3],
                            borderType: BorderType.RRect,
                            radius: Radius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isFilled 
                                    ? (isCorrectWord ? ColorsManager.green : Colors.red.withOpacity(0.5)) 
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                droppedWords[index] ?? "Drop here",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: isFilled ? Colors.white : Colors.grey[700],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }),
            ),
          ),
          SizedBox(height: 50),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: choices.map((word) {
              return Draggable<String>(
                data: word,
                child: Chip(
                  label: Text(word, style: TextStyles.font16WhiteMedium),
                  backgroundColor: Colors.blueGrey,
                ),
                feedback: Material(
                  color: Colors.transparent,
                  child: Chip(
                    label: Text(word, style: TextStyles.font15BlackMedium),
                    backgroundColor: Colors.grey,
                  ),
                ),
                childWhenDragging: Chip(
                  label: Text(word),
                  backgroundColor: Colors.grey,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 50),
          if (showFeedback && !droppedWords.contains(null))
            ContinueButton(text: 'Continue', onPressed: widget.onNextQuestion),
        ],
      ),
    );
  }
}
