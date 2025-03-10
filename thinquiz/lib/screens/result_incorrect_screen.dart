// 오답화면
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinquiz/managers/lucky_card_manager.dart';
import 'package:thinquiz/providers/game_provider.dart';
import 'package:thinquiz/screens/lucky_card_screen.dart';

class ResultScreenIncorrect extends StatelessWidget {
  const ResultScreenIncorrect({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, game, child) {
      return MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Container(
                  color: Color(0xFF003049),
                  child: Center(
                    child: Text('오답',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 72,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Color(0xFFD6D5C9),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(24),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 50, // 버튼 높이
                              decoration: BoxDecoration(
                                color: Colors.white, // 버튼 배경색
                                borderRadius:
                                    BorderRadius.circular(8), // 버튼 모서리 둥글게
                                border: Border.all(
                                  color: Color(0xFFB9BAA3), // 테두리 색상
                                  width: 2, // 테두리 두께
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '이대로 다시 도전',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            game.increaseQuizIndex();
                            LuckyCardManager().currentCard = null;

                            // 3,7 스테이지 (행운카드 뽑기)
                            if (game.quizIndex == 2 || game.quizIndex == 6) {
                              game.drawLuckyCard(context);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            height: 50, // 버튼 높이
                            decoration: BoxDecoration(
                              color: Colors.white, // 버튼 배경색
                              borderRadius:
                                  BorderRadius.circular(8), // 버튼 모서리 둥글게
                              border: Border.all(
                                color: Color(0xFFB9BAA3), // 테두리 색상
                                width: 2, // 테두리 두께
                              ),
                            ),
                            child: Container(
                              height: 50, // 버튼 높이
                              decoration: BoxDecoration(
                                color: Color(0xFFB9BAA3), // 버튼 배경색
                                borderRadius:
                                    BorderRadius.circular(8), // 버튼 모서리 둥글게
                              ),
                              child: Center(
                                child: Text(
                                  '다음에 풀기',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
