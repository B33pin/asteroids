import 'dart:ui';
import 'dart:math';

class Player {
  Offset position;
  final double radius;
  double rotation = -pi / 2; // start pointing up

  Player({required this.position, this.radius = 10.0});

  void updatePosition(Offset newPosition) {
    final dx = newPosition.dx - position.dx;
    final dy = newPosition.dy - position.dy;
    final distance = sqrt(dx * dx + dy * dy);

    // only update rotation if movement is significant (prevents flickering)
    if (distance > 2) {
      rotation = atan2(dy, dx);
    }

    position = newPosition;
  }
}
