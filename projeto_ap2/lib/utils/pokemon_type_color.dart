
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
}
