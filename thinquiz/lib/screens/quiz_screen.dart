import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinquiz/managers/lucky_card_manager.dart';
import 'package:thinquiz/models/lucky_card.dart';
import 'package:thinquiz/models/quiz.dart';
import 'package:thinquiz/providers/game_provider.dart';
import 'package:thinquiz/screens/lucky_card_screen.dart';
import 'package:thinquiz/screens/memo_screen.dart';
import 'package:thinquiz/screens/result_correct_screen.dart';
import 'package:thinquiz/screens/result_incorrect_screen.dart';
import 'package:thinquiz/services/game_storage_service.dart';

import 'complete_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // _loadSavedGame()이 비동기로 실행되므로 데이터가 로드되기 전에 UI가 먼저 빌드 되어오류 발생 여지가 있음.
    return Consumer<GameProvider>(builder: (context, game, child) {
      if (game.quizItems.isEmpty) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return Scaffold(
        backgroundColor: Color(0xFFB9BAA3),
        appBar: AppBar(
          backgroundColor: Color(0xFF003049),
          title: Text(
            game.quizItems[game.item.quizIndex].title,
            style: TextStyle(
              color: Color(0xFFD6D5C9),
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 4,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("stage:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          for (int i = 0; i < 10; i++)
                            Padding(
                                padding: const EdgeInsets.all(2),
                                child: Transform(
                                    transform: Matrix4.skewX(-0.3),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      color: game.getQuizColor(i),
                                      child: Center(
                                        child: Text(
                                          '${i + 1}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ))),
                        ],
                      )
                    ],
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffd6d5c9),
                    ),
                    child: Center(
                      child: Text('힌트: ${game.hintCount}'),
                    ),
                  ),
                ]),
                SizedBox(height: 10),
                Text('문제', style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffd6d5c9)),
                  child: Center(
                      child: Text(game.quizItems[game.item.quizIndex].content)),
                ),
                SizedBox(height: 10),
                Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xffd6d5c9)),
                    child: Center(
                      child: Image.asset(
                        game.quizItems[game.item.quizIndex].quizImage,
                        width: MediaQuery.of(context).size.width * 0.9,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('');
                        },
                      ),
                    )),
                SizedBox(height: 10),
                Text('풀이', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffd6d5c9)),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Center(
                            child: TextField(
                              maxLines: null,
                              expands: true,
                              keyboardType: TextInputType.multiline,
                              controller: _answerController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  hintText: '정답 작성'),
                            ),
                          ),
                        ))),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xffd6d5c9)),
                            onPressed: () {
                              _showMemoScreen(context);
                            },
                            child: const Text('메모',
                                style: TextStyle(color: Colors.black)))),
                    SizedBox(width: 10),
                    Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xffd6d5c9)),
                            onPressed: () {
                              if (LuckyCardManager().currentCard?.efftect ==
                                  CardEffect.noHint) {
                                _showAlertDialog(context, "힌트를 사용할 수 없습니다.");
                                return;
                              }

                              if (game.hintCount <= 0 &&
                                  !game.quizItems[game.quizIndex].isHintOpen) {
                                _showAlertDialog(context, "남은 힌트가 없습니다.");
                              } else {
                                if (!game
                                    .quizItems[game.quizIndex].isHintOpen) {
                                  game.decreaseHint();
                                  game.quizItems[game.quizIndex].isHintOpen =
                                      true;
                                }

                                _showAlertDialog(context,
                                    game.quizItems[game.quizIndex].hint);
                              }
                            },
                            child: const Text('힌트',
                                style: TextStyle(color: Colors.black)))),
                    SizedBox(width: 10),
                    Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xffd6d5c9)),
                            onPressed: () {
                              if (LuckyCardManager().currentCard?.efftect ==
                                  CardEffect.passOK) {
                                LuckyCardManager().currentCard = null;
                                _handleCorrectAnswer(game);
                              } else {
                                game.quizItems[game.quizIndex].status =
                                    QuizStatus.incorrect;
                                game.increaseQuizIndex();
                                _initStage();

                                // 3,7 스테이지 (행운카드 뽑기)
                                if (game.quizIndex == 2 ||
                                    game.quizIndex == 6) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LuckyCardScreen()));
                                }
                              }
                            },
                            child: const Text('패스',
                                style: TextStyle(color: Colors.black)))),
                    SizedBox(width: 10),
                    Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xffd6d5c9)),
                            onPressed: () {
                              // 정답
                              if (_answerController.text ==
                                  game.quizItems[game.quizIndex].answer) {
                                _handleCorrectAnswer(game);
                              } else {
                                // 오답
                                _handleWrongAnswer(game);
                              }
                            },
                            child: const Text('제출',
                                style: TextStyle(color: Colors.black)))),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  void _initStage() {
    _answerController.text = "";
  }

  void _handleCorrectAnswer(GameProvider game) async {
    game.quizItems[game.quizIndex].status = QuizStatus.correct;

    // 행운카드 - 보너스 점수
    if (LuckyCardManager().currentCard?.efftect == CardEffect.morePoints) {
      game.item.totalPoint += game.quizItems[game.quizIndex].point * 2;
    } else {
      game.item.totalPoint += game.quizItems[game.quizIndex].point;
    }

    _initStage();
    await GameStorageService().saveGame(game.item);
    if (game.quizIndex == 9) {
      Navigator.pushReplacement( context,
          MaterialPageRoute( builder: (context) => QuestCompletedScreen(
                    totalPoint: game.item.totalPoint,
                  )));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ResultScreenCorrect()));
    }
  }

  void _handleWrongAnswer(GameProvider game) async {
    game.quizItems[game.quizIndex].status = QuizStatus.incorrect;
    await GameStorageService().saveGame(game.item);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ResultScreenIncorrect()));
  }

  void _showMemoScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 전체 화면 차지 방지
      barrierColor: Colors.transparent, // 바깥 영역도 투명하게 설정
      backgroundColor: Colors.transparent, // BottomSheet 배경 투명
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(16)), // 둥근 모서리 추가
      ),
      enableDrag: false,
      builder: (context) {
        double screenHeight = MediaQuery.of(context).size.height;
        double bottomSheetHeight =
            screenHeight - kToolbarHeight; // 전체 높이 - AppBar 높이

        return SizedBox(
          height: bottomSheetHeight,
          child: const DrawingScreen(),
        );
      },
    );
  }

  void _showAlertDialog(BuildContext context, String alertText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('힌트'),
          content: Text(alertText),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog 닫기
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
