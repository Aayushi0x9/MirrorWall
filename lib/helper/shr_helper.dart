import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper {
  Future<void> setBookMark(List<String> bookMarks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("bookMark", bookMarks);
  }

  Future<List<String>> getBookMark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("bookMark") ?? [];
  }

  Future<void> setSearchHistory(List<String> searchHistory) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("searchHistory", searchHistory);
  }

  Future<List<String>> getSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("searchHistory") ?? [];
  }

  Future<void> setTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDark", isDark);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isDark") ?? false;
  }

  Future<void> clearSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("searchHistory");
  }

  Future<void> setMainUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("url", url);
  }

  Future<String?> getMainUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("url");
  }
}
