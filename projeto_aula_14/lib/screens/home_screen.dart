import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pokemon_provider.dart';
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PokemonProvider>(context, listen: false).loadPokemons();
    });

    _searchController.addListener(() {
      Provider.of<PokemonProvider>(
        context,
        listen: false, 
      ).searchPokemons(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokemonProvider>(context);

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
                  child: provider.selectedPokemon != null
                      ? PokemonDetailOverlay(
                          key: ValueKey(provider.selectedPokemon!.name),
                          pokemon: provider.selectedPokemon!,
                          onClose: provider.clearSelection,
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
                    onChanged: (_) {},
                    hintText: 'Buscar Pokémon...',
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 200) {
                        if (provider.hasMore && !provider.isLoadingMore) {
                          provider.loadMorePokemons();
                        }
                      }
                      return false;
                    },
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      padding: const EdgeInsets.all(8),
                      children: [
                        ...provider.filteredPokemons.map(
                          (p) => PokemonCard(
                            pokemon: p,
                            onTap: () => provider.selectPokemon(p),
                          ),
                        ),
                        if (provider.isLoadingMore)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    ),
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
