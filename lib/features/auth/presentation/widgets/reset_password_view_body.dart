import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_lang_app/core/theming/styles.dart';
import 'package:sign_lang_app/core/widgets/app_text_button.dart';
import 'package:sign_lang_app/core/widgets/app_text_form_field.dart';
import 'package:sign_lang_app/core/widgets/custom_button_animation.dart';
import 'package:sign_lang_app/features/auth/data/models/reset_password_model.dart';
import 'package:sign_lang_app/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:sign_lang_app/features/auth/presentation/manager/reset_password_cubit/reset_password_cubit.dart';
import 'package:sign_lang_app/features/auth/presentation/manager/reset_password_cubit/reset_password_state.dart';
import 'package:sign_lang_app/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:sign_lang_app/features/auth/presentation/widgets/loading_button.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key, required this.token});
  final String token;
  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final GlobalKey<CustomButtonState> btnKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordCubit>(
      create: (context) => ResetPasswordCubit(),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 60,
          ),
          const CustomAppBar(),
          Text(
            'Reset Password',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                //color: Colors.grey[700],
                fontSize: 35,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 20,
          ),
          Text('Please enter your new password',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 25)),
          SizedBox(
            height: 40.h,
          ),
          Form(
            key: key,
            child: AppTextFormField(
              hintText: 'New Password',
              onSaved: (data) {
                password = data;
              },
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              listener: (context, state) {
            if (state is ResetPasswordSuccessState) {
              //Navigator.pop(context);
            }
          }, builder: (context, state) {
            return AppTextButton(
                buttonText: 'Done',
                textStyle: TextStyles.font14DarkBlueMedium
                    .copyWith(fontWeight: FontWeight.w700),
                onPressed: () {
                  if (key.currentState!.validate()) {
                    key.currentState!.save();
                    context.read<ResetPasswordCubit>().resetPassword(
                        ResetPasswordReq(password: password!),
                        ResetPasswordUsecase(token: widget.token));
                  }
                });
          }),

          /*LoadingButton(
                    btnKey: btnKey,
                    title: 'Done',
                    // textStyle: TextStyles.font14DarkBlueMedium
                    //    .copyWith(fontWeight: FontWeight.w700),
                    onTap: () {
                      if (key.currentState!.validate()) {
                        key.currentState!.save();
                        context.read<ResetPasswordCubit>().resetPassword(
                            ResetPasswordReq(password: password!),
                            ResetPasswordUsecase(token: widget.token));
                      }
                    });
              },*/
        ]),
      ),
    );
  }
}
