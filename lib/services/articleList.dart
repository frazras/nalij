import 'package:flutter/cupertino.dart';
import 'package:nalij/models/article.dart';
import 'package:nalij/services/player.dart';

class ArticleList with ChangeNotifier{
  List<Article> playList;
  int _currentIndex;

  int get currentIndex => _currentIndex;

  set currentIndex(int currentIndex) {
    _currentIndex = currentIndex;
    notifyListeners();
    print("INDEX NOTIFIED");
  }

  @override
  String toString() {
    return playList.toString();
  }
}