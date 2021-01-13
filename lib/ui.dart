import 'package:flutter/material.dart';
import 'package:wodice/main.dart';
import 'package:wodice/roll_funcs.dart';

class HomeState extends State<WoDiceHome> {
  var _dPAmount = 1.0;
  var _epic10 = 0.0;
  var _epic1 = 1.0;
  var _diffAmount = 6.0;
  var _botch = true;
  var _spec = false;
  var _ressText = 'Welcome to WoDice Roller';
  var _dPText = '';
  var _homeState = 0;
  var _epic = false;
  var _helpString = '''
\n\n\n
Hi, this is Akmenah. This is WoDice Roller for helping your fun.
If you are confused with app, do not panic. Here is a brief explenation:

Dice Pool: It is the amount of d10s being rolled for attempting an action.
(We seperated it by 10s and 1s for epic characters)

Botchable: For botchable rolls, dice results of 1s extracted from successes.
(Each 1 extracted from a success die)
(If there is no successes left, roll botchs)

Specalized: For specialized rolls, dice results of 10s count as double success.
(Botches being extracted from 10s first)
(So each 1 cancels a 10, a double success)

Difficulty: Difficulty is the point where dice are counts as success.
(For a difficulty of 7, a result of {2}, {7}, {9} is equals to 2 successes)
''';

  void changeHome() {
    // 0==> baseHome   1==> settings   2==> epicHome
    setState(() {
      if (_homeState % 2 == 0)
        _homeState = 1;
      else {
        _ressText = '';
        _dPText = '';
        if (_epic)
          _homeState = 2;
        else
          _homeState = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _baseHome = StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Scaffold(
          body: SafeArea(
            top: true,
            bottom: true,
            child: Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: FloatingActionButton(
                            child: Icon(Icons.help),
                            onPressed: changeHome,
                          ),
                          height: 80,
                        ),
                      ],
                    ),
                    Container(
                      child: const Text('Dice Pool'),
                      height: 80,
                    ),
                    Container(
                      child: Slider(
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
                      height: 80,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Botcable?'),
                          Checkbox(
                            value: _botch,
                            onChanged: (bool botch) {
                              setState(
                                () {
                                  _botch = botch;
                                },
                              );
                            },
                          ),
                          const Text('Specialized?'),
                          Checkbox(
                            value: _spec,
                            onChanged: (bool spec) {
                              setState(
                                () {
                                  _spec = spec;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      height: 80,
                    ),
                    Container(
                      child: const Text('Difficulty'),
                      height: 80,
                    ),
                    Container(
                      child: Slider(
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
                      height: 80,
                    ),
                    Container(
                      child: ElevatedButton(
                        child: const Text('Roll Dice Pool'),
                        onPressed: () {
                          setState(
                            () {
                              var printable = rollDP(
                                  _dPAmount.round().toString(),
                                  _botch,
                                  _spec,
                                  _diffAmount.round().toString());
                              _ressText = printable[0];
                              _dPText = printable[1];
                            },
                          );
                        },
                      ),
                      height: 80,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          _ressText,
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          _dPText,
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    var _settingsPage = StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Scaffold(
          body: SafeArea(
            minimum: EdgeInsets.all(20.0),
            top: true,
            bottom: true,
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            FloatingActionButton(
                              child: Icon(Icons.casino),
                              onPressed: changeHome,
                            ),
                          ],
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              _helpString,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Is your character epic?'),
                              Checkbox(
                                value: _epic,
                                onChanged: (bool epic) {
                                  setState(
                                    () {
                                      _epic = epic;
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    var _epicHome = StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Scaffold(
          body: SafeArea(
            minimum: EdgeInsets.all(20.0),
            top: true,
            bottom: true,
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            FloatingActionButton(
                              child: Icon(Icons.help),
                              onPressed: changeHome,
                            ),
                          ],
                        ),
                        Text('Dice Pool           ' +
                            (_epic10 + _epic1).round().toString()),
                        Slider(
                          value: _epic10,
                          min: 00,
                          max: 60,
                          divisions: 6,
                          label: _epic10.round().toString(),
                          onChanged: (double dP10) {
                            setState(
                              () {
                                _epic10 = dP10;
                              },
                            );
                          },
                        ),
                        Slider(
                          value: _epic1,
                          min: 0,
                          max: 9,
                          divisions: 9,
                          label: _epic1.round().toString(),
                          onChanged: (double dP1) {
                            setState(
                              () {
                                _epic1 = dP1;
                              },
                            );
                          },
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Botcable?'),
                              Checkbox(
                                value: _botch,
                                onChanged: (bool botch) {
                                  setState(
                                    () {
                                      _botch = botch;
                                    },
                                  );
                                },
                              ),
                              const Text('Specialized?'),
                              Checkbox(
                                value: _spec,
                                onChanged: (bool spec) {
                                  setState(
                                    () {
                                      _spec = spec;
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
                          child: const Text('Roll Dice Pool'),
                          onPressed: () {
                            setState(
                              () {
                                var printable = rollDP(
                                    (_epic10 + _epic1).round().toString(),
                                    _botch,
                                    _spec,
                                    _diffAmount.round().toString());
                                _ressText = printable[0];
                                _dPText = printable[1];
                              },
                            );
                          },
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              _ressText,
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              _dPText,
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (_homeState == 0)
      return _baseHome;
    else if (_homeState == 1)
      return _settingsPage;
    else
      return _epicHome;
  }
}
