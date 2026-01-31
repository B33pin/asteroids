## Project Structure Overview

### Directory Organization

```
asteroids/
├── lib/
│   ├── main.dart                     # Entry point
│   ├── constants/
│   │   └── game_constants.dart       # Game configuration
│   ├── models/
│   │   ├── game_object.dart          # Base game object
│   │   ├── spaceship.dart            # Player spaceship
│   │   ├── asteroid.dart             # Asteroid entities
│   │   └── bullet.dart               # Bullet projectiles
│   ├── game/
│   │   └── game_controller.dart      # Game state & logic
│   ├── screens/
│   │   ├── home_screen.dart          # Main menu
│   │   └── game_screen.dart          # Game screen
│   ├── widgets/
│   │   └── game_painter.dart         # Custom painter
│   └── utils/                         # Utilities (future)
├── assets/
│   ├── images/                        # Images (future)
│   └── sounds/                        # Sounds (future)
├── test/
│   └── widget_test.dart              # Tests
└── pubspec.yaml                       # Dependencies

```

### Architecture Layers

1. **Constants Layer**
   - Game configuration values
   - Easily tunable parameters

2. **Models Layer** 
   - Pure Dart classes
   - Game entity logic
   - Physics and collision detection

3. **Game Layer**
   - Game state management
   - Game loop coordination
   - Collision handling

4. **Presentation Layer**
   - Flutter widgets
   - Custom rendering
   - User input handling

### Key Design Principles

- **Separation of Concerns**: Each layer has a specific responsibility
- **Single Responsibility**: Each class has one clear purpose
- **Reusability**: Base classes for shared functionality
- **Maintainability**: Clear structure for easy updates
- **Testability**: Decoupled logic for unit testing

### File Responsibilities

#### constants/game_constants.dart
- All game configuration values
- Screen dimensions
- Object properties
- Game mechanics settings

#### models/game_object.dart
- Abstract base class for all game entities
- Shared collision detection
- Screen wrapping logic

#### models/spaceship.dart
- Player ship behavior
- Movement and rotation
- Acceleration logic

#### models/asteroid.dart
- Asteroid behavior
- Splitting logic
- Random movement

#### models/bullet.dart
- Bullet behavior
- Lifetime tracking

#### game/game_controller.dart
- Central game state
- Game loop updates
- Collision detection
- Score and lives management
- Spawning logic

#### screens/home_screen.dart
- Main menu UI
- Navigation to game

#### screens/game_screen.dart
- Game rendering
- Input handling
- HUD display
- Game over/pause UI

#### widgets/game_painter.dart
- Custom canvas rendering
- Drawing all game objects
- Vector-style graphics

### Next Steps

1. Add sound effects
2. Implement particle effects
3. Add power-ups
4. Save high scores
5. Add mobile touch controls
6. Create additional levels
7. Improve graphics
