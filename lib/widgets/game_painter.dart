import 'package:flutter/material.dart';
import '../models/player.dart';
import '../models/particle.dart';
import '../utils/player_renderer.dart';
import '../utils/particle_renderer.dart';

class GamePainter extends CustomPainter {
  final Player player;
  final List<Particle> particles;

  GamePainter({required this.player, required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    // Render all particles
    for (var particle in particles) {
      ParticleRenderer.render(canvas, particle);
    }

    // Render player
    PlayerRenderer.render(canvas, player);
  }

  @override
  bool shouldRepaint(GamePainter oldDelegate) => true;
}
