class GameConstants {
  // Screen dimensions
  static const double screenWidth = 800.0;
  static const double screenHeight = 600.0;

  // Particle configuration
  static const int defaultParticleCount = 20;
  static const double minParticleSize = 10.0;
  static const double maxParticleSize = 50.0;
  static const double minParticleSpeed = 20.0;
  static const double maxParticleSpeed = 100.0;

  // Player configuration
  static const double playerSize = 10.0;

  // if true, asteroids wrap around edges. if false, they bounce
  static const bool screenWrap = true;

  // Game loop
  static const int targetFPS = 60;
}
