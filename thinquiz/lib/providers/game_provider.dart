import 'package:flutter/material.dart';
import 'package:thinquiz/models/game.dart';
import 'package:thinquiz/models/quiz.dart';

import '../services/game_storage_service.dart';

class GameProvider extends ChangeNotifier {
  final Game _item = Game(hintCount: 3, quizIndex: 0, totalPoint: 0, quizList: [
    Quiz(
        title: '더하기 문제 1',
        point: 5,
        hint: '3은 아니다',
        isHintOpen: false,
        content: '1 더하기 1은?',
        answer: '2',
        solution: '1 더하기 1은 2이다',
        status: QuizStatus.solving,
        quizImage: ''),
    Quiz(
        title: '더하기 문제 2',
        point: 5,
        hint: '3은 아니다',
        isHintOpen: false,
        content: '2 더하기 2는?',
        answer: '4',
        solution: '2 더하기 2는 4이다',
        status: QuizStatus.pending,
        quizImage: ''),
    Quiz(
        title: '더하기 문제 3',
        point: 5,
        hint: '3은 아니다',
        isHintOpen: false,
        content: '3 더하기 3은?',
        answer: '6',
        solution: '3 더하기 3는 6이다',
        status: QuizStatus.pending,
        quizImage: ''),
    Quiz(
        title: '더하기 문제 4',
        point: 5,
        hint: '3은 아니다',
        isHintOpen: false,
        content: '4 더하기 4는?',
        answer: '8',
        solution: '4 더하기 4는 8이다',
        status: QuizStatus.pending,
        quizImage: ''),
    Quiz(
        title: '더하기 문제 5',
        point: 5,
        hint: '3은 아니다',
        isHintOpen: false,
        content: '5 더하기 5는?',
        answer: '10',
        solution: '5 더하기 5는 10이다',
        status: QuizStatus.pending,
        quizImage: ''),
    Quiz(
        title: '더하기 문제 6',
        point: 5,
        hint: '3은 아니다',
        isHintOpen: false,
        content: '6 더하기 6은?',
        answer: '12',
        solution: '6 더하기 6는 12이다',
        status: QuizStatus.pending,
        quizImage: ''),
    Quiz(
        title: '더하기 문제 7',
        point: 5,
        hint: '3은 아니다',
        isHintOpen: false,
        content: '7 더하기 7은?',
        answer: '14',
        solution: '7 더하기 7는 14이다',
        status: QuizStatus.pending,
        quizImage: ''),
    Quiz(
        title: '더하기 문제 8',
        point: 5,
        hint: '3은 아니다',
        isHintOpen: false,
        content: '8 더하기 8은?',
        answer: '16',
        solution: '8 더하기 8는 16이다',
        status: QuizStatus.pending,
        quizImage: ''),
    Quiz(
        title: '더하기 문제 9',
        point: 5,
        hint: '3은 아니다',
        isHintOpen: false,
        content: '9 더하기 9는?',
        answer: '18',
        solution: '9 더하기 9는 18이다',
        status: QuizStatus.pending,
        quizImage: ''),
    Quiz(
        title: '더하기 문제 10',
        point: 5,
        hint: '3은 아니다',
        isHintOpen: false,
        content: '10 더하기 10은?',
        answer: '20',
        solution: '10 더하기 10는 20이다',
        status: QuizStatus.pending,
        quizImage: '')
  ]);

  Game get item => _item;
  int get hintCount => _item.hintCount;
  int get quizIndex => _item.quizIndex;
  int get totalPoint => _item.totalPoint;
  List<Quiz> get quizItems => _item.quizList;

  Color getQuizColor(int index) {
    QuizStatus status = _item.quizList[index].status;

    switch (status) {
      case QuizStatus.correct:
        return Color(0xff003049);
      case QuizStatus.incorrect:
        return Color(0xffa22c29);
      case QuizStatus.solving:
        return Color(0xffffc300);
      case QuizStatus.pending:
        return Color(0xffd6d5c9);
    }
  }

  void increaseQuizIndex() {
    _item.quizIndex++;
    _item.quizList[_item.quizIndex].status = QuizStatus.solving;
    notifyListeners();
  }

  void increaseHint() {
    _item.hintCount++;
    notifyListeners();
  }

  void decreaseHint() {
    _item.hintCount--;
    notifyListeners();
  }

  // main_screen 의 진행 사항 초기화 버튼 동작을 위해 코드 추가
  Future<void> clearGame() async {
    final storageService = GameStorageService();
    await storageService.clearGame();

    _item.hintCount = 3;
    _item.quizIndex = 0;
    _item.totalPoint = 0;
    for (var quiz in _item.quizList) {
      quiz.status = QuizStatus.pending;
    }
    notifyListeners();
  }
}
