import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sign_lang_app/core/errors/failure.dart';
import 'package:sign_lang_app/core/utils/api_service.dart';
import 'package:sign_lang_app/core/utils/constants.dart';
import 'package:sign_lang_app/features/setting/data/models/add_image_req.dart';
import 'package:sign_lang_app/features/setting/data/models/add_image_response.dart';

abstract class AddImageRemoteDataSource {
  Future<Either<Failure, AddImageResponse>> addImage(AddImageReq request);
}

class AddImageRemoteDataSourceImpl extends AddImageRemoteDataSource {
  final DioClient dioClient;
  AddImageRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, AddImageResponse>> addImage(
      AddImageReq request) async {
    try {
      final formData = await request.toFormData();

      var response = await dioClient.patch(
        ApiUrls.addImage,
        data: formData,
        options: Options(headers: request.headers
            //headers: {'Authorization': 'Bearer ${request.token}'},
            ),
        //headers: request.headers),
      );
      //AddImageResponse addImageResponse = AddImageResponse.fromJson(response.data);

      //if (response.statusCode == 200 || response.statusCode == 201) {
      return Right(AddImageResponse.fromJson(response.data));

      //return Right(addImageResponse);
    } on DioException catch (e) {
      log("error (DioException) in data source ${e.toString()}");
      return Left(Failure(e.toString()));
    } catch (e) {
      log("error in data source ${e.toString()}");
      return Left(Failure(e.toString()));
    }
  }
}
