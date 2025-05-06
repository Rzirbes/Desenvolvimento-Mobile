import 'package:flutter/material.dart';

class Languages extends StatefulWidget {
  final String filter;
  const Languages({super.key, required this.filter});

  _filteredLanguages() {
    return languages
        .where(
          (element) => element.toLowerCase().contains(filter.toLowerCase()),
        )
        .toList();
  }

  @override
  State<Languages> createState() => _LanguagesState();
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
  'Ruby',
  'Go',
  'Rust',
  'PHP',
  'TypeScript',
  'CSS',
  'SQL',
  'Shell',
  'Scala',
  'R',
  'Perl',
  'Haskell',
  'Lua',
  'Julia',
  'Groovy',
];

class _LanguagesState extends State<Languages> {
  List<String> languagesFiltered = [];

  @override
  void didUpdateWidget(covariant Languages oldWidget) {
    if (oldWidget.filter != widget.filter) {
      languagesFiltered = widget._filteredLanguages();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    languagesFiltered = widget._filteredLanguages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.82,
      child: ListView.separated(
        itemBuilder: (BuildContext context, indexLanguages) {
          return ListTile(
            leading: Icon(Icons.rocket),
            title: Text(languagesFiltered[indexLanguages]),
            subtitle: Text("Melhor linguagem do mundo"),
          );
        },
        separatorBuilder: (BuildContext context, indexLanguages) {
          return Divider();
        },
        itemCount: languagesFiltered.length,
      ),
    );
  }
}
