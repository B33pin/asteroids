import 'dart:ui';

/// Player - a ball that follows the mouse
class Player {
  Offset position;
  final double radius;

  Player({required this.position, this.radius = 10.0});

  void updatePosition(Offset newPosition) {
    position = newPosition;
  }
}
