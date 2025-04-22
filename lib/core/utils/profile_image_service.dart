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
    log('path in getProfile image path is $path');
    if (path != null) {
      final file = File(path);
      if (await file.exists()) {
        //await getImageFromBackend(file, context);
        log('path after if (await file.exists()) { is $path');
        return path;
      }
    }
    //await getImageFromBackend();
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

  /*static Future<void> getImageFromBackend(
      File? image, BuildContext context) async {
    if (image != null) {
      final request = AddImageReq(
        image: image,
        token: await _getUserToken(),
      );
      context.read<AddImageCubit>().addImage(
            addImageUseCase: getIt<AddImageUseCase>(),
            addImageReq: request,
          );
      _loadLocalProfileImage(context);
    }
  }

  static Future<String> _loadLocalProfileImage(BuildContext context) async {
    final path = await ProfileImageService.getProfileImagePath(context);
    if (path != null) {
      final _localImagePath = path;
      return _localImagePath;
    }
    return 'error';
  }

  static Future<String> _getUserToken() async {
    final userToken =
        await SharedPrefHelper.getStringNullable(SharedPrefKeys.userToken);
    return userToken!;
  }*/
}
