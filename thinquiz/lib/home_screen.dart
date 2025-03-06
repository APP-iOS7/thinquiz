import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final Future<List<dynamic>> data;
  const MainScreen({super.key, required this.data});

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
              Center(
                child: Container(
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
                  child: Text('시작 하기')),
            ],
          ),
        ),
      ),
    );
  }
}
