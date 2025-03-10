import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinquiz/providers/game_provider.dart';

class SolutionScreen extends StatefulWidget {
  const SolutionScreen({super.key});

  @override
  _SolutionScreenState createState() => _SolutionScreenState();
}

class _SolutionScreenState extends State<SolutionScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        return Scaffold(
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false, // 왼쪽 버튼을 없애기 위해 false로 설정
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop(); // X 버튼을 눌렀을 때 아래로 닫기
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          // 이 부분 추가
          child: Padding(
            padding: const EdgeInsets.all(16.0), // 전체 내용에 여백을 추가
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
              children: [
                Container(
                  width: MediaQuery.of(context).size.width, // 화면 너비만큼 설정
                  height: 48, // 높이를 40으로 설정
                  alignment: Alignment.centerLeft,
                  color: Color(0xFFB9BAA3), // 배경색을 설정
                  padding: EdgeInsets.all(8), // 적당한 여백을 추가
                  child: Text(
                    '문제',
                    style: TextStyle(
                      fontSize: 18, // 글자 크기 24
                      color: Colors.black,
                      fontWeight: FontWeight.bold, // 텍스트 색을 설정
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  game.quizItems[game.quizIndex].content,
                  style: TextStyle(fontSize: 18), // 텍스트 크기 조정
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width, // 화면 너비만큼 설정
                  height: 48, // 높이를 40으로 설정
                  alignment: Alignment.centerLeft,
                  color: Color(0xFFB9BAA3), // 배경색을 설정
                  padding: EdgeInsets.all(8), // 적당한 여백을 추가
                  child: Text(
                    '문제 풀이',
                    style: TextStyle(
                      fontSize: 18, // 글자 크기 24
                      color: Colors.black,
                      fontWeight: FontWeight.bold, // 텍스트 색을 설정
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                    game.quizItems[game.quizIndex].answer,
                    style: TextStyle(fontSize: 12))
              ],
            ),
          ),
        ),
      );
      }
    );
  }
}
