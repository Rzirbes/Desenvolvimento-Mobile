import 'package:flutter/material.dart';
import 'package:projeto_ap2/utils/pokemon_type_color.dart';

class PokemonTypes extends StatelessWidget {
  final List types;

  const PokemonTypes({super.key, required this.types});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      alignment: WrapAlignment.center,
      children: types.map<Widget>((type) {
        final name = type['type']['name'];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: PokemonTypeColor.get(name),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            name.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        );
      }).toList(),
    );
  }


}
