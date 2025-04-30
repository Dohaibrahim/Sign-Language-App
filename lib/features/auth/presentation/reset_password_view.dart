import 'package:flutter/material.dart';
import 'package:sign_lang_app/features/auth/presentation/widgets/reset_password_view_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final token = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(body: ResetPasswordViewBody(token: token));
  }
}
