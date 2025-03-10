import 'package:flutter/material.dart';

class ResultScreenIncorrect extends StatelessWidget {
  const ResultScreenIncorrect({super.key});

  @override
  Widget build(BuildContext context) {
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
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('오답!',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 40),
                    Text('다시 한번 들여다 보고\n정확한 답을 제출해줘.',
                        style: TextStyle(color: Colors.black, fontSize: 24)),
                    SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50, // 버튼 높이
                        decoration: BoxDecoration(
                          color: Color(0xFFB9BAA3), // 버튼 배경색
                          borderRadius: BorderRadius.circular(8), // 버튼 모서리 둥글게
                        ),
                        child: Center(
                          child: Text(
                            '돌아가기',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
