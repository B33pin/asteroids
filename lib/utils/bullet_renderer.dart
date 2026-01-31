import 'package:flutter/material.dart';
import '../models/bullet.dart';

class BulletRenderer {
  static void render(Canvas canvas, Bullet bullet) {
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    canvas.drawCircle(bullet.position, bullet.radius, paint);
  }
}
