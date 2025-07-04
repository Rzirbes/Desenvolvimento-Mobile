import 'package:flutter/material.dart';

class DetailsButton extends StatelessWidget {
  final VoidCallback onTap;

  const DetailsButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.info_outline, color: Colors.white, size: 12),
      label: const Text(
        'Mais detalhes',
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      ),
    );
  }
}
