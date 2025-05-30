import 'package:aula11/screens/screen_three.dart';
import 'package:flutter/material.dart';

class Pessoa {
  final String name;
  final int idade;

  Pessoa({required this.name, required this.idade});
}

class ScreenTwo extends StatelessWidget {
  ScreenTwo({super.key});
  var pessoa = Pessoa(name: "Romulo", idade: 26);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Tela 02"),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenThree(pessoa: pessoa),
                  ),
                ),
              },
              child: Text("Navega Tela 03"),
            ),
          ],
        ),
      ),
    );
  }
}
