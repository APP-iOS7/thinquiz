import 'package:flutter/material.dart';

import 'model/game.dart';
import 'model/quiz.dart';

class MainScreen extends StatelessWidget {
  final Future<List<Game>> gameData;
  final Future<List<Quiz>> quizData;
  const MainScreen({super.key, required this.gameData, required this.quizData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ThinQuiz')),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              FutureBuilder<List<Game>>(
                future: gameData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('오류 발생: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16), // 텍스트 주위에 패딩 추가
                          decoration: BoxDecoration(
                            color: Color(0xFFD6D5C9), //
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('''
🔍 당신의 지혜와 운을 시험해보세요!
                              
이 앱은 단순한 퀴즈 게임이 아닙니다.
10개의 문제를 풀면서 
당신의 지식과 직감을 시험해 보세요!
하지만 조심하세요… 
게임 중 뜻밖의 기회(?)가 찾아올지도 모릅니다.
마지막까지 도전할 준비가 되었나요? 🎲✨
                ''', textAlign: TextAlign.center),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF902923),
                            foregroundColor: Color(0xFF0A100D),
                          ),
                          child: Text('시작 하기'),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16), // 텍스트 주위에 패딩 추가
                          decoration: BoxDecoration(
                            color: Color(0xFFD6D5C9), //
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                              '진행 상황 ${snapshot.data!.fold(0, (sum, game) => sum + game.totalPoint)}점'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF902923),
                            foregroundColor: Color(0xFF0A100D),
                          ),
                          child: Text('이어 하기'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF003049),
                                  foregroundColor: Color(0xFF0A100D),
                                ),
                                child: Text('맞힌 문제 보기'),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF902923),
                                  foregroundColor: Color(0xFF0A100D),
                                ),
                                child: Text('진행 사항 초기화'),
                              ),
                            ],
                          ),
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
    );
  }
}
