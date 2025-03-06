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
}
