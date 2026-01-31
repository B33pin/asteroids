import 'package:flutter/material.dart';
import '../models/player.dart';

class GamePainter extends CustomPainter {
  final Player player;

  GamePainter({required this.player});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(player.position, player.radius, paint);
  }

  @override
  bool shouldRepaint(GamePainter oldDelegate) => true;
}
