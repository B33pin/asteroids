import 'dart:ui';
import 'package:flutter/foundation.dart';
import '../models/player.dart';

/// Controller for managing game state
class GameController extends ChangeNotifier {
  late Player player;

  GameController() {
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
