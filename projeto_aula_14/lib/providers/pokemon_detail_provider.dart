import 'package:flutter/material.dart';
import '../services/poke_api_service.dart';

class PokemonDetailProvider extends ChangeNotifier {
  final List abilities;
  Map<String, String> abilityDescriptions = {};
  bool isLoading = true;
  String? errorMessage;

  PokemonDetailProvider(this.abilities) {
    fetchAbilityDescriptions();
  }

  Future<void> fetchAbilityDescriptions() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      abilityDescriptions = await PokeApiService.fetchAbilityDescriptions(
        abilities,
      );
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
