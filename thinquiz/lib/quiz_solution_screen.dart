import 'package:flutter/material.dart';

import 'model/game.dart';
import 'model/quiz.dart';

class QuizSolutionScreen extends StatelessWidget {
  final Future<List<Game>> _gameData;
  final String _quizTitle;
  late Future<Quiz> selectedQuiz;

  QuizSolutionScreen(
      {super.key,
      required Future<List<Game>> gameData,
      required String quizTitle})
      : _gameData = gameData,
        _quizTitle = quizTitle;

  @override
  Widget build(BuildContext context) {
    selectedQuiz = _loadQuizData();
    return Scaffold(
      backgroundColor: Color(0xFFB9BAA3),
      appBar: AppBar(
        backgroundColor: Color(0xFF003049),
        title: const Text(
          '문제 해설',
          style: TextStyle(
            color: Color(0xFFD6D5C9),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 4,
      ),
      body: SafeArea(
          child: FutureBuilder<Quiz>(
              future: selectedQuiz,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('오류 발생: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('데이터가 없습니다.'));
                } else {
                  return Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.9, // 화면 너비의 90%로 설정
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD6D5C9),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text('문제 : ${snapshot.data!.title}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                              if (snapshot.data!.quizImage.isNotEmpty ||
                                  snapshot.data!.quizImage != null)
                                const SizedBox(
                                  height: 10,
                                ),
                              Image.asset(
                                snapshot.data!.quizImage,
                                width: MediaQuery.of(context).size.width * 0.9,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Text('');
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.9, // 화면 너비의 90%로 설정
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD6D5C9),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            '정답 : ${snapshot.data!.answer}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.9, // 화면 너비의 90%로 설정
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD6D5C9),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            '해설 : ${snapshot.data!.solution}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              })),
    );
  }

  Future<Quiz> _loadQuizData() async {
    final gameData = await _gameData;
    final allQuizzes = gameData.first.quizList;
    final quiz = allQuizzes.firstWhere((quiz) => quiz.title == _quizTitle);
    return quiz;
  }
}
