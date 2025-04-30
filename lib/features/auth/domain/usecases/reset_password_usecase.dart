import 'package:dartz/dartz.dart';
import 'package:sign_lang_app/core/di/dependency_injection.dart';
import 'package:sign_lang_app/core/errors/failure.dart';
import 'package:sign_lang_app/core/usecase/usecase.dart';
import 'package:sign_lang_app/features/auth/data/models/reset_password_model.dart';
import 'package:sign_lang_app/features/auth/domain/repos/auth_repo.dart';

class ResetPasswordUsecase
    extends UseCase<ResetPasswordResponse, ResetPasswordReq> {
  final String token;
  ResetPasswordUsecase({required this.token});
  @override
  Future<Either<Failure, ResetPasswordResponse>> call(
      [ResetPasswordReq? param]) async {
    return await getIt<AuthRepo>().resetPassword(param!, token);
  }
}
