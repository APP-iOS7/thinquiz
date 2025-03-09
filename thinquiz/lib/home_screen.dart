import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinquiz/providers/game_provider.dart';
import 'package:thinquiz/screens/quiz_screen.dart';

import 'models/game.dart';
import 'quiz_list_screen.dart';

class MainScreen extends StatelessWidget {
  final Future<List<Game>> _gameData;

  const MainScreen({super.key, required Future<List<Game>> gameData})
      : _gameData = gameData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB9BAA3),
      appBar: AppBar(
        backgroundColor: Color(0xFF003049),
        title: const Text(
          'ThinQuiz',
          style: TextStyle(
            color: Color(0xFFD6D5C9),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 4,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                FutureBuilder<List<Game>>(
                  future: _gameData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('오류 발생: ${snapshot.error}');
                    }
      
                    /* 진행중인 게임이 없을 때 */
                    else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
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
                            child: const Text(
                              '''
      🔍 당신의 지혜와 운을 시험해보세요!
                                
      이 앱은 단순한 퀴즈 게임이 아닙니다.
      10개의 문제를 풀면서 
      당신의 지식과 직감을 시험해 보세요!
      하지만 조심하세요… 
      게임 중 뜻밖의 기회(?)가 찾아올지도?
      마지막까지 도전할 준비가 되었나요? 🎲✨
                  ''',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                height: 1.4,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFA22C29),
                              foregroundColor: Color(0xFFD6D5C9),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                            ),
                            child: const Text('시작 하기',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      );
                    }
      
                    /* 진행중인 게임이 있을 때 */
                    else {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Color(0xFFD6D5C9),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 3),
                                  )
                                ]),
                            child: Text(
                              '진행 상황: ${snapshot.data!.first.totalPoint}점',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF003049),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuizScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFA22C29),
                              foregroundColor: Color(0xFFD6D5C9),
                              padding: EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                            ),
                            child: const Text(
                              '이어 하기',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 300,
                          ),
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            alignment: WrapAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuizListScreen(
                                              gameData: _gameData,
                                            )),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF003049),
                                  foregroundColor: Color(0xFFD6D5C9),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                ),
                                child: Text(
                                  '문제 보기',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF902923),
                                  foregroundColor: Color(0xFFD6D5C9),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                ),
                                child: Text(
                                  '진행 사항 초기화',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
