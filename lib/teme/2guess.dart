import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _controller = TextEditingController();
  String _text;
  String _error;
  int _lastNumber;
  int _randomNumber = Random().nextInt(100) + 1;

  String get _txt {
    var s = 'You have tried $_lastNumber\n';
    if (_lastNumber > _randomNumber)
      s += 'Try lower.';
    else
      s += 'Try higher.';
    return s;
  }

  void reset() {
    _text = '';
    _error = null;
    _lastNumber = null;
    _randomNumber = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(
            "I'm thinking of a number between 1 and 100..",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          Text(
            "It's your turn to guess my number!",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          if (_lastNumber != null)
            Text(
              _txt,
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          Card(
              elevation: 10,
              child: Column(
                children: <Widget>[
                  Text(
                    'Try a number!',
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  TextField(
                    controller: _controller,
                    onChanged: (String str) {
                      setState(() {
                        _text = str;
                      });
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      errorText: _error,
                    ),
                  ),
                  if (_randomNumber != null)
                    RaisedButton(
                      child: Text('Guess!'),
                      onPressed: () {
                        if (_text == null || _text == '') {
                          setState(() {
                            _error = 'You have not entered a number';
                          });
                        } else if (int.parse(_text) > 100 ||
                            int.parse(_text) < 1) {
                          setState(() {
                            _error = 'You have entered an invalid number.';
                          });
                        } else {
                          _error = null;
                          if (int.parse(_text) == _randomNumber) {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: Text('You were right.'),
                                      content: Text('It was $_randomNumber.'),
                                    )).then((_) {
                              reset();
                              setState(() {});
                            });
                          } else
                            setState(() {
                              _lastNumber = int.parse(_text);
                            });
                        }
                      },
                    )
                  else
                    RaisedButton(
                      child: Text('Reset!'),
                      onPressed: () {
                        _controller.clear();
                        setState(() {
                          _randomNumber = Random().nextInt(100) + 1;
                        });
                      },
                    )
                ],
              )),
        ]),
      ),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Align(
          child: Text(
            'Guess my number',
          ),
        ),
      ),
    );
  }
}
