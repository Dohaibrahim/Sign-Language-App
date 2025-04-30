import 'package:sign_lang_app/features/auth/data/models/reset_password_model.dart';

abstract class ResetPasswordState {}

class ResetPasswordInitialState extends ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {}

class ResetPasswordSuccessState extends ResetPasswordState {
  final String message;
  final User user;

  ResetPasswordSuccessState({required this.message, required this.user});
}

class ResetPasswordFailureState extends ResetPasswordState {
  final String message;
  ResetPasswordFailureState({required this.message});
}
