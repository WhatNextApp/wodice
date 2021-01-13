import 'package:flutter/material.dart';
import 'package:wodice/ui.dart';

void main() => runApp(WoDiceApp());

class WoDiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WoDice Roller',
      theme: ThemeData.dark(),
      home: WoDiceHome(),
    );
  }
}

class WoDiceHome extends StatefulWidget {
  WoDiceHome({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}
