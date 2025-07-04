import 'package:flutter/material.dart';

class PokemonImage extends StatelessWidget {
  final String imageUrl;

  const PokemonImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: OverflowBox(
        maxHeight: 120,
        alignment: Alignment.topCenter,
        child: Image.network(
          imageUrl,
          height: 100,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
