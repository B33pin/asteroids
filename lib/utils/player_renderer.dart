import 'package:flutter/material.dart';
import 'dart:math';
import '../models/player.dart';

class PlayerRenderer {
  static void render(Canvas canvas, Player player) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeJoin = StrokeJoin.miter;

    final angle = player.rotation;
    final pos = player.position;

    // classic arrow cursor shape
    // tip at front, two back corners, and a notch
    final tip = _rotatePoint(pos, 0, -12, angle);
    final backLeft = _rotatePoint(pos, -8, 10, angle);
    final notch = _rotatePoint(pos, 0, 4, angle);
    final backRight = _rotatePoint(pos, 8, 10, angle);

    final path = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(backLeft.dx, backLeft.dy)
      ..lineTo(notch.dx, notch.dy)
      ..lineTo(backRight.dx, backRight.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  static Offset _rotatePoint(Offset center, double x, double y, double angle) {
    // rotate point (x, y) around center by angle
    final cosA = cos(angle + pi / 2);
    final sinA = sin(angle + pi / 2);
    return Offset(
      center.dx + x * cosA - y * sinA,
      center.dy + x * sinA + y * cosA,
    );
  }
}
