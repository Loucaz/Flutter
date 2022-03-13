import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/MyHomePage.dart';

const myColor = Color(0xFF5a5e6b);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'BiblioFilm'),
      debugShowCheckedModeBanner: false,
    );
  }
}
