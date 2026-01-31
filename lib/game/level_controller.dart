import 'dart:ui';
import 'package:flutter/foundation.dart';
import '../models/player.dart';

/// Controller for managing game state
class GameController extends ChangeNotifier {
  late Player player;
  final int particleCount;
  final double minSpeed;
  final double maxSpeed;

  GameController({
    required this.particleCount,
    required this.minSpeed,
    required this.maxSpeed,
  }) {
    init();
  }

  void init() {
    player = Player(position: const Offset(400, 300));
  }

  void updatePlayerPosition(Offset position) {
    player.updatePosition(position);
    notifyListeners();
  }
}
