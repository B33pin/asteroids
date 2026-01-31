import 'package:flutter/material.dart';
import '../constants/game_constants.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double particleCount = GameConstants.defaultParticleCount.toDouble();
  double minSpeed = GameConstants.minParticleSpeed;
  double maxSpeed = GameConstants.maxParticleSpeed;

  void startGame() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(
          particleCount: particleCount.toInt(),
          minSpeed: minSpeed,
          maxSpeed: maxSpeed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Configuration',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                _buildSlider(
                  label: 'Particle Count',
                  value: particleCount,
                  min: 5,
                  max: 50,
                  onChanged: (value) => setState(() => particleCount = value),
                ),
                const SizedBox(height: 24),
                _buildSlider(
                  label: 'Min Speed',
                  value: minSpeed,
                  min: 10,
                  max: 100,
                  onChanged: (value) => setState(() => minSpeed = value),
                ),
                const SizedBox(height: 24),
                _buildSlider(
                  label: 'Max Speed',
                  value: maxSpeed,
                  min: 50,
                  max: 200,
                  onChanged: (value) => setState(() => maxSpeed = value),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('START GAME'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Move your mouse or drag to control the white ball',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              value.toInt().toString(),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          activeColor: Colors.white,
          inactiveColor: Colors.white24,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
