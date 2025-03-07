import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
