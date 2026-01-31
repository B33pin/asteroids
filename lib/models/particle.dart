import 'dart:ui';
import 'dart:math';

class Particle {
  Offset position;
  Offset velocity;
  final double radius;
  final int sides;
  final double rotation;
  final List<Offset> shapeVertices;
  final bool isCircle;

  Particle({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.sides,
    required this.rotation,
    this.isCircle = false,
    Random? random,
  }) : shapeVertices = isCircle
           ? _generateCircleVertices(radius)
           : _generateIrregularPolygonVertices(
               radius,
               sides,
               rotation,
               random ?? Random(),
             );

  static List<Offset> _generateCircleVertices(double radius) {
    // generate smooth circle with many points
    final vertices = <Offset>[];
    const circlePoints = 20;
    for (int i = 0; i < circlePoints; i++) {
      final angle = (2 * pi * i / circlePoints);
      vertices.add(Offset(cos(angle) * radius, sin(angle) * radius));
    }
    return vertices;
  }

  static List<Offset> _generateIrregularPolygonVertices(
    double radius,
    int sides,
    double rotation,
    Random random,
  ) {
    final vertices = <Offset>[];
    for (int i = 0; i < sides; i++) {
      final angle = (2 * pi * i / sides) + rotation;
      // vary each vertex radius by 40-100% of base radius for irregular shape
      final vertexRadius = radius * (0.4 + random.nextDouble() * 0.6);
      vertices.add(
        Offset(cos(angle) * vertexRadius, sin(angle) * vertexRadius),
      );
    }
    return vertices;
  }

  void update(double dt) {
    position = Offset(
      position.dx + velocity.dx * dt,
      position.dy + velocity.dy * dt,
    );
  }
}
