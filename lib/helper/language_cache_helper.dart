// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wassle/helper/cache_helper.dart';
// import 'package:wassle/utils/shared_pref_const.dart';
//
// class LanguageCacheHelper {
//   Future<void> cacheLanguageCode(String languageCode) async {
//     final sharedPreferences = await SharedPreferences.getInstance();
//     if (sharedPreferences.getString(SharedPrefConst.locale) == null) {
//       sharedPreferences.setString(SharedPrefConst.locale, "en");
//     } else {
//       sharedPreferences.setString(SharedPrefConst.locale, languageCode);
//     }
//   }
//
//   Future<String> getCachedLanguageCode() async {
//     final sharedPreferences = await SharedPreferences.getInstance();
//     final cachedLanguageCode =
//         sharedPreferences.getString(SharedPrefConst.locale);
//     if (cachedLanguageCode != null) {
//       return cachedLanguageCode;
//     } else {
//       CacheHelper.saveData(key: SharedPrefConst.locale, value: "en");
//
//       return "en";
//     }
//   }
// }
