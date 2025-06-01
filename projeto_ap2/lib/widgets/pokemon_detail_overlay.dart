import 'package:flutter/material.dart';
import 'package:projeto_ap2/screens/detail_screen.dart';
import 'package:projeto_ap2/utils/pokemon_type_color.dart';
import '../../models/pokemon_model.dart';

class PokemonDetailOverlay extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onClose;

  const PokemonDetailOverlay({
    super.key,
    required this.pokemon,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.28;
    final typeColor = PokemonTypeColor.get(pokemon.types.first['type']['name']);

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ClipPath(
        clipper: BottomCurveClipper(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                typeColor.withAlpha((0.85 * 255).toInt()),
                Colors.black.withAlpha((0.9 * 255).toInt()),
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          pokemon.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Altura: ${(pokemon.height / 10).toStringAsFixed(1)} m',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Peso: ${(pokemon.weight / 10).toStringAsFixed(1)} kg',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 12),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    PokemonDetailPage(pokemon: pokemon),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.info_outline,
                            color: Colors.white,
                            size: 16,
                          ),
                          label: const Text(
                            'Mais detalhes',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.white.withAlpha(
                              (0.2 * 255).toInt(),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.network(
                    pokemon.imageUrl,
                    height: height * 0.8,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: onClose,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);

    path.quadraticBezierTo(
      size.width / 2,
      size.height + 40,
      size.width,
      size.height - 40,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
