import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TypeEffectiveness extends StatefulWidget {
  final String typeName;

  const TypeEffectiveness({super.key, required this.typeName});

  @override
  State<TypeEffectiveness> createState() => _TypeEffectivenessState();
}

class _TypeEffectivenessState extends State<TypeEffectiveness> {
  List<String> strongAgainst = [];
  List<String> weakAgainst = [];
  List<String> noEffect = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEffectiveness();
  }

  Future<void> fetchEffectiveness() async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/type/${widget.typeName}'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        strongAgainst = List<String>.from(
          data['damage_relations']['double_damage_to'].map((t) => t['name']),
        );
        weakAgainst = List<String>.from(
          data['damage_relations']['half_damage_to'].map((t) => t['name']),
        );
        noEffect = List<String>.from(
          data['damage_relations']['no_damage_to'].map((t) => t['name']),
        );
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Efetividade',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        _buildRow(
          Icons.arrow_upward,
          'Forte contra',
          strongAgainst,
          Colors.green,
        ),
        _buildRow(
          Icons.arrow_downward,
          'Fraco contra',
          weakAgainst,
          Colors.red,
        ),
        _buildRow(Icons.block, 'Sem efeito em', noEffect, Colors.grey),
      ],
    );
  }

  Widget _buildRow(
    IconData icon,
    String label,
    List<String> types,
    Color color,
  ) {
    if (types.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 12,
            runSpacing: 6,
            children: types
                .map(
                  (t) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        '•',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        t,
                        style: TextStyle(
                          fontSize: 13,
                          color: color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
