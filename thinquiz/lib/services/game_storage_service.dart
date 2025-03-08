import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/game.dart';
import '../model/quiz.dart';

class GameStorageService {
  static const String _gameKey = 'thinq_game_data';

  Future<bool> saveGame(Game game) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final gameMap = {
        'hintCount': game.hintCount,
        'quizIndex': game.quizIndex,
        'totalPoint': game.totalPoint,
        'quizList': game.quizList
            .map((quiz) => {
                  'title': quiz.title,
                  'point': quiz.point,
                  'hint': quiz.hint,
                  'content': quiz.content,
                  'answer': quiz.answer,
                  'solution': quiz.solution,
                  'status': quiz.status,
                  'quizImage': quiz.quizImage,
                })
            .toList(),
      };

      final String gameJson = jsonEncode(gameMap);
      return await prefs.setString(_gameKey, gameJson);
    } catch (e) {
      print('게임 데이터 저장 중 오류 발생: $e');
      return false;
    }
  }

  Future<Game?> loadGame() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? gameJson = prefs.getString(_gameKey);

      if (gameJson == null) {
        return null;
      }

      final Map<String, dynamic> gameMap = jsonDecode(gameJson);

      final List<Quiz> quizList = (gameMap['quizList'] as List)
          .map((quizMap) => Quiz(
                title: quizMap['title'],
                point: quizMap['point'],
                hint: quizMap['hint'],
                content: quizMap['content'],
                answer: quizMap['answer'],
                solution: quizMap['solution'],
                status: quizMap['status'],
                quizImage: quizMap['quizImage'],
              ))
          .toList();

      return Game(
        hintCount: gameMap['hintCount'],
        quizIndex: gameMap['quizIndex'],
        totalPoint: gameMap['totalPoint'],
        quizList: quizList,
      );
    } catch (e) {
      print('게임 데이터 불러오기 중 오류 발생: $e');
      return null;
    }
  }

  Future<bool> clearGame() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_gameKey);
    } catch (e) {
      print('게임 데이터 삭제 중 오류 발생 $e');
      return false;
    }
  }

  Future<bool> updateGame(Game updateGame) async {
    return await saveGame(updateGame);
  }
}
