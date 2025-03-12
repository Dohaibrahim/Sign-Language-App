import 'package:flutter/material.dart';
import 'package:sign_lang_app/core/theming/styles.dart';

import '../routing/routes.dart';

class BuildsHeader extends StatelessWidget {
  const BuildsHeader({super.key, required this.title, required this.seeAllVisible});
final String title;
final bool seeAllVisible ;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
         title,
          style: TextStyles.font20WhiteSemiBold
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.dictionaryScreen);
            },
            child: Text(
              seeAllVisible ? 'See All' : '',
              style: TextStyles.font16WhiteMedium.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
