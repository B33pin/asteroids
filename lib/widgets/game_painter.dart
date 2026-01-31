import 'package:flutter/material.dart';
import '../models/player.dart';
import '../models/particle.dart';
import '../models/bullet.dart';
import '../utils/player_renderer.dart';
import '../utils/particle_renderer.dart';
import '../utils/bullet_renderer.dart';

class GamePainter extends CustomPainter {
  final Player player;
  final List<Particle> particles;
  final List<Bullet> bullets;

  GamePainter({
    required this.player,
    required this.particles,
    required this.bullets,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Render all particles
    for (var particle in particles) {
      ParticleRenderer.render(canvas, particle);
    }

    // Render all bullets
    for (var bullet in bullets) {
      BulletRenderer.render(canvas, bullet);
    }

    // Render player
    PlayerRenderer.render(canvas, player);
  }

  @override
  bool shouldRepaint(GamePainter oldDelegate) => true;
}
