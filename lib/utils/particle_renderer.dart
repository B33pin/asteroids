import 'package:flutter/material.dart';
import 'dart:math';
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

    if (particle.shape == ParticleShape.circle) {
      _drawCircle(canvas, particle, fillPaint, strokePaint);
    } else {
      _drawPolygon(canvas, particle, fillPaint, strokePaint);
    }
  }

  static void _drawCircle(
    Canvas canvas,
    Particle particle,
    Paint fillPaint,
    Paint strokePaint,
  ) {
    canvas.drawCircle(particle.position, particle.radius, fillPaint);
    canvas.drawCircle(particle.position, particle.radius, strokePaint);
  }

  static void _drawPolygon(
    Canvas canvas,
    Particle particle,
    Paint fillPaint,
    Paint strokePaint,
  ) {
    final path = Path();
    final vertices = particle.shapeData.length;

    for (int i = 0; i < vertices; i++) {
      final angle = (i * 2 * pi / vertices);
      final radiusVariation = particle.shapeData[i];
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
