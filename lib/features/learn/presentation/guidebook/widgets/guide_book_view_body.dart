import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_lang_app/core/theming/styles.dart';
import 'package:sign_lang_app/core/utils/constants.dart';
import 'package:sign_lang_app/features/learn/data/models/question_response.dart';
import 'package:sign_lang_app/features/learn/presentation/manager/fetch_avatar_signbefore_quiz_cubit/fetch_avatar_signbefore_quiz_cubit.dart';
import 'package:sign_lang_app/features/learn/presentation/widgets/nova_message.dart';

class GuideBookViewBody extends StatelessWidget {
  const GuideBookViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch signs when the widget is built
    context
        .read<FetchAvatarSignbeforeQuizCubit>()
        .fetchAvatarSignBeforeQuerList("67a4204dc40f603a9cc5183c");

    return BlocBuilder<FetchAvatarSignbeforeQuizCubit,
        FetchAvatarSignbeforeQuizState>(
      builder: (context, state) {
        if (state is FetchAvatarSignbeforeQuizLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FetchAvatarSignbeforeQuizFaliure) {
          return Center(
              child: Text(
            'Error: ${state.errMessage}',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ));
        } else if (state is FetchAvatarSignbeforeQuizSuccess) {
          return ListView.builder(
            itemCount: state.AvatarList.length,
            itemBuilder: (BuildContext context, int index) {
              return GuideBookListViewItem(
                  gifUrl:
                      state.AvatarList.map((q) => q.signUrls.first).toList()[index],
                  sign: state.AvatarList[index]); // Pass the sign object
            },
          );
        }
        return Center(
            child: Text(
          'No signs available.',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ));
      },
    );
  }
}

class GuideBookListViewItem extends StatelessWidget {
  final Question sign; // Change to accept Sign object
  final String gifUrl;
  const GuideBookListViewItem(
      {super.key,
      required this.sign,
      required this.gifUrl}); // Update constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 100,
      margin: const EdgeInsets.symmetric(
          vertical: 8.0, horizontal: 16.0), // Optional: Add some margin
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .onPrimaryFixed, //const Color(0xff202F36),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 3.0,
          color: Theme.of(context).colorScheme.onSecondaryFixed,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: -2,
            child: Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryFixedDim, //const Color(0xff141F23).,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  sign.signTexts.first, // Display the sign text
                  style: TextStyles.font20WhiteSemiBold,
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 48,
            child: SizedBox(
                width: 150,
                height: 150,
                child: Image.network(ApiUrls.baseURL + gifUrl)
                // Image.asset('assets/images/static_point_up1.png'), // Display the avatar
                ),
          ),
          Positioned(
            left: 150,
            bottom: 50,
            child: SizedBox(
              width: 150,
              height: 150,
              child: NovaMessage(
                text: sign.signTexts.first, // Use sign text for NovaMessage
              ),
            ),
          ),
        ],
      ),
    );
  }
}
