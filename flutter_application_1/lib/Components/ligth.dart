import 'package:flutter/material.dart';

class MaLmiere extends StatefulWidget {
  const MaLmiere({Key? key}) : super(key: key);

  @override
  _MaLmiereState createState() => _MaLmiereState();
}

class _MaLmiereState extends State<MaLmiere> {
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    return Image.network(
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg');
  }
}
