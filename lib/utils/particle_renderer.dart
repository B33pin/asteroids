import 'package:flutter/material.dart';
import 'dart:math';
import '../models/particle.dart';

/// Handles rendering of particles as asteroids
class ParticleRenderer {
  static void render(Canvas canvas, Particle particle) {
    final fillPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.red.shade900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    _drawAsteroid(canvas, particle, fillPaint, strokePaint);
  }

  static void _drawAsteroid(
    Canvas canvas,
    Particle particle,
    Paint fillPaint,
    Paint strokePaint,
  ) {
    final path = Path();
    final vertices = 8;
    final random = Random(
      particle.position.dx.toInt() + particle.position.dy.toInt(),
    );

    // For creating slightly irregular asteroid shape
    for (int i = 0; i < vertices; i++) {
      final angle = (i * 2 * pi / vertices);
      final radiusVariation = 0.75 + random.nextDouble() * 0.25;
      final x =
          particle.position.dx + cos(angle) * particle.radius * radiusVariation;
      final y =
          particle.position.dy + sin(angle) * particle.radius * radiusVariation;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, fillPaint);

    canvas.drawPath(path, strokePaint);
  }
}
