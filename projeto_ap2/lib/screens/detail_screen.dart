import 'package:flutter/material.dart';

import 'package:projeto_ap2/models/pokemon_model.dart';
import 'package:projeto_ap2/services/poke_api_service.dart';
import 'package:projeto_ap2/utils/pokemon_type_color.dart';
import 'package:projeto_ap2/widgets/pokemon_card/pokemon_types.dart';
import 'package:projeto_ap2/widgets/pokemon_detail/pokemon_abilities.dart';
import 'package:projeto_ap2/widgets/pokemon_detail/pokemon_header.dart';
import 'package:projeto_ap2/widgets/pokemon_detail/pokemon_weakness_resistance_row.dart';
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
    final descriptions = await PokeApiService.fetchAbilityDescriptions(
      widget.pokemon.abilities,
    );
    setState(() => _abilityDescriptions.addAll(descriptions));
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;
    final typeColor = PokemonTypeColor.get(pokemon.types.first['type']['name']);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botão voltar
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
                    // Nome e HP
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
                      descriptions: _abilityDescriptions,
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
        ),
      ),
    );
  }
}
