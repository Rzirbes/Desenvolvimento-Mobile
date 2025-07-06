import 'package:flutter/material.dart';
import 'package:projeto_as/widgets/logout_menu_butto.dart';
import 'package:provider/provider.dart';
import '../providers/pokemon_provider.dart';
import '../utils/pokemon_type_color.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          decoration: provider.selectedPokemon != null
              ? BoxDecoration(
                  gradient: PokemonTypeColor.getGradient(
                    provider.selectedPokemon!.types.first['type']['name'],
                  ),
                )
              : BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                ),

          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Pokédex'),
            actions: const [LogoutMenuButton()],
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/background.png', fit: BoxFit.cover),
          SafeArea(
            child: Column(
              children: [
                if (provider.selectedPokemon != null)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: PokemonDetailOverlay(
                      key: ValueKey(provider.selectedPokemon!.name),
                      pokemon: provider.selectedPokemon!,
                      onClose: provider.clearSelection,
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
