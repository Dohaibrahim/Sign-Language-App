import 'package:shared_preferences/shared_preferences.dart';

const KDictionaryBox = 'dictionaryBox';
const KSavedwordsBox = 'SavedwordsBox';

class ApiUrls {
  //static const baseURL = "http://10.0.2.2:3000"; // android emulator
  //static const baseURL = 'http://127.0.0.1:3000';
  static const String baseURL = "http://192.168.1.2:3000";
  //static const baseURL = 'http://localhost:3000';

  static const register = "$baseURL/api/auth/signup";
  static const login = "$baseURL/api/auth/signin";
  static const forgetPassword = '$baseURL/api/auth/forget-password';
  static const dictionary = "$baseURL/api/dectionary";
  static const questions = "$baseURL/api/level";
  static const guidebook = "$baseURL/api/category";
  static const resetPassword = '$baseURL/api/auth/reset-password';

  static const addImage = "$baseURL/api/user/uploadImage";

  static const category = "$baseURL/api/category";

  static const levels = "$baseURL/api/level";
  static const changePass = '$baseURL/api/auth/changepassword';

  static Future<String> getEditInfoUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(SharedPrefKeys.userid);
    if (userId != null) {
      return '$baseURL/api/user/$userId';
    } else {
      return '$baseURL/api/user/dummy_id';
    }
  }
}

bool isLoggedInUser = false;

class SharedPrefKeys {
  static const String userToken = 'userToken';
  static const String onboardingCompleted = 'onboardingCompleted';
  static const String username = 'username';
  static const String userEmail = 'userEmail';
  static const String userid = 'id';
  static const String weclometestcomplete = 'weclometestcomplete';
  static const String profileImagePath = 'profileImagePath';
}
