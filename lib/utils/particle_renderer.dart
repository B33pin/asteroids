import 'package:flutter/material.dart';
import '../models/particle.dart';

class ParticleRenderer {
  static void render(Canvas canvas, Particle particle) {
    final fillPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.red.shade900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(particle.position, particle.radius, fillPaint);
    canvas.drawCircle(particle.position, particle.radius, strokePaint);
  }
}
