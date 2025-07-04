import 'package:flutter/material.dart';

class PokemonHeader extends StatelessWidget {
  final String name;
  final int hp;

  const PokemonHeader({super.key, required this.name, required this.hp});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name.toUpperCase(),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: 1.2,
          ),
        ),
        Text(
          '$hp HP',
          style: const TextStyle(fontSize: 18, color: Colors.black87),
        ),
      ],
    );
  }
}
