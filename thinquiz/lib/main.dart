import 'package:flutter/material.dart';

import 'main_screen.dart';
import 'model/game.dart';
import 'services/game_storage_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GameStorageService _storageService = GameStorageService();
  MyApp({super.key});

  Future<List<Game>> _loadGameData() async {
    Game? savedGame = await _storageService.loadGame();
    if (savedGame == null) {
      // 데이터 임시 생성
      // await _storageService.saveGame(_defaultGameData);
      // return [_defaultGameData];
      return [];
    }
    return [savedGame];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF003049)),
        useMaterial3: true,
      ),
      home: MainScreen(
        gameData: _loadGameData(),
      ),
    );
  }
}
