import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../manager/score_tracker_cubit/score_tracker_cubit.dart';

class QuestionsTracker extends StatelessWidget {
  const QuestionsTracker({super.key, required this.totalQ});
  final int totalQ;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreTrackerCubit, int>(
      builder: (context, progress) {
        double progressPercent = totalQ > 0 ? (progress / totalQ).clamp(0.0, 1.0) : 0.0;
        return LinearPercentIndicator(
          animateFromLastPercent: true,
          barRadius: const Radius.circular(13),
          animationDuration: 1000,
          animation: true,
          width: MediaQuery.of(context).size.width * 0.85,
          lineHeight: 25,
          percent: progressPercent, // Safe value
          progressColor: const Color(0xff58CC02),
          backgroundColor: Colors.white,
        );
      },
    );
  }
}
