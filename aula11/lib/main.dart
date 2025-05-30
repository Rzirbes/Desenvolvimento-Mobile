import 'package:aula11/screens/screen_one.dart';
import 'package:aula11/screens/screen_two.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fluter Demo",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),

            title: Text("Teste Tab"),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_bike)),
                Tab(icon: Icon(Icons.directions_boat)),
              ],
            ),
          ),
          drawer: Builder(
            builder: (context) {
              return Drawer(
                child: ListView(
                  children: [
                    DrawerHeader(child: Text('Header')),
                    ListTile(
                      title: Text("Settings"),
                      leading: Icon(Icons.settings),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ScreenOne()),
                        );
                      },
                    ),
                    ListTile(
                      title: Text("Perfil"),
                      leading: Icon(Icons.person),
                    ),
                  ],
                ),
              );
            },
          ),
          body: TabBarView(children: [ScreenOne(), ScreenTwo()]),
        ),
      ),
    );
  }
}
