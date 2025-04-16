import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_lang_app/core/theming/styles.dart';
import 'package:sign_lang_app/core/utils/constants.dart';
import 'package:sign_lang_app/features/learn/data/models/question_response.dart';
import 'package:sign_lang_app/features/learn/presentation/manager/fetch_avatar_signbefore_quiz_cubit/fetch_avatar_signbefore_quiz_cubit.dart';
import 'package:sign_lang_app/features/learn/presentation/widgets/nova_message.dart';

class GuideBookViewBody extends StatelessWidget {
  const GuideBookViewBody({super.key, required this.categoryId});
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    // Fetch signs when the widget is built
    context
        .read<FetchAvatarSignbeforeQuizCubit>()
        .fetchAvatarSignBeforeQuerList(categoryId);

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
              final sign = state.AvatarList[index];
              final gifUrl = sign.signUrls.isNotEmpty
                  ? sign.signUrls.first
                  : ''; // Avoid exception if empty
              return GuideBookListViewItem(
                gifUrl: gifUrl,
                sign: sign,
              );
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
  final Question sign;
  final String gifUrl;

  const GuideBookListViewItem({
    super.key,
    required this.sign,
    required this.gifUrl,
  });

  @override
  Widget build(BuildContext context) {
    final signText =
        sign.signTexts.isNotEmpty ? sign.signTexts.first : 'No Text';

    return Container(
      height: 230,
      width: 100,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryFixed,
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
                color: Theme.of(context).colorScheme.primaryFixedDim,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  signText,
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
              child: gifUrl.isNotEmpty
                  ? Image.network(ApiUrls.baseURL + gifUrl)
                  : const Placeholder(),
            ),
          ),
          Positioned(
            left: 150,
            bottom: 50,
            child: SizedBox(
              width: 150,
              height: 150,
              child: NovaMessage(
                text: signText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
