import 'package:dartz/dartz.dart';
import 'package:sign_lang_app/core/di/dependency_injection.dart';
import 'package:sign_lang_app/core/errors/failure.dart';
import 'package:sign_lang_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:sign_lang_app/features/auth/data/models/forget_password_model.dart';
import 'package:sign_lang_app/features/auth/data/models/reset_password_model.dart';
import 'package:sign_lang_app/features/auth/data/models/signIn_response.dart';
import 'package:sign_lang_app/features/auth/data/models/signin_req.dart';
import 'package:sign_lang_app/features/auth/data/models/signup_req.dart';
import 'package:sign_lang_app/features/auth/data/models/signup_response.dart';
import 'package:sign_lang_app/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  @override
  Future<Either<Failure, SignupResponse>> signUp(SignupReqParams signupReq) {
    return getIt<AuthRemoteDataSource>().signUp(signupReq);
  }

  @override
  Future<Either<Failure, LoginResponse>> signIn(
      SigninReqParams signInReq) async {
    try {
      final result = await getIt<AuthRemoteDataSource>().signIn(signInReq);

      // Check if the result is successful
      return result.fold(
        (failure) => Left(failure), // Return the failure
        (loginResponse) async {
          return Right(loginResponse);

          // Return the successful response
        },
      );
    } catch (e) {
      return Left(Failure(e.toString())); // Handle the exception as a failure
    }
  }

  @override
  Future<Either<Failure, ForgetPasswordResponse>> forgetPassword(
      ForgetPasswordReq forgetPasswordReq) async {
    try {
      final result =
          await getIt<AuthRemoteDataSource>().forgetPassword(forgetPasswordReq);

      return result.fold((failure) {
        return Left(failure);
      }, (data) {
        return Right(data);
      });
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordResponse>> resetPassword(
      ResetPasswordReq resetPasswordReq, String token) async {
    try {
      var result = await getIt<AuthRemoteDataSource>()
          .resetPassword(resetPasswordReq, token);
      return result.fold((failure) {
        return Left(failure);
      }, (data) {
        return Right(data);
      });
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
