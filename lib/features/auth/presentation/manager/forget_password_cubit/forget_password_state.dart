abstract class ForgetPasswordState {}

class ForgetPasswordInitialState extends ForgetPasswordState {}

class ForgetPasswordLoadingState extends ForgetPasswordState {}

class ForgetPasswordSuccessState extends ForgetPasswordState {
  final String message;
  final String token;

  ForgetPasswordSuccessState({required this.message, required this.token});
}

class ForgetPasswordFailureState extends ForgetPasswordState {
  final String message;

  ForgetPasswordFailureState({required this.message});
}
