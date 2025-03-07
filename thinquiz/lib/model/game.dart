import 'quiz.dart';

class Game {
  final int hintCount;
  final int quizIndex;
  final int totalPoint;
  final List<Quiz> quizList;

  Game({
    required this.hintCount,
    required this.quizIndex,
    required this.totalPoint,
    required this.quizList,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    final List<Quiz> quizList =
        (json['quizList'] as List).map((quiz) => Quiz.fromJson(quiz)).toList();

    return Game(
      hintCount: json['hintCount'] as int,
      quizIndex: json['quizIndex'] as int,
      totalPoint: json['totalPoint'] as int,
      quizList: quizList,
    );
  }
}
