import 'package:flutter/material.dart';
import '../models/pokemon_model.dart';
import '../services/poke_api_service.dart';

class PokemonProvider extends ChangeNotifier {
  List<Pokemon> _pokemons = [];
  List<Pokemon> _filteredPokemons = [];
  Pokemon? _selectedPokemon;
  int _offset = 0;
  final int _limit = 20;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? errorMessage;

  List<Pokemon> get pokemons => _pokemons;
  List<Pokemon> get filteredPokemons => _filteredPokemons;
  Pokemon? get selectedPokemon => _selectedPokemon;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;

  Future<void> loadPokemons() async {
    _offset = 0;
    _pokemons.clear();
    _hasMore = true;
    errorMessage = null;
    await loadMorePokemons();
  }

  Future<void> loadMorePokemons() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    errorMessage = null;
    notifyListeners();

    try {
      final newPokemons = await PokeApiService.fetchPokemons(
        offset: _offset,
        limit: _limit,
      );

      if (newPokemons.isEmpty) {
        _hasMore = false;
      } else {
        _pokemons.addAll(newPokemons);
        _filteredPokemons = List.from(_pokemons);
        _offset += _limit;
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    _isLoadingMore = false;
    notifyListeners();
  }

  void searchPokemons(String query) {
    _filteredPokemons = _pokemons
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void selectPokemon(Pokemon pokemon) {
    _selectedPokemon = pokemon;
    notifyListeners();
  }

  void clearSelection() {
    _selectedPokemon = null;
    notifyListeners();
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }
}
