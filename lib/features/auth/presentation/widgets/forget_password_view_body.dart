import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_lang_app/core/di/dependency_injection.dart';
import 'package:sign_lang_app/core/theming/styles.dart';
import 'package:sign_lang_app/core/widgets/app_text_button.dart';
import 'package:sign_lang_app/core/widgets/app_text_form_field.dart';
import 'package:sign_lang_app/features/auth/data/models/forget_password_model.dart';
import 'package:sign_lang_app/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:sign_lang_app/features/auth/presentation/manager/forget_password_cubit/forget_password_cubit.dart';
import 'package:sign_lang_app/features/auth/presentation/manager/forget_password_cubit/forget_password_state.dart';
import 'package:sign_lang_app/features/auth/presentation/widgets/custom_app_bar.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? email, token;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Text(
                'Enter Yor email , we will send a verification code to your Email',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 25)),
            const SizedBox(
              height: 40,
            ),
            Form(
              key: key,
              child: AppTextFormField(
                hintText: 'Email',
                onSaved: (data) {
                  email = data;
                },
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state is ForgetPasswordSuccessState) {
                  token = state.token;
                  /*Navigator.pushReplacementNamed(
                      context, Routes.newPasswordView,
                      arguments: token);*/
                }
              },
              builder: (context, state) {
                return AppTextButton(
                    buttonText: 'Reset',
                    textStyle: TextStyles.font14DarkBlueMedium
                        .copyWith(fontWeight: FontWeight.w700),
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        key.currentState!.save();
                        context.read<ForgetPasswordCubit>().forgetPass(
                              forgetPasswordReq:
                                  ForgetPasswordReq(email: email!),
                              forgetPasswordUsecase:
                                  getIt<ForgetPasswordUsecase>(),
                            );
                      }
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
