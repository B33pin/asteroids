import 'package:flutter/material.dart';
import '../game/level_controller.dart';
import '../widgets/game_painter.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameController gameController;

  @override
  void initState() {
    super.initState();
    gameController = GameController();
  }

  @override
  void dispose() {
    gameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onPanUpdate: (details) {
          gameController.updatePlayerPosition(details.localPosition);
        },
        child: MouseRegion(
          onHover: (event) {
            gameController.updatePlayerPosition(event.localPosition);
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: ListenableBuilder(
              listenable: gameController,
              builder: (context, child) {
                return CustomPaint(
                  painter: GamePainter(player: gameController.player),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
