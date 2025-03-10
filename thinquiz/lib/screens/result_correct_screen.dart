import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinquiz/managers/lucky_card_manager.dart';
import 'package:thinquiz/models/lucky_card.dart';
import 'package:thinquiz/providers/game_provider.dart';
import 'package:thinquiz/screens/lucky_card_screen.dart';
import './solution_screen.dart';

class ResultScreenCorrect extends StatelessWidget {
  const ResultScreenCorrect({super.key});

  void _showSolutionScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 전체 화면 차지 방지
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.9, // 화면 높이의 90%로 설정
        child: const SolutionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, game, child) {
      return MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Container(
                  color: Color(0xFFA22C29),
                  child: Center(
                    child: Text('정답',
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text('획득한 점수', style: TextStyle(fontSize: 20)),
                          Expanded(child: SizedBox(width: double.infinity)),
                          Text(
                              LuckyCardManager().currentCard?.efftect ==
                                      CardEffect.morePoints
                                  ? '${game.quizItems[game.quizIndex].point * 2}(${game.quizItems[game.quizIndex].point}X2)'
                                  : '${game.quizItems[game.quizIndex].point}',
                              style: TextStyle(
                                  fontSize: 48, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Text('총 점수', style: TextStyle(fontSize: 20)),
                          Expanded(
                              child: SizedBox(
                                  width: double
                                      .infinity)), // SizedBox를 최대 크기로 확장),
                          Text('${game.totalPoint}',
                              style: TextStyle(
                                  fontSize: 48, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // '해설보기' 버튼 클릭 시 동작
                                _showSolutionScreen(context);
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
                                    '해설보기',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8), // 버튼 사이 간격 8

                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                LuckyCardManager().currentCard = null;
                                game.increaseQuizIndex();

                                // 3,7 스테이지 (행운카드 뽑기)
                                if (game.quizIndex == 2 ||
                                    game.quizIndex == 6) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LuckyCardScreen()));
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                height: 50, // 버튼 높이
                                decoration: BoxDecoration(
                                  color: Color(0xFFB9BAA3), // 버튼 배경색
                                  borderRadius:
                                      BorderRadius.circular(8), // 버튼 모서리 둥글게
                                ),
                                child: Center(
                                  child: Text(
                                    '다음문제',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
