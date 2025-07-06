import 'package:flutter/material.dart';

class PokemonTypeColor {
  static Color get(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'poison':
        return Colors.purple;
      case 'electric':
        return Colors.amber;
      case 'psychic':
        return Colors.pinkAccent;
      case 'flying':
        return Colors.grey;
      default:
        return Colors.teal;
    }
  }

  static LinearGradient getGradient(String type) {
    final base = get(type);
    final baseTwo = get(type);
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: const [0.0, 0.9],
      colors: [
        base.withAlpha((0.85 * 255).toInt()), // 85% opacidade
        baseTwo.withAlpha((0.22 * 255).toInt()), // 25% opacidade
      ],
    );
  }
}
