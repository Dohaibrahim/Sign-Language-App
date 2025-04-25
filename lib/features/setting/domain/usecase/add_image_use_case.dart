import 'package:dartz/dartz.dart';
import 'package:sign_lang_app/core/di/dependency_injection.dart';
import 'package:sign_lang_app/core/errors/failure.dart';
import 'package:sign_lang_app/core/usecase/usecase.dart';
import 'package:sign_lang_app/features/setting/data/models/add_image_req.dart';
import 'package:sign_lang_app/features/setting/data/models/add_image_response.dart';
import 'package:sign_lang_app/features/setting/domain/repo/add_image_repo.dart';

class AddImageUseCase extends UseCase<AddImageResponse, AddImageReq> {
  @override
  Future<Either<Failure, AddImageResponse>> call([AddImageReq? param]) async {
    return await getIt<AddImageRepo>().addImage(param!);
  }
}
