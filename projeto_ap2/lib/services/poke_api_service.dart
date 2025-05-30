import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class PokeApiService {
  static const String baseUrl = 'https://pokeapi.co/api/v2/pokemon?limit=100';

  static Future<List<Pokemon>> fetchPokemons() async {
    final response = await http.get(Uri.parse(baseUrl));

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
}
