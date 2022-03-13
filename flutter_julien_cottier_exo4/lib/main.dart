import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Photo Random '),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Image _image = const Image(
    image: NetworkImage('https://picsum.photos/500'),
    height: 500,
    width: 500,
  );
  void _newPhoto() {
    setState(() {
      _image = Image(
        image: NetworkImage('https://picsum.photos/4' +
            Random().nextInt(9).toString() +
            Random().nextInt(9).toString() +
            "/4" +
            Random().nextInt(9).toString() +
            Random().nextInt(9).toString()),
        height: 500,
        width: 500,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image,
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _newPhoto,
          tooltip: 'New',
          child: const Icon(Icons.reset_tv),
        ));
  }
}
