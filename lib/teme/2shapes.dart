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
  String _text;
  String _error;

  String get _txt {
    final int a = int.parse(_text);
    final bool sq = _checkSquare(a);
    final bool tr = _checkTriangular(a);
    if (sq && tr) {
      return 'Number is both SQUARE and TRIANGULAR.';
    } else if (sq) {
      return 'Number is SQUARE.';
    } else if (tr) {
      return 'Number is TRIANGULAR.';
    } else {
      return 'Number is neither SQUARE or TRIANGULAR';
    }
  }

  bool _checkSquare(int nr) {
    return sqrt(nr) == sqrt(nr).toInt();
  }

  bool _checkTriangular(int nr) {
    return _checkSquare(8 * nr + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_text == null || _text == '')
            setState(() {
              _error = 'You have not entered a valid number';
            });
          else {
            setState(() {
              _error = null;
            });

            showDialog(
                context: context,
                builder: (_) =>
                    AlertDialog(
                      title: Text('$_text'),
                      content: Text(_txt),
                    ));
          }
        },
        child: Icon(Icons.check),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
                'Please input a number to see if it is a square or triangular.'),
            TextField(
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
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Align(
          child: Text(
            'Number Shapes',
          ),
        ),
      ),
    );
  }
}
