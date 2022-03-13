import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class TapboxA extends StatefulWidget {
  const TapboxA({Key? key}) : super(key: key);

  @override
  _TapboxAState createState() => _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Column(
        children: <Widget>[
          Image(
            image: NetworkImage(
              _active
                  ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmg1PK9Va-xCDntLdTvMToVzqugERrbylMeQ&usqp=CAU'
                  : 'https://st2.depositphotos.com/14768666/42377/v/600/depositphotos_423776214-stock-illustration-newton-idea-bulb-icon-outline.jpg',
            ),
            height: 500,
            width: 500,
          ),
          Switch(
            value: _active,
            onChanged: (value) {
              setState(() {
                _active = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

//------------------------- MyApp ----------------------------------

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ampoule ON/OFF'),
        ),
        body: const Center(
          child: TapboxA(),
        ),
      ),
    );
  }
}
