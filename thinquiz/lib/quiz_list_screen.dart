import 'package:flutter/material.dart';

import 'models/game.dart';
import 'quiz_solution_screen.dart';

class QuizListScreen extends StatelessWidget {
  final Future<List<Game>> _gameData;

  const QuizListScreen({super.key, required Future<List<Game>> gameData})
      : _gameData = gameData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB9BAA3),
      appBar: AppBar(
        backgroundColor: Color(0xFF003049),
        title: const Text(
          '문제 리스트',
          style: TextStyle(
            color: Color(0xFFD6D5C9),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 4,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: FutureBuilder<List<Game>>(
            future: _gameData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('오류 발생: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('데이터가 없습니다.'));
              } else {
                final allQuizzes = snapshot.data!.first.quizList;
                return ListView.builder(
                  itemCount: allQuizzes.length,
                  itemBuilder: (context, index) {
                    final quiz = allQuizzes[index];
                    // TODO: 나중에 status 이름 변경 시 수정 필요
                    final isCorrect = quiz.status == 'correct';

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: isCorrect ? Color(0xFFD6D5C9) : Colors.grey,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 16,
                          ),
                          title: Text(quiz.title),
                          subtitle: Text(
                            isCorrect
                                ? '정답 : ${quiz.answer}'
                                : '정답을 맞추면 해설을 볼 수 있습니다.',
                          ),
                          trailing: Icon(isCorrect ? Icons.check : Icons.lock),
                          onTap: () {
                            if (isCorrect == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuizSolutionScreen(
                                          gameData: _gameData,
                                          quizTitle: quiz.title,
                                        )),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
