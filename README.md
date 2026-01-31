# Asteroids Game

A classic Asteroids arcade game built with Flutter.

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── constants/
│   └── game_constants.dart  # Game configuration and constants
├── models/
│   ├── game_object.dart     # Base class for all game objects
│   ├── spaceship.dart       # Player spaceship model
│   ├── asteroid.dart        # Asteroid model
│   └── bullet.dart          # Bullet projectile model
├── game/
│   └── game_controller.dart # Main game logic and state management
├── screens/
│   ├── home_screen.dart     # Home/menu screen
│   └── game_screen.dart     # Main game screen with input handling
├── widgets/
│   └── game_painter.dart    # Custom painter for rendering game objects
└── utils/                    # Utility functions (if needed)

assets/
├── images/                   # Game images and sprites
└── sounds/                   # Game sound effects (future enhancement)
```

## Architecture

The project follows a clean, layered architecture:

1. **Models Layer** (`lib/models/`)
   - Game object representations
   - Business logic for individual entities
   - Collision detection and physics

2. **Game Layer** (`lib/game/`)
   - Game state management
   - Game loop logic
   - Collision handling
   - Score and lives tracking

3. **Presentation Layer** (`lib/screens/` & `lib/widgets/`)
   - UI screens
   - Custom rendering with CustomPainter
   - Input handling

4. **Constants** (`lib/constants/`)
   - Game configuration
   - Tunable parameters

## How to Play

- **Arrow Keys**: Move your spaceship
  - Up: Thrust forward
  - Left/Right: Rotate
- **Space**: Fire bullets
- **P**: Pause game
- **R**: Restart (when game over)

## Features

- Classic asteroids gameplay
- Vector-style graphics
- Smooth physics and movement
- Asteroid splitting mechanics
- Score tracking
- Lives system
- Pause functionality

## Getting Started

1. Ensure Flutter is installed
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the game

## Development

To modify game parameters, edit `lib/constants/game_constants.dart`.

## Future Enhancements

- Sound effects
- Power-ups
- High score persistence
- Multiple levels
- Improved graphics
- Touch/mobile controls
