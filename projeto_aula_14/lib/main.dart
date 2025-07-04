import 'package:flutter/material.dart';
import 'package:projeto_ap2/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'providers/pokemon_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PokemonProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      theme: ThemeData.dark(),
      home: LoginPage(),
    );
  }
}
