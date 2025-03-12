import 'package:flutter/material.dart';
import 'package:sign_lang_app/core/utils/constants.dart';
import 'package:sign_lang_app/features/learn/data/models/question_response.dart' as model;
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
    correctWords = widget.question.options
        .where((option) => option.score == 10)
        .map((option) => option.text)
        .toList();

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
      // Ensure all slots are filled before checking the answer
      if (!droppedWords.contains(null)) {
        List<String> filledWords = droppedWords.whereType<String>().toList();
        isCorrect = List.from(filledWords).join() == correctWords.join();
        showFeedback = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

         Row(
          children: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Theme.of(context).colorScheme.primaryContainer,
                )),
            QuestionsTracker(totalQ: widget.question.options.length),
          ],
        ),
Question(

    widget.question.question,
      widget.question.signUrl

),


        // Drop targets for correct words
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(correctWords.length, (index) {
            return DragTarget<String>(
              key: ValueKey(index), // Unique key for each target
              onWillAccept: (word) => true, // Accept any word
              onAccept: (word) {
                setState(() {
                  if (droppedWords[index] != null) {
                    choices.add(droppedWords[index]!); // Return previous word to choices
                  }
                  droppedWords[index] = word;
                  choices.remove(word);
                  checkAnswer();
                });
              },
              builder: (context, candidateData, rejectedData) {
                bool isFilled = droppedWords[index] != null;
                bool isCorrectWord = correctWords[index] == droppedWords[index];
                Color borderColor = isFilled ? (isCorrectWord ? Colors.green : Colors.red) : Colors.grey;

                return Container(
                  width: 100,
                  height: 50,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isFilled ? Colors.white : Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: borderColor, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    droppedWords[index] ?? "Drop here",
                    style: TextStyle(fontSize: 18, color: isFilled ? Colors.black : Colors.grey[700]),
                  ),
                );
              },
            );
          }),
        ),

        SizedBox(height: 50),

        // Choices to drag
        Wrap(
          spacing: 10,
          children: choices.map((word) {
            return Draggable<String>(
              data: word,
              child: Chip(
                label: Text(word),
                backgroundColor: Colors.blueAccent,
              ),
              feedback: Material(
                color: Colors.transparent,
                child: Chip(
                  label: Text(word),
                  backgroundColor: Colors.blueAccent,
                ),
              ),
              childWhenDragging: Chip(
                label: Text(word),
                backgroundColor: Colors.grey,
              ),
            );
          }).toList(),
        ),

        // Continue Button (only if all slots are filled and feedback is shown)
        if (showFeedback && !droppedWords.contains(null))
          ContinueButton(text: 'Continue', onPressed: widget.onNextQuestion),
      ],
    );
  }
}
