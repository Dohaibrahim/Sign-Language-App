import 'dart:io';

import 'package:dio/dio.dart';

class AddImageReq {
  final File image;
  final String token;

  AddImageReq({required this.image, required this.token});

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'image': await MultipartFile.fromFile(
        image.path,
        filename: 'upload_${DateTime.now().millisecondsSinceEpoch}.jpg',
        contentType: DioMediaType('image', 'jpeg'),
      ),
    });
  }

  Map<String, dynamic> get headers => {
        'Authorization':
            'Bearer $token', // Changed from 'token' to 'Authorization'
        // Let Dio handle Content-Type automatically for multipart
      };
}
