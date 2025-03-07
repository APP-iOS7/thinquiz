import 'package:flutter/material.dart';
import 'package:thinquiz/model/quiz.dart';

import 'home_screen.dart';
import 'model/game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Game> _gameData = [
    //
    Game(
      hintCount: 3,
      quizIndex: 0,
      totalPoint: 100,
      quizList: [
        Quiz(
          title: '퀴즈 1',
          point: 10,
          hint: '힌트 1',
          content: '내용 1',
          answer: '정답 1',
          solution: '해설 1',
          status: '상태 1',
          quizImage: '이미지 1',
        ),
      ],
    ),

    //
  ];

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainScreen(
        gameData: Future.value(_gameData),
      ),
    );
  }
}
