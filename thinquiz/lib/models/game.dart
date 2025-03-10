import 'package:thinquiz/models/quiz.dart';

class Game {
  int hintCount;
  int quizIndex;
  int totalPoint;
  int chanceCount;
  List<Quiz> quizList;

  Game(
      {required this.hintCount,
      required this.quizIndex,
      required this.totalPoint,
      required this.chanceCount,
      required this.quizList});
}
