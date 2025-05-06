import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_app_aula_07/widgets/languages_widget.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Color _backgroundColor;

  final TextEditingController _controller = TextEditingController();
  String _filter = "";

  void _changeColorAppBar() {
    setState(() {
      _backgroundColor =
          Colors.primaries[Random().nextInt(Colors.primaries.length)];
    });
  }

  @override
  void initState() {
    super.initState();
    _backgroundColor = Colors.primaries[0];
  }

  List<String> languages = [
    'Dart',
    'Java',
    'Kotlin',
    'Swift',
    'Objective-C',
    'JavaScript',
    'Python',
    'C#',
    'C++',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: _backgroundColor,
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: _changeColorAppBar,
              icon: Icon(Icons.color_lens_rounded),
            ),
          ],
        ),
        body: Languages(filter: _filter),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  onChanged: (value) {
                    setState(() {
                      _filter = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Filtro",
                    label: Text("Filtro"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _filter = _controller.text;
                    });
                  },
                  child: Text('Filtrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
