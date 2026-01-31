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

    // Draw polygon shape
    final path = Path();
    for (int i = 0; i < particle.shapeVertices.length; i++) {
      final vertex = particle.shapeVertices[i];
      final worldPos = Offset(
        particle.position.dx + vertex.dx,
        particle.position.dy + vertex.dy,
      );

      if (i == 0) {
        path.moveTo(worldPos.dx, worldPos.dy);
      } else {
        path.lineTo(worldPos.dx, worldPos.dy);
      }
    }
    path.close();

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }
}
