import 'package:flutter/material.dart';

class PokemonWeaknessResistanceRow extends StatelessWidget {
  const PokemonWeaknessResistanceRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Text('Fraqueza: Terra', style: TextStyle(color: Colors.black)),
        Text('Resistência: Metal', style: TextStyle(color: Colors.black)),
      ],
    );
  }
}
