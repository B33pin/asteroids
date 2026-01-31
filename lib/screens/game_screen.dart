import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../game/game_controller.dart';
import '../widgets/game_painter.dart';
import '../constants/game_constants.dart';

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
  late Timer gameLoop;

  @override
  void initState() {
    super.initState();
    gameController = GameController(
      particleCount: widget.particleCount,
      minSpeed: widget.minSpeed,
      maxSpeed: widget.maxSpeed,
    );
    _startGameLoop();
  }

  void _startGameLoop() {
    const frameDuration = Duration(
      milliseconds: 1000 ~/ GameConstants.targetFPS,
    );
    gameLoop = Timer.periodic(frameDuration, (timer) {
      final dt = frameDuration.inMilliseconds / 1000.0;
      gameController.update(dt);
    });
  }

  @override
  void dispose() {
    gameLoop.cancel();
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
            onTapDown: (details) {
              gameController.shoot();
            },
            child: MouseRegion(
              onHover: (event) {
                gameController.updatePlayerPosition(event.localPosition);
              },
              child: Listener(
                onPointerDown: (event) {
                  gameController.shoot();
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black,
                  child: ListenableBuilder(
                    listenable: gameController,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: GamePainter(
                          player: gameController.player,
                          particles: gameController.particles,
                          bullets: gameController.bullets,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: ListenableBuilder(
              listenable: gameController,
              builder: (context, child) {
                final elapsed = gameController.elapsedTime;
                final minutes = elapsed.inMinutes;
                final seconds = elapsed.inSeconds % 60;
                return Text(
                  '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          ListenableBuilder(
            listenable: gameController,
            builder: (context, child) {
              if (!gameController.isGameOver) return const SizedBox.shrink();

              return Container(
                color: Colors.black.withValues(alpha: 0.7),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Game Over',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'You lasted ${gameController.elapsedTime.inMinutes} minutes ${gameController.elapsedTime.inSeconds % 60} seconds',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          gameController.restart();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: const Text(
                          'Restart',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
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
