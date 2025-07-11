import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class PokeApiService {
  static const String baseUrl = 'https://pokeapi.co/api/v2/pokemon?limit=100';

  static Future<List<Pokemon>> fetchPokemons({
    int offset = 0,
    int limit = 20,
  }) async {
    final url = 'https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) return [];

    final List results = json.decode(response.body)['results'];
    List<Pokemon> pokemons = [];

    for (var item in results) {
      final detailsResponse = await http.get(Uri.parse(item['url']));
      if (detailsResponse.statusCode == 200) {
        final data = json.decode(detailsResponse.body);
        pokemons.add(Pokemon.fromJson(data));
      }
    }

    return pokemons;
  }

  static Future<Map<String, String>> fetchAbilityDescriptions(
    List abilities,
  ) async {
    final Map<String, String> descriptions = {};

    for (var ability in abilities) {
      final url = ability['ability']['url'];
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final entries = data['effect_entries'] as List;

        final entry = entries.firstWhere(
          (e) => e['language']['name'] == 'pt',
          orElse: () => entries.firstWhere(
            (e) => e['language']['name'] == 'en',
            orElse: () => null,
          ),
        );

        if (entry != null) {
          descriptions[ability['ability']['name']] = entry['short_effect'];
        }
      }
    }

    return descriptions;
  }
}
