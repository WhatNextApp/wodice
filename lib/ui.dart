import 'package:flutter/material.dart';
import 'package:wodice/main.dart';
import 'package:wodice/roll_funcs.dart';

class HomeState extends State<WoDiceHome> {
  double _dPAmount = 1.0;
  double _diffAmount = 6.0;
  bool _botch = true;
  bool _spec = false;
  String _ressText = 'Welcome to WoDice Roller';
  String _dPText = 'sdfgssdfg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Dice Pool'),
                Slider(
                  value: _dPAmount,
                  min: 1,
                  max: 20,
                  divisions: 19,
                  label: _dPAmount.round().toString(),
                  onChanged: (double dP) {
                    setState(
                      () {
                        _dPAmount = dP;
                      },
                    );
                  },
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Botcable?'),
                      Checkbox(
                        value: _botch,
                        onChanged: (bool? botch) {
                          setState(
                            () {
                              _botch = botch ?? false;
                            },
                          );
                        },
                      ),
                      const Text('Specialized?'),
                      Checkbox(
                        value: _spec,
                        onChanged: (bool? spec) {
                          setState(
                            () {
                              _spec = spec ?? false;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Text('Difficulty'),
                Slider(
                  value: _diffAmount,
                  min: 2,
                  max: 10,
                  divisions: 8,
                  label: _diffAmount.round().toString(),
                  onChanged: (double diff) {
                    setState(
                      () {
                        _diffAmount = diff;
                      },
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    List<String> ress = rollDP(
                      _dPAmount.round().toString(),
                      _botch,
                      _spec,
                      _diffAmount.round().toString(),
                    );
                    setState(
                      () {
                        _ressText = ress[0];
                        _dPText = ress[1];
                      },
                    );
                  },
                  child: const Text('Roll'),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    _ressText,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _dPText,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
