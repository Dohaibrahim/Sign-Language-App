import 'package:dartz/dartz.dart';
import 'package:sign_lang_app/core/di/dependency_injection.dart';
import 'package:sign_lang_app/core/errors/failure.dart';
import 'package:sign_lang_app/core/usecase/usecase.dart';
import 'package:sign_lang_app/features/auth/data/models/forget_password_model.dart';
import 'package:sign_lang_app/features/auth/domain/repos/auth_repo.dart';

class ForgetPasswordUsecase
    extends UseCase<ForgetPasswordResponse, ForgetPasswordReq> {
  @override
  Future<Either<Failure, ForgetPasswordResponse>> call(
      [ForgetPasswordReq? param]) async {
    return await getIt<AuthRepo>().forgetPassword(param!);
  }
}
