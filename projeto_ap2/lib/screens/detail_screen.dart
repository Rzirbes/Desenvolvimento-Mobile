import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:projeto_ap2/models/pokemon_model.dart';
import 'package:projeto_ap2/utils/pokemon_type_color.dart';
import 'package:projeto_ap2/widgets/pokemon_card/pokemon_types.dart';
import 'package:projeto_ap2/widgets/type_effectiveness.dart';

class PokemonDetailPage extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailPage({super.key, required this.pokemon});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  final Map<String, String> _abilityDescriptions = {};

  @override
  void initState() {
    super.initState();
    fetchAbilityDescriptions();
  }

  Future<void> fetchAbilityDescriptions() async {
    for (var ability in widget.pokemon.abilities) {
      final url = ability['ability']['url'];
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final effectEntries = data['effect_entries'] as List;
        final ptEntry = effectEntries.firstWhere(
          (entry) => entry['language']['name'] == 'pt',
          orElse: () => effectEntries.firstWhere(
            (entry) => entry['language']['name'] == 'en',
            orElse: () => null,
          ),
        );
        if (ptEntry != null) {
          setState(() {
            _abilityDescriptions[ability['ability']['name']] =
                ptEntry['short_effect'];
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;
    final typeColor = PokemonTypeColor.get(pokemon.types.first['type']['name']);

    return Scaffold(
      backgroundColor: typeColor.withAlpha((0.9 * 255).toInt()),
      appBar: AppBar(
        title: Text(pokemon.name.toUpperCase()),
        backgroundColor: typeColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white24),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Nome e HP
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pokemon.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    '${pokemon.hp} HP',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
              const Divider(color: Colors.white24, height: 28),
              Center(child: Image.network(pokemon.imageUrl, height: 180)),
              const SizedBox(height: 20),
              PokemonTypes(types: pokemon.types),
              const Divider(color: Colors.white24, height: 32),

              // Habilidades
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Habilidades:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...pokemon.abilities.map((ability) {
                final name = ability['ability']['name'];
                final description = _abilityDescriptions[name];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.bolt, color: Colors.white70, size: 18),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            if (description != null)
                              Text(
                                description,
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),

              TypeEffectiveness(typeName: pokemon.types.first['type']['name']),
              const Divider(color: Colors.white24, height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text(
                    'Fraqueza: Terra',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Resistência: Metal',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
