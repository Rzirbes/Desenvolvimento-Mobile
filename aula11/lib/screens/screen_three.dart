import 'package:aula11/screens/screen_two.dart';
import 'package:flutter/material.dart';

class ScreenThree extends StatelessWidget {
  final Pessoa pessoa;
  const ScreenThree({super.key, required this.pessoa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela 03"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text(pessoa.name)],
        ),
      ),
    );
  }
}
