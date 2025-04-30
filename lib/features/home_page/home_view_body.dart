import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sign_lang_app/core/theming/colors.dart';
import 'package:sign_lang_app/core/theming/styles.dart';
import 'package:sign_lang_app/core/utils/constants.dart';
import 'package:sign_lang_app/core/widgets/build_header.dart';
import 'package:sign_lang_app/features/home_page/widgets/Horizontal_word_list_tem.dart';
import 'package:sign_lang_app/features/home_page/widgets/home_app_bar.dart';
import 'package:sign_lang_app/core/widgets/speak_with_hands.dart';
import 'package:sign_lang_app/features/home_page/widgets/services_widget.dart';
import 'package:sign_lang_app/features/learn/presentation/widgets/questions_tracker.dart';
import '../../core/utils/sharedprefrence.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: FutureBuilder<String?>(
            future: SharedPrefHelper.getStringNullable(SharedPrefKeys.username),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                  'Error: ${snapshot.error}',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ));
              } else {
                String userName = snapshot.data ?? 'User';
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomHomeAppBar(
                      title: 'Good Morning',
                      subtitle: userName,
                    ),
                    const SizedBox(height: 160, child: SpeakWithHands()),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      child: Text(
                        'Services',
                        style: TextStyles.font20WhiteSemiBold.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                    const ServicesWidget(),
                    const SizedBox(height: 12),
                    const BuildsHeader(
                      title: 'Your Progress',
                      seeAllVisible: false,
                    ),
                    const SizedBox(height: 12),
                    YourProgressItem(),
                    const SizedBox(height: 12),
                    const BuildsHeader(
                      title: 'Common Words',
                      seeAllVisible: true,
                    ),
                    const SizedBox(height: 12),
                    const HorizontalWordList(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class YourProgressItem extends StatelessWidget {
  const YourProgressItem({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _getProgressData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          );
        } else if (snapshot.hasData) {
          var progressData = snapshot.data!;
          int currentLevel = progressData['currentLevel'] ?? 0;
          int totalLevels = progressData['totalLevels'] ?? 5;
          String categoryImage = progressData['categoryImage'] ??
              'assets/images/body_parts.svg'; // Default image in case it's not found

          String categoryName = progressData['categoryName'] ??
              'Category'; // Default category name

          double progress = totalLevels > 0 ? currentLevel / totalLevels : 0;
          //currentLevel / totalLevels;

          return Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorsManager.progressContainerColor,
                ),
                height: 112,
                width: 113,
                child: Center(
                    child: SvgPicture.asset(
                        categoryImage) // Display the category image
                    ),
              ),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    categoryName, // Display the category name
                    style: TextStyles.font20WhiteSemiBold.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child:
                              SvgPicture.asset('assets/images/favourites.svg'),
                        ),
                        SizedBox(width: 6),
                        Text(
                          '$currentLevel levels | $totalLevels words',
                          style: TextStyles.font16WhiteMedium.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ],
                    ),
                  ),
                  Customhometrackerbar(progress: progress),
                ],
              ),
            ],
          );
        }
        return const Center(child: Text('No progress available.'));
      },
    );
  }

  Future<Map<String, dynamic>> _getProgressData() async {
    int currentLevel = await SharedPrefHelper.getInt("current_level") ?? 0;
    int totalLevels = await SharedPrefHelper.getInt("total_levels") ?? 5;
    String categoryImage = await SharedPrefHelper.getStringNullable(
            "category_image") ??
        'assets/images/body_parts.svg'; // Default image in case it's not found
    String categoryName =
        await SharedPrefHelper.getStringNullable("category_name") ??
            'Category'; // Default category name

    return {
      'currentLevel': currentLevel,
      'totalLevels': totalLevels,
      'categoryImage': categoryImage,
      'categoryName': categoryName,
    };
  }
}

class Customhometrackerbar extends StatelessWidget {
  final double progress;
  const Customhometrackerbar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180.w, // Smaller width to fit under text
      child: LinearPercentIndicator(
        barRadius: const Radius.circular(10),
        animation: true,
        animationDuration: 800,
        lineHeight: 9, // Reduced height for a cleaner look
        percent: progress, // Pass the progress value
        progressColor: const Color(0xff58CC02),
        backgroundColor: Colors.grey[100], // Darker background for contrast
      ),
    );
  }
}
