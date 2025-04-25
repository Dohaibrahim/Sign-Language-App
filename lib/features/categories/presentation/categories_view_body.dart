import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_lang_app/core/routing/routes.dart';
import 'package:sign_lang_app/core/utils/extentions.dart';
import 'package:sign_lang_app/features/categories/data/models/category_res.dart';
import 'package:sign_lang_app/features/categories/presentation/manager/cubit/categories_cubit.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a list of image paths
    final List<String> imagePaths = [
      "assets/images/Group 36855 (4).png",
      "assets/images/Frame 3 (1).png",
      "assets/images/Frame 5.png",
      //'assets/images/Frame 4.png',
      'assets/images/Frame 6.png',
      'assets/images/public_blaces.svg',
      'assets/images/nature.svg',
    ];

    return GridViewBlocConsumer(imagePaths: imagePaths);
  }
}

class GridViewBlocConsumer extends StatefulWidget {
  const GridViewBlocConsumer({
    super.key,
    required this.imagePaths,
  });

  final List<String> imagePaths;

  @override
  State<GridViewBlocConsumer> createState() => _GridViewBlocConsumerState();
}

class _GridViewBlocConsumerState extends State<GridViewBlocConsumer> {
  List<CategoryModel> CategoriesList = [];

  @override
  Widget build(BuildContext context) {
    // Trigger fetching categories when the widget is built
    context.read<CategoriesCubit>().fetchDictionaryList();

    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {
        if (state is CategoriesFailure) {
          // Optionally show a snackbar or dialog with the error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
              state.errMessage,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            )),
          );
        }
      },
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriesSuccess) {
          return CategoriesMap(
            item: (BuildContext context, int index) {
              return CategoriesItem(
                category: state.categories[index],
                imagePath: widget.imagePaths[index % widget.imagePaths.length],
              );
            },
            itemsLength: state.categories.length,
          );
        } else {
          return Center(
              child: Text(
            'No categories available.',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ));
        }
      },
    );
  }
}

class CategoriesItem extends StatelessWidget {
  final String imagePath;
  final CategoryModel category;

  const CategoriesItem(
      {super.key, required this.imagePath, required this.category});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return SizedBox(
        width: 350,
        //height: 200,
        child: GestureDetector(
          onTap: () {
            context.pushNamed(Routes.LevelsView, arguments: {
              'categoryId': category.id,
              'categoryName': category.name
            }
                // Pass category ID as an argument
                );
          },
          child: Stack(
            children: [
              Positioned(
                left: 18,
                child: Image.asset(
                  imagePath,
                  //"assets/images/Group 36855 (4).png",
                  width: width * 0.28, //130,
                  //height: 200,
                ),
              ),
              Positioned(
                width: width * 0.36,
                top: height * .107,
                //left: 0,
                child: CategoryName(
                  //width: width * 0.355,
                  text: category.name,
                ),
              )
            ],
          ),
        ));
  }
}

class CategoryName extends StatelessWidget {
  const CategoryName({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
      decoration: BoxDecoration(
          color: Color(0xff75808f),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 16),
      ),
    );
  }
}

class CategoriesMap extends StatelessWidget {
  const CategoriesMap(
      {super.key, required this.itemsLength, required this.item});
  final int itemsLength;
  final Widget? Function(BuildContext, int) item;
  //final Widget item;

  EdgeInsets _getPaddingVal(int index, context) {
    double scWidth = MediaQuery.sizeOf(context).width;
    if (index == 0) {
      return EdgeInsets.symmetric(horizontal: scWidth * 0.27);
    } else if (index % 2 == 0) {
      return EdgeInsets.only(right: scWidth * 0.55);
    } else {
      return EdgeInsets.only(left: scWidth * 0.55);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ListView.builder(
        //shrinkWrap: true, // Allows ListView to take only the needed space
        physics:
            AlwaysScrollableScrollPhysics(), // Prevents ListView from interfering with parent scroll
        scrollDirection: Axis.vertical,
        //padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: itemsLength,
        itemBuilder: (context, index) {
          return SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.17,
            child: //Align(
                //alignment: _getAlignment(index),
                //child:
                Padding(
              padding: _getPaddingVal(index, context),
              //padding: const EdgeInsets.only(left: 27),
              child: item(context, index),
              //),
            ),
          );
        },
      ),
    );
  }
}

/*class CategoriesItem extends StatelessWidget {
  final String imagePath;
  final CategoryModel category;

  const CategoriesItem(
      {super.key, required this.imagePath, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
    context.pushNamed(Routes.LevelsView, arguments: {
  'categoryId': category.id,
  'categoryName': category.name,
  'categoryImage': imagePath, 
});

      },
      child: Container(
        height: 190,
        width: 140,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primaryFixed
            //const Color(0xff202F36),
            ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category.name,
                  style: TextStyles.font16GraySemibold.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary)),
              const SizedBox(
                height: 14,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 75,
                  width: 75,
                  child: SvgPicture.asset(
                    imagePath,
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
*/
