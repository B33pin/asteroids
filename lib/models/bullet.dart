import 'dart:ui';
import 'dart:math';

class Bullet {
  Offset position;
  final Offset velocity;
  final double radius;

  Bullet({
    required this.position,
    required double speed,
    required double angle,
    this.radius = 3.0,
  }) : velocity = Offset(cos(angle) * speed, sin(angle) * speed);

  void update(double dt) {
    position = Offset(
      position.dx + velocity.dx * dt,
      position.dy + velocity.dy * dt,
    );
  }

  bool isOffScreen(double screenWidth, double screenHeight) {
    return position.dx < -50 ||
        position.dx > screenWidth + 50 ||
        position.dy < -50 ||
        position.dy > screenHeight + 50;
  }
}
