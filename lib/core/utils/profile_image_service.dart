import 'dart:developer';
import 'dart:io';
import 'package:sign_lang_app/core/utils/constants.dart';
import 'package:sign_lang_app/core/utils/sharedprefrence.dart';

class ProfileImageService {
  static Future<void> saveProfileImagePath(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await SharedPrefHelper.setData(SharedPrefKeys.profileImagePath, path);
    }
  }

  static Future<String?> getProfileImagePath() async {
    final path =
        await SharedPrefHelper.getString(SharedPrefKeys.profileImagePath);

    if (path != null) {
      final file = File(path);
      if (await file.exists()) {
        return path;
      }
    }
    return null;
  }

  static Future<void> clearProfileImage() async {
    final path =
        await SharedPrefHelper.getString(SharedPrefKeys.profileImagePath);
    if (path != null) {
      try {
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        log('Error deleting profile image: $e');
      }
    }
    await SharedPrefHelper.removeData(SharedPrefKeys.profileImagePath);
  }
}
