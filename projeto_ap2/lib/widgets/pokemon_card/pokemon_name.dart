import 'package:flutter/material.dart';

class PokemonName extends StatelessWidget {
  final String name;

  const PokemonName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      '• ${name.toUpperCase()} •',
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}
