class Pokemon {
  final String name;
  final String imageUrl;
  final List types;
  final int height;
  final int weight;
  final int hp;
  final List abilities;

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.hp,
    required this.abilities,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
      types: json['types'],
      height: json['height'],
      weight: json['weight'],
      hp: json['stats'][0]['base_stat'],
      abilities: json['abilities'],
    );
  }
}
