import 'dart:ui';
import 'dart:math';

enum ParticleShape { circle, polygon }

class Particle {
  Offset position;
  Offset velocity;
  final double radius;
  final ParticleShape shape;
  final List<double> shapeData; // pre-generated shape so it doesn't morph

  Particle({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.shape,
    required this.shapeData,
  });

  void update(double dt) {
    position = Offset(
      position.dx + velocity.dx * dt,
      position.dy + velocity.dy * dt,
    );
  }

  static Particle create({
    required Offset position,
    required Offset velocity,
    required double radius,
    required Random random,
  }) {
    // random shape: circle or polygon
    final shape = random.nextBool()
        ? ParticleShape.circle
        : ParticleShape.polygon;

    final shapeData = <double>[];
    if (shape == ParticleShape.polygon) {
      final vertices = 8;
      for (int i = 0; i < vertices; i++) {
        shapeData.add(0.75 + random.nextDouble() * 0.25);
      }
    }

    return Particle(
      position: position,
      velocity: velocity,
      radius: radius,
      shape: shape,
      shapeData: shapeData,
    );
  }
}
