import 'dart:ui';

class Particle {
  Offset position;
  Offset velocity;
  final double radius;

  Particle({
    required this.position,
    required this.velocity,
    required this.radius,
  });

  void update(double dt) {
    position = Offset(
      position.dx + velocity.dx * dt,
      position.dy + velocity.dy * dt,
    );
  }
}
