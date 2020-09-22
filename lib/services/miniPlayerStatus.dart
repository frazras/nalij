import 'package:flutter/material.dart';

class MiniPlayerStatus with ChangeNotifier{

  bool _isFullPlayer = false;

  bool get isFullPlayer => _isFullPlayer;

  set isFullPlayer(bool isFullPlayer) {
    _isFullPlayer = isFullPlayer;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => notifyListeners());
  }

  @override
  String toString() {
    return isFullPlayer ? "TRUE" : "FALSE";
  }
}