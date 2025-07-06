import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_as/firebase_options.dart';
import 'package:projeto_as/models/user_model.dart';
import 'package:projeto_as/screens/home_screen.dart';
import 'package:projeto_as/screens/login_screen.dart';
import 'package:projeto_as/services/firebase/auth/firebase_service_auth.dart';
import 'package:provider/provider.dart';
import 'providers/pokemon_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: InitializeApp(),
    );
  }
}

class InitializeApp extends StatelessWidget {
  final FirebaseAuthService _auth = FirebaseAuthService();
  InitializeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: _auth.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData && snapshot.data!.email.isNotEmpty) {
          return const HomeScreen();
        }

        return LoginPage();
      },
    );
  }
}
