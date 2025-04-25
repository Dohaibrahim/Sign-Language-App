import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:sign_lang_app/core/di/dependency_injection.dart';
import 'package:sign_lang_app/core/errors/failure.dart';
import 'package:sign_lang_app/features/setting/data/data_source/add_image_data_source/add_image_remote_data_source.dart';
import 'package:sign_lang_app/features/setting/data/models/add_image_req.dart';
import 'package:sign_lang_app/features/setting/data/models/add_image_response.dart';
import 'package:sign_lang_app/features/setting/domain/repo/add_image_repo.dart';

class AddImageRepoImpl extends AddImageRepo {
  @override
  Future<Either<Failure, AddImageResponse>> addImage(
      AddImageReq request) async {
    try {
      final result = await getIt<AddImageRemoteDataSource>().addImage(request);
      return result.fold((failure) {
        log('error in repo impl ${failure.message}');
        return Left(Failure(failure.toString()));
      }, (addImageResponse) {
        log('success in repo impl ${addImageResponse}');
        return Right(addImageResponse);
      });
    } catch (e) {
      log('error in repo impl ${e.toString()}');
      return Left(Failure(e.toString()));
    }
  }
}
