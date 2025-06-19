import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pokemon_model.dart';
import '../providers/pokemon_detail_provider.dart';
import '../utils/pokemon_type_color.dart';
import '../widgets/pokemon_card/pokemon_types.dart';
import '../widgets/pokemon_detail/pokemon_abilities.dart';
import '../widgets/pokemon_detail/pokemon_header.dart';
import '../widgets/pokemon_detail/pokemon_weakness_resistance_row.dart';
import '../widgets/type_effectiveness.dart';

class PokemonDetailPage extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PokemonDetailProvider(pokemon.abilities),
      child: const PokemonDetailContent(),
    );
  }
}

class PokemonDetailContent extends StatelessWidget {
  const PokemonDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokemonDetailProvider>(context);
    final pokemon =
        (context.findAncestorWidgetOfExactType<PokemonDetailPage>()!).pokemon;
    final typeColor = PokemonTypeColor.get(pokemon.types.first['type']['name']);

    Widget content;

    if (provider.isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else if (provider.errorMessage != null) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              provider.errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: provider.fetchAbilityDescriptions,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    } else {
      content = SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    typeColor.withAlpha(255),
                    Colors.white.withAlpha(230),
                    typeColor.withAlpha(255),
                    Colors.white.withAlpha(230),
                    typeColor.withAlpha(255),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PokemonHeader(name: pokemon.name, hp: pokemon.hp),
                  const Divider(color: Colors.black26, height: 28),
                  Center(child: Image.network(pokemon.imageUrl, height: 180)),
                  const SizedBox(height: 20),
                  PokemonTypes(types: pokemon.types),
                  const Divider(color: Colors.black26, height: 32),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Habilidades:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PokemonAbilities(
                    abilities: pokemon.abilities,
                    descriptions: provider.abilityDescriptions,
                  ),
                  const SizedBox(height: 20),
                  TypeEffectiveness(
                    typeName: pokemon.types.first['type']['name'],
                  ),
                  const Divider(color: Colors.black26, height: 32),
                  const PokemonWeaknessResistanceRow(),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: content),
    );
  }
}
