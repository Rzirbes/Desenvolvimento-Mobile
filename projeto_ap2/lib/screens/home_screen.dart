import 'package:flutter/material.dart';
import '../models/pokemon_model.dart';
import '../services/poke_api_service.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/search_field.dart';
import '../widgets/pokemon_detail_overlay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Pokemon> pokemons = [];
  List<Pokemon> filteredPokemons = [];
  Pokemon? selectedPokemon;

  @override
  void initState() {
    super.initState();
    loadPokemons();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredPokemons = pokemons
          .where((p) => p.name.toLowerCase().contains(query))
          .toList();
    });
  }

  Future<void> loadPokemons() async {
    try {
      final data = await PokeApiService.fetchPokemons();
      setState(() {
        pokemons = data;
        filteredPokemons = data;
      });
    } catch (e) {
      debugPrint('Erro ao carregar pokémons: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/background.png', fit: BoxFit.cover),
          SafeArea(
            child: Column(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  switchInCurve: Curves.easeOutBack,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    final slide = Tween<Offset>(
                      begin: const Offset(0, 0.2),
                      end: Offset.zero,
                    ).animate(animation);

                    final scale = Tween<double>(
                      begin: 0.95,
                      end: 1.0,
                    ).animate(animation);

                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: slide,
                        child: ScaleTransition(scale: scale, child: child),
                      ),
                    );
                  },
                  child: selectedPokemon != null
                      ? PokemonDetailOverlay(
                          key: ValueKey(selectedPokemon!.name),
                          pokemon: selectedPokemon!,
                          onClose: () => setState(() => selectedPokemon = null),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Pokédex',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SearchField(
                    controller: _searchController,
                    onChanged: (_) => _onSearchChanged(),
                    hintText: 'Buscar Pokémon...',
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    padding: const EdgeInsets.all(8),
                    children: filteredPokemons
                        .map(
                          (p) => PokemonCard(
                            pokemon: p,
                            onTap: () {
                              setState(() {
                                selectedPokemon = p;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
