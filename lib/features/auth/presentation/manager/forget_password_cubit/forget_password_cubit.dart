import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_lang_app/core/errors/failure.dart';
import 'package:sign_lang_app/features/auth/data/models/forget_password_model.dart';
import 'package:sign_lang_app/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:sign_lang_app/features/auth/presentation/manager/forget_password_cubit/forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());

  void forgetPass(
      {required ForgetPasswordReq forgetPasswordReq,
      required ForgetPasswordUsecase forgetPasswordUsecase}) async {
    emit(ForgetPasswordLoadingState());
    try {
      final Either<Failure, ForgetPasswordResponse> result =
          await forgetPasswordUsecase.call(forgetPasswordReq);
      result.fold((failure) {
        emit(ForgetPasswordFailureState(message: failure.message));
      }, (data) {
        emit(ForgetPasswordSuccessState(
          message: data.msg,
          token: data.token,
        ));
      });
    } catch (e) {
      emit(ForgetPasswordFailureState(message: e.toString()));
    }
  }
}
