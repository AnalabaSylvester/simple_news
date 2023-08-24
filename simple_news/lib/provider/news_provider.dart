import 'package:flutter/cupertino.dart';

class NewsProvider extends ChangeNotifier {
  bool _isSearching = false;

  get isSearching => _isSearching;

  void search() {
    _isSearching = true;
    notifyListeners();
  }
}
