import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinquiz/main_screen.dart';

import '../models/game.dart';
import '../providers/game_provider.dart';
import '../services/game_storage_service.dart' show GameStorageService;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         fontFamily: 'Times New Roman', // 고급스러운 느낌의 서체 사용
//         primarySwatch: Colors.blue,
//       ),
//       home: QuestCompletedScreen(),
//     );
//   }
// }

class QuestCompletedScreen extends StatelessWidget {
  final int totalPoint;
  const QuestCompletedScreen({super.key, required this.totalPoint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // 부드러운 배경 색상
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 350,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 4),
                  blurRadius: 6,
                ),
              ],
              border: Border.all(
                color: Colors.amber, // 금색 테두리
                width: 2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.assignment_turned_in,
                  color: Colors.orangeAccent,
                  size: 80,
                ),
                SizedBox(height: 20),
                Text(
                  '퀘스트 완료!',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '축하합니다! 퀘스트를 완료했습니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('진행 상황 초기화'),
                                content: Text('모든 진행 상황이 초기화 됩니다. 계속 하시겠습니까?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: Text('취소'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: Text('초기화'),
                                  ),
                                ],
                              ),
                            ) ??
                            // Dialog 외부 터치 시 null을 반환하므로 false로 처리
                            false;
                        if (confirmed) {
                          final gameProvider =
                              Provider.of<GameProvider>(context, listen: false);
                          await gameProvider.clearGame();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen(
                                        gameData: Future.value([]),
                                      )));
                        } else {
                          final GameStorageService _storageService =
                              GameStorageService();

                          // Game? savedGame = await _storageService.loadGame();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen(
                                        gameData: _storageService
                                            .loadGame()
                                            .then((game) =>
                                                game == null ? [] : [game]),
                                      )));
                        }
                        // 버튼 클릭 시 실행될 코드
                        print('메인으로 이동');
                      },
                      style: TextButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // 버튼 모서리 둥글게
                        ),
                      ),
                      child: Text(
                        '메인이동',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // 텍스트 색상
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
