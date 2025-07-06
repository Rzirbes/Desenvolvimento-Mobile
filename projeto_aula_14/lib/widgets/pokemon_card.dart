import 'package:flutter/material.dart';
import 'package:projeto_as/utils/pokemon_type_color.dart';
import 'package:projeto_as/widgets/details_button.dart';
import '../models/pokemon_model.dart';
import 'pokemon_card/pokemon_image.dart';
import 'pokemon_card/pokemon_name.dart';
import 'pokemon_card/pokemon_types.dart';
import 'pokemon_card/pokemon_stats.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;

  const PokemonCard({super.key, required this.pokemon, required this.onTap});

  String formatHeight(num h) => '${(h / 10).toStringAsFixed(1)} M';
  String formatWeight(num w) => '${(w / 10).toStringAsFixed(1)} KG';

  @override
  Widget build(BuildContext context) {
    final primaryType = pokemon.types.first['type']['name'];
    final baseColor = PokemonTypeColor.get(primaryType);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              baseColor.withAlpha((0.5 * 255).toInt()),
              Colors.black.withAlpha((0.2 * 255).toInt()),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            PokemonImage(imageUrl: pokemon.imageUrl),
            const SizedBox(height: 12),
            PokemonName(name: pokemon.name),
            const SizedBox(height: 4),
            PokemonTypes(types: pokemon.types),
            const SizedBox(height: 2),
            PokemonStats(
              height: formatHeight(pokemon.height),
              weight: formatWeight(pokemon.weight),
            ),
            const SizedBox(height: 2),
            DetailsButton(onTap: onTap),
          ],
        ),
      ),
    );
  }
}
