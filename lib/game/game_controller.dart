import 'dart:ui';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/player.dart';
import '../models/particle.dart';
import '../constants/game_constants.dart';

class GameController extends ChangeNotifier {
  late Player player;
  List<Particle> particles = [];
  final int particleCount;
  final double minSpeed;
  final double maxSpeed;
  final Random _random = Random();

  GameController({
    required this.particleCount,
    required this.minSpeed,
    required this.maxSpeed,
  }) {
    init();
  }

  void init() {
    player = Player(position: const Offset(400, 300));
    _spawnParticles();
  }

  void _spawnParticles() {
    particles.clear();
    for (int i = 0; i < particleCount; i++) {
      _createParticle();
    }
  }

  void _createParticle() {
    final x = _random.nextDouble() * GameConstants.screenWidth;
    final y = _random.nextDouble() * GameConstants.screenHeight;
    final radius =
        GameConstants.minParticleSize +
        _random.nextDouble() *
            (GameConstants.maxParticleSize - GameConstants.minParticleSize);

    final speed = minSpeed + _random.nextDouble() * (maxSpeed - minSpeed);
    final angle = _random.nextDouble() * 2 * pi;
    final velocity = Offset(cos(angle) * speed, sin(angle) * speed);

    particles.add(
      Particle.create(
        position: Offset(x, y),
        velocity: velocity,
        radius: radius,
        random: _random,
      ),
    );
  }

  void update(double dt) {
    for (var particle in particles) {
      particle.update(dt);
    }

    _handleScreenBoundaries();

    notifyListeners();
  }

  void _handleScreenBoundaries() {
    for (var particle in particles) {
      if (GameConstants.screenWrap) {
        // teleport to other side and change angle slightly
        if (particle.position.dx < -particle.radius) {
          particle.position = Offset(
            GameConstants.screenWidth + particle.radius,
            particle.position.dy,
          );
          _addRandomAngleVariation(particle);
        } else if (particle.position.dx >
            GameConstants.screenWidth + particle.radius) {
          particle.position = Offset(-particle.radius, particle.position.dy);
          _addRandomAngleVariation(particle);
        }

        if (particle.position.dy < -particle.radius) {
          particle.position = Offset(
            particle.position.dx,
            GameConstants.screenHeight + particle.radius,
          );
          _addRandomAngleVariation(particle);
        } else if (particle.position.dy >
            GameConstants.screenHeight + particle.radius) {
          particle.position = Offset(particle.position.dx, -particle.radius);
          _addRandomAngleVariation(particle);
        }
      } else {
        // bounce off walls with a bit of randomness
        if (particle.position.dx - particle.radius < 0 ||
            particle.position.dx + particle.radius >
                GameConstants.screenWidth) {
          particle.velocity = Offset(
            -particle.velocity.dx,
            particle.velocity.dy,
          );
          _addSmallAngleVariation(particle);
          // Clamp position to keep particle on screen
          particle.position = Offset(
            particle.position.dx.clamp(
              particle.radius,
              GameConstants.screenWidth - particle.radius,
            ),
            particle.position.dy,
          );
        }

        if (particle.position.dy - particle.radius < 0 ||
            particle.position.dy + particle.radius >
                GameConstants.screenHeight) {
          particle.velocity = Offset(
            particle.velocity.dx,
            -particle.velocity.dy,
          );
          _addSmallAngleVariation(particle);
          // keep it from getting stuck in the wall
          particle.position = Offset(
            particle.position.dx,
            particle.position.dy.clamp(
              particle.radius,
              GameConstants.screenHeight - particle.radius,
            ),
          );
        }
      }
    }
  }

  void _addRandomAngleVariation(Particle particle) {
    // change direction by up to ±30 degrees
    final currentSpeed = sqrt(
      particle.velocity.dx * particle.velocity.dx +
          particle.velocity.dy * particle.velocity.dy,
    );
    final currentAngle = atan2(particle.velocity.dy, particle.velocity.dx);

    final angleVariation = (_random.nextDouble() - 0.5) * pi / 3;
    final newAngle = currentAngle + angleVariation;

    particle.velocity = Offset(
      cos(newAngle) * currentSpeed,
      sin(newAngle) * currentSpeed,
    );
  }

  void _addSmallAngleVariation(Particle particle) {
    // smaller variation for bounces, ±10 degrees
    final currentSpeed = sqrt(
      particle.velocity.dx * particle.velocity.dx +
          particle.velocity.dy * particle.velocity.dy,
    );
    final currentAngle = atan2(particle.velocity.dy, particle.velocity.dx);

    final angleVariation = (_random.nextDouble() - 0.5) * pi / 9;
    final newAngle = currentAngle + angleVariation;

    particle.velocity = Offset(
      cos(newAngle) * currentSpeed,
      sin(newAngle) * currentSpeed,
    );
  }

  void updatePlayerPosition(Offset position) {
    player.updatePosition(position);
    notifyListeners();
  }
}
