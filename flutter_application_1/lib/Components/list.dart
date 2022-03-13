import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/film.dart';
import 'package:flutter_application_1/pages/MyHomePage.dart';

class Liste extends StatefulWidget {
  const Liste({Key? key}) : super(key: key);

  @override
  _ListeState createState() => _ListeState();
}

class _ListeState extends State<Liste> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(10, (index) => Text("film")),
    );
  }
}
