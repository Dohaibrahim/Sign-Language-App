import 'package:flutter/material.dart';

class CommonWordsAnimations extends StatelessWidget {
  const CommonWordsAnimations({super.key, required this.videoUrl});
  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(videoUrl),
    );
  }
}
