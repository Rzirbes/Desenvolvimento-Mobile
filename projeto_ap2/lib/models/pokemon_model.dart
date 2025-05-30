class Pokemon {
  final String name;
  final String imageUrl;
  final List types;
  final int height; 
  final int weight; 

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      imageUrl: json['sprites']['front_default'] ?? '',
      types: json['types'],
      height: json['height'],
      weight: json['weight'],
    );
  }
}
