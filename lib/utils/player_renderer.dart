import 'package:flutter/material.dart';
import '../models/player.dart';

/// Handles rendering of the player
class PlayerRenderer {
  static void render(Canvas canvas, Player player) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(player.position, player.radius, paint);
  }
}
