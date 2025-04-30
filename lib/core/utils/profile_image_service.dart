import 'dart:developer';
import 'dart:io';
import 'package:sign_lang_app/core/utils/constants.dart';
import 'package:sign_lang_app/core/utils/sharedprefrence.dart';

class ProfileImageService {
  static const String baseImageUrl = '${ApiUrls.baseURL}/uploads/user/';

  static Future<void> saveProfileImagePath(String path) async {
    //final file = File(path);
    //if (await file.exists()) {
    await SharedPrefHelper.setData(SharedPrefKeys.profileImagePath, path);
    //}
  }

  static Future<String?> getProfileImagePath() async {
    final imageName =
        await SharedPrefHelper.getString(SharedPrefKeys.profileImagePath);
    return imageName != null ? '$baseImageUrl$imageName' : null;
  }

  static Future<void> clearProfileImage() async {
    await SharedPrefHelper.removeData(SharedPrefKeys.profileImagePath);
  }
}
