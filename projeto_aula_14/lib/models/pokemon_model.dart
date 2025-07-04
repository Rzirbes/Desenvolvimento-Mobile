class Pokemon {
  final String name;
  final String imageUrl;
  final List<dynamic> types;
  final int height;
  final int weight;
  final int hp;
  final List<dynamic> abilities;
  final String? url; 

  Pokemon({
    required this.name,
    required this.imageUrl,
    this.types = const [],
    this.height = 0,
    this.weight = 0,
    this.hp = 0,
    this.abilities = const [],
    this.url,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      imageUrl: json['sprites']['front_default'] ?? '',
      types: json['types'] ?? [],
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      hp: json['stats'] != null ? (json['stats'][0]['base_stat'] ?? 0) : 0,
      abilities: json['abilities'] ?? [],
    );
  }
}
