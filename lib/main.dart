import 'package:flutter/material.dart';
import 'package:wodice/ui.dart';

void main() {
  runApp(const WoDiceApp());
}

class WoDiceApp extends StatelessWidget {
  const WoDiceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WoDice Roller',
      theme: ThemeData.dark(),
      home: const WoDiceHome(),
    );
  }
}

class WoDiceHome extends StatefulWidget {
  const WoDiceHome({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}
