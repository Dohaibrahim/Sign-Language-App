import 'package:flutter/material.dart';

import 'avatar_with_txt.dart';
import 'continue_button.dart';
import 'custom_listile.dart';

class Achievement1 extends StatelessWidget {
  const Achievement1({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            AvatarWithTxt(
              imagePath: "assets/images/static_point_up1.png",
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              text: "Here's what you can achieve!",
            ),
            Divider(
              height: 0,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            const CustomListile(
                imageUrl: 'assets/images/conversation.png',
                title: 'Learn with confidence',
                subtitle: 'Discover fun and interactive ways to practice.'),
            Divider(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            const CustomListile(
                imageUrl: 'assets/images/a.png',
                title: 'Expand your vocabulary',
                subtitle:
                    'Learn practical words and phrases for everyday use.'),
            Divider(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            const CustomListile(
                imageUrl: 'assets/images/watch.png',
                title: 'Build a consistent habit',
                subtitle: 'Enjoy engaging challenges to stay motivated.'),
            SizedBox(
              height: screenHeight * 0.050,
            ),
            ContinueButton(
              text: "Continue",
              onPressed: onPressed,
            )
          ]),
    );
  }
}
