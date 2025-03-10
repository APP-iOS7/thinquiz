import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';

import 'models/game.dart';
import 'providers/game_provider.dart';
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
      return [];
    }
    return [savedGame];
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => GameProvider())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF003049)),
          useMaterial3: true,
        ),
        home: MainScreen(
          gameData: _loadGameData(),
        ),
      ),
    );
  }
}
