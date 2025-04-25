import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_lang_app/core/routing/routes.dart';
import 'package:sign_lang_app/core/theming/styles.dart';
import 'package:sign_lang_app/core/utils/sharedprefrence.dart';
import 'package:sign_lang_app/features/levels/data/models/level_model.dart';
import 'package:sign_lang_app/features/levels/presentation/manager/levels_cubit.dart';
import 'package:sign_lang_app/features/levels/presentation/manager/levels_state.dart';

class LevelsViewBody extends StatefulWidget {
  const LevelsViewBody({super.key, required this.categoryId, required this.categoryImage});
  final String? categoryId;
  final String categoryImage;

  @override
  State<LevelsViewBody> createState() => _LevelsViewBodyState();
}

class _LevelsViewBodyState extends State<LevelsViewBody> {
  @override
  Widget build(BuildContext context) {
    context.read<LevelsCubit>().fetchLevels(widget.categoryId!);
    return BlocConsumer<LevelsCubit, LevelsState>(
      listener: (context, state) {
        if (state is LevelsFailure) {
          print("Error: ${state.e}");
          //const Center(child: Text('error happens'));
        }
      },
      builder: (context, state) {
        if (state is LevelsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LevelsSuccess && state.levels.isNotEmpty) {
          return ListView.builder(
            itemCount: state.levels.length,
            itemBuilder: (BuildContext context, int index) {
              return FadeInRight(
                from: index * 300,
                child: GuideBookListViewItem(
                  index: index,
                  levelModel: state.levels[index],
                    categoryImage: widget.categoryImage,

                ),
              );
            },
          );
        }
        return Center(
            child: Text(
          'No Levels Available',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ));
      },
    );
  }
}
class GuideBookListViewItem extends StatelessWidget {
  final List<Color> bgcolors = [
    const Color(0xff00CD0D),
    const Color(0xff843EF7),
    const Color(0xff156DE6),
    const Color(0xffFFDA18),
    const Color.fromARGB(255, 129, 219, 255),
    const Color(0xffDDB06D),
  ];

  final int index;
  final LevelModel levelModel;
  final String categoryImage; // ✅ Add this

  GuideBookListViewItem({
    super.key,
    required this.index,
    required this.levelModel,
    required this.categoryImage, // ✅ Add this
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, bottom: 0),
      child: GestureDetector(
        onTap: () async {
          await SharedPrefHelper.setData('category_name', levelModel.name); 
          await SharedPrefHelper.setData('category_image', categoryImage); // ✅ Use the passed value
          await SharedPrefHelper.setData('current_level', index + 1);
          await SharedPrefHelper.setData('total_levels', 5);

          Navigator.pushNamed(context, Routes.quiz, arguments: levelModel.id);
        },
        child: Container(
          height: 115,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: bgcolors[index],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: index % 2 == 0 ? 10 : null,
                right: index % 2 == 0 ? null : 10,
                bottom: 0,
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: Image.asset(index % 2 == 0
                      ? 'assets/images/static_crossing_hands1_left.png'
                      : 'assets/images/static_crossing_hands1_right.png'),
                ),
              ),
              Align(
                alignment: index % 2 == 0
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: index % 2 == 0 ? 30 : 0,
                      left: index % 2 == 0 ? 0 : 30),
                  child: Text(
                    levelModel.name,
                    style: TextStyles.font30WhiteBold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
