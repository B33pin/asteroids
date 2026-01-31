import 'dart:ui';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/player.dart';
import '../models/particle.dart';
import '../models/bullet.dart';
import '../constants/game_constants.dart';

class GameController extends ChangeNotifier {
  late Player player;
  List<Particle> particles = [];
  List<Bullet> bullets = [];
  final int particleCount;
  final double minSpeed;
  final double maxSpeed;
  final Random _random = Random();
  bool isGameOver = false;
  DateTime? _startTime;
  Duration _elapsedTime = Duration.zero;

  Duration get elapsedTime => isGameOver
      ? _elapsedTime
      : (_startTime != null
            ? DateTime.now().difference(_startTime!)
            : Duration.zero);

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
    _startTime = DateTime.now();
    _elapsedTime = Duration.zero;
  }

  void _spawnParticles() {
    particles.clear();
    for (int i = 0; i < particleCount; i++) {
      _createParticle(fromEdge: false);
    }
  }

  void _createParticle({bool fromEdge = true}) {
    double x, y;
    final radius =
        GameConstants.minParticleSize +
        _random.nextDouble() *
            (GameConstants.maxParticleSize - GameConstants.minParticleSize);

    if (fromEdge) {
      // spawn from off-screen edge
      final edge = _random.nextInt(4); // 0=top, 1=right, 2=bottom, 3=left

      switch (edge) {
        case 0: // top
          x = _random.nextDouble() * GameConstants.screenWidth;
          y = -radius - 20;
          break;
        case 1: // right
          x = GameConstants.screenWidth + radius + 20;
          y = _random.nextDouble() * GameConstants.screenHeight;
          break;
        case 2: // bottom
          x = _random.nextDouble() * GameConstants.screenWidth;
          y = GameConstants.screenHeight + radius + 20;
          break;
        case 3: // left
          x = -radius - 20;
          y = _random.nextDouble() * GameConstants.screenHeight;
          break;
        default:
          x = 0;
          y = 0;
      }
    } else {
      // initial spawn anywhere on screen (away from player)
      do {
        x = _random.nextDouble() * GameConstants.screenWidth;
        y = _random.nextDouble() * GameConstants.screenHeight;

        final dx = x - player.position.dx;
        final dy = y - player.position.dy;
        final distance = sqrt(dx * dx + dy * dy);

        // ensure asteroid spawns at least 100 pixels away from player
        if (distance > 100 + radius + player.radius) {
          break;
        }
      } while (true);
    }

    final speed = minSpeed + _random.nextDouble() * (maxSpeed - minSpeed);
    final angle = _random.nextDouble() * 2 * pi;
    final velocity = Offset(cos(angle) * speed, sin(angle) * speed);

    particles.add(
      Particle(position: Offset(x, y), velocity: velocity, radius: radius),
    );
  }

  void update(double dt) {
    if (isGameOver) return;

    for (var particle in particles) {
      particle.update(dt);
    }

    for (var bullet in bullets) {
      bullet.update(dt);
    }

    _handleScreenBoundaries();
    _checkCollisions();
    _checkBulletCollisions();
    _removeOffScreenBullets();

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

  void _checkCollisions() {
    for (var particle in particles) {
      final dx = player.position.dx - particle.position.dx;
      final dy = player.position.dy - particle.position.dy;
      final distance = sqrt(dx * dx + dy * dy);

      if (distance < (player.radius + particle.radius)) {
        isGameOver = true;
        if (_startTime != null) {
          _elapsedTime = DateTime.now().difference(_startTime!);
        }
        notifyListeners();
        return;
      }
    }
  }

  void shoot() {
    bullets.add(
      Bullet(position: player.position, speed: 400.0, angle: player.rotation),
    );
    notifyListeners();
  }

  void _checkBulletCollisions() {
    final bulletsToRemove = <Bullet>[];
    final particlesToRemove = <Particle>[];

    for (var bullet in bullets) {
      for (var particle in particles) {
        final dx = bullet.position.dx - particle.position.dx;
        final dy = bullet.position.dy - particle.position.dy;
        final distance = sqrt(dx * dx + dy * dy);

        if (distance < (bullet.radius + particle.radius)) {
          bulletsToRemove.add(bullet);
          particlesToRemove.add(particle);
          break;
        }
      }
    }

    bullets.removeWhere((b) => bulletsToRemove.contains(b));
    particles.removeWhere((p) => particlesToRemove.contains(p));

    // spawn new particles to maintain particle count
    for (int i = 0; i < particlesToRemove.length; i++) {
      _createParticle();
    }
  }

  void _removeOffScreenBullets() {
    bullets.removeWhere(
      (bullet) => bullet.isOffScreen(
        GameConstants.screenWidth,
        GameConstants.screenHeight,
      ),
    );
  }

  void restart() {
    isGameOver = false;
    bullets.clear();
    init();
  }

  void updatePlayerPosition(Offset position) {
    player.updatePosition(position);
    notifyListeners();
  }
}
