import 'package:dartz/dartz.dart';
import 'package:sign_lang_app/core/errors/failure.dart';
import 'package:sign_lang_app/features/setting/data/models/add_image_req.dart';
import 'package:sign_lang_app/features/setting/data/models/add_image_response.dart';

abstract class AddImageRepo {
  Future<Either<Failure, AddImageResponse>> addImage(AddImageReq request);
}
