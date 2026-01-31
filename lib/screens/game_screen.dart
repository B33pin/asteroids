import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../game/level_controller.dart';
import '../widgets/game_painter.dart';

class GameScreen extends StatefulWidget {
  final int particleCount;
  final double minSpeed;
  final double maxSpeed;

  const GameScreen({
    super.key,
    required this.particleCount,
    required this.minSpeed,
    required this.maxSpeed,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameController gameController;

  @override
  void initState() {
    super.initState();
    gameController = GameController(
      particleCount: widget.particleCount,
      minSpeed: widget.minSpeed,
      maxSpeed: widget.maxSpeed,
    );
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
      body: Stack(
        children: [
          GestureDetector(
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
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              icon: const Icon(
                CupertinoIcons.xmark,
                color: Colors.white,
                size: 18,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
