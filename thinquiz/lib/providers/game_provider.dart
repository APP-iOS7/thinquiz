import 'package:flutter/material.dart';
import 'package:thinquiz/models/game.dart';

class GameProvider extends ChangeNotifier {
  final Game _item = Game(hintCount: 3, quizIndex: 0, totalPoint: 0);

  Game get item => _item;

  void increaseQuizIndex() {
    _item.quizIndex++;
    notifyListeners();
  }
}
