import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinquiz/managers/lucky_card_manager.dart';
import 'package:thinquiz/models/lucky_card.dart';
import 'package:thinquiz/models/quiz.dart';
import 'package:thinquiz/providers/game_provider.dart';
import 'package:thinquiz/screens/result_incorrect_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (LuckyCardManager().currentCard?.efftect == CardEffect.moreHint) {
        Provider.of<GameProvider>(context, listen: false).increaseHint();
        LuckyCardManager().currentCard = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, game, child) {
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
                    child: Center(child: const Text('그림영역'))),
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
                            onPressed: () {},
                            child: const Text('메모',
                                style: TextStyle(color: Colors.black)))),
                    SizedBox(width: 10),
                    Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xffd6d5c9)),
                            onPressed: () {},
                            child: const Text('힌트',
                                style: TextStyle(color: Colors.black)))),
                    SizedBox(width: 10),
                    Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xffd6d5c9)),
                            onPressed: () {
                              game.quizItems[game.quizIndex].status =
                                  QuizStatus.pending;

                              if (LuckyCardManager().currentCard?.efftect ==
                                  CardEffect.passOK) {
                                LuckyCardManager().currentCard = null;
                                handleCorrectAnswer(game);
                              }

                              initStage(game);
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
                                handleCorrectAnswer(game);
                              } else {
                                // 오답
                                handleWrongAnswer(game);
                              }

                              initStage(game);
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

  void initStage(GameProvider gameProvider) {
    gameProvider.increaseQuizIndex();
    _answerController.text = "";
    gameProvider.quizItems[gameProvider.quizIndex].status = QuizStatus.solving;
  }

  void handleCorrectAnswer(GameProvider game) {
    game.quizItems[game.quizIndex].status = QuizStatus.correct;

    // 행운카드 - 보너스 점수
    if (LuckyCardManager().currentCard?.efftect == CardEffect.morePoints) {
      game.item.totalPoint += game.quizItems[game.quizIndex].point * 2;
    } else {
      game.item.totalPoint += game.quizItems[game.quizIndex].point;
    }

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ResultScreenCorrect()));
  }

  void handleWrongAnswer(GameProvider game) {
    game.quizItems[game.quizIndex].status = QuizStatus.incorrect;
  }
}
