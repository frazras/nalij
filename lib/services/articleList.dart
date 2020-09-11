import 'package:flutter/cupertino.dart';
import 'package:nalij/models/article.dart';
import 'package:nalij/services/player.dart';

class ArticleList with ChangeNotifier{
  List<Article> playList;
  int _currentIndex;
  bool _isFullPlayer = false;

  bool get isFullPlayer => _isFullPlayer;

  set isFullPlayer(bool isFullPlayer) {
    _isFullPlayer = isFullPlayer;
    //notifyListeners();
  }

  int get currentIndex => _currentIndex;

  set currentIndex(int currentIndex) {
    _currentIndex = currentIndex;
    notifyListeners();
  }
  Player audioPlayer = new Player();

  @override
  String toString() {
    // TODO: implement toString
    return playList.toString();
  }
}