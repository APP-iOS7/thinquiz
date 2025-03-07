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
          status: 'correct',
          quizImage: '이미지 1',
        ),
        Quiz(
          title: '퀴즈 2',
          point: 20,
          hint: '힌트 2',
          content: '내용 2',
          answer: '정답 2',
          solution: '해설 2',
          status: 'wrong',
          quizImage: '이미지 2',
        ),
        Quiz(
          title: '퀴즈 3',
          point: 30,
          hint: '힌트 3',
          content: '내용 3',
          answer: '정답 3',
          solution: '해설 3',
          status: 'pass',
          quizImage: '이미지 3',
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
