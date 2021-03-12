import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_lives_counter/screens/game_screen.dart';

Future<void> main() async {
  setFullscreenApp();
  runApp(ProviderScope(child: GameApp()));
}

void setFullscreenApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIOverlays([]);
}

class GameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game lives',
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}
