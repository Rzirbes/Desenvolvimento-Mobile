import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage(title: 'Home'));
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  void _teste() {
    // ignore: avoid_print
    print('Adicionado');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _teste, icon: Icon(Icons.add), iconSize: 58),
        ],
        backgroundColor: Colors.lightBlue,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.red,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(color: Colors.pink, child: Text("Container")),
              ),
            ),
            Text('Ola mundo'),
            Text('Ola mundo'),
            Image.network(
              'https://images.unsplash.com/photo-1471115853179-bb1d604434e0?q=80&w=2564&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              height: 120,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
