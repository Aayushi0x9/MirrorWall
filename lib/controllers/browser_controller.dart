import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:morror_wall/helper/shr_helper.dart';

class BrowserController with ChangeNotifier {
  ShrHelper shr = ShrHelper();
  List<String> searchHistory = [];
  List<String> bookMark = [];
  String? bookMarkURL;
  TextEditingController searchTextController = TextEditingController();
  String mainURL = "https://www.google.com";
  String searchEngineBaseURL = 'https://www.google.com/search?q=';
  bool isDark = false;
  ThemeMode themeMode = ThemeMode.light;
  InAppWebViewController? webViewController;

  BrowserController() {
    getSearchEngine();
    getThemeMode();
    getSearchHistory();
    getBookMark();
  }
  void searchMainURL({required String search}) {
    String searchText = Uri.encodeQueryComponent(search.trim());
    mainURL = '$searchEngineBaseURL$searchText';
    saveSearchHistory(value: search);
    notifyListeners();
  }

  void setThemeMode(bool value) async {
    isDark = value;
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    shr.setTheme(isDark);
    notifyListeners();
  }

  void getThemeMode() async {
    isDark = await shr.getTheme();
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleTheme() {
    setThemeMode(!isDark);
  }

  Future<void> updateSearchEngine({required baseURL}) async {
    // searchEngineBaseURL =baseURL;
    mainURL = baseURL;
    shr.setMainUrl(mainURL);
    notifyListeners();
  }

  Future<void> getSearchEngine() async {
    mainURL = await shr.getMainUrl() ?? "https://www.google.com";
    notifyListeners();
  }

  Future<void> saveSearchHistory({required String value}) async {
    if (!searchHistory.contains(value)) {
      searchHistory.add(value);
      await shr.setSearchHistory(searchHistory);
    }
    notifyListeners();
  }

  void getSearchHistory() async {
    searchHistory = await shr.getSearchHistory();
    notifyListeners();
  }

  void clearSearchHistory() {
    shr.clearSearchHistory();
    searchHistory.clear();
    notifyListeners();
  }

  void removeSearchHistory({required int index}) {
    searchHistory.removeAt(index);
    notifyListeners();
  }

  void saveBookMark({required String url}) {
    if (!bookMark.contains(url)) {
      bookMark.add(url);
      shr.setBookMark(bookMark);
      notifyListeners();
    }
  }

  void removeBookMark({required int index}) {
    bookMark.removeAt(index);
    notifyListeners();
  }

  void getBookMark() async {
    bookMark = await shr.getBookMark();
    notifyListeners();
  }
}
