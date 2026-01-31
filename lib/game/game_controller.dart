import 'dart:ui';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/player.dart';
import '../models/particle.dart';
import '../constants/game_constants.dart';

/// Controller for managing game state
class GameController extends ChangeNotifier {
  late Player player;
  List<Particle> particles = [];
  final int particleCount;
  final double minSpeed;
  final double maxSpeed;
  final Random _random = Random();

  GameController({
    required this.particleCount,
    required this.minSpeed,
    required this.maxSpeed,
  }) {
    init();
  }

  void init() {
    player = Player(position: const Offset(400, 300));
    _spawnParticles();
  }

  void _spawnParticles() {
    particles.clear();
    for (int i = 0; i < particleCount; i++) {
      final x = _random.nextDouble() * 800;
      final y = _random.nextDouble() * 600;
      final radius =
          GameConstants.minParticleSize +
          _random.nextDouble() *
              (GameConstants.maxParticleSize - GameConstants.minParticleSize);

      particles.add(Particle(position: Offset(x, y), radius: radius));
    }
  }

  void updatePlayerPosition(Offset position) {
    player.updatePosition(position);
    notifyListeners();
  }
}
