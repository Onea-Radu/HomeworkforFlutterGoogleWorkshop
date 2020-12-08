import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class AnimatedButton extends StatelessWidget {
  const AnimatedButton({this.widgetColor});

  final Color widgetColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: AnimatedContainer(
        color: widgetColor,
        duration: Duration(milliseconds: 500),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _current = Colors.red;
  bool _disabled = false;
  List<Color> _squares = List.generate(9, (int index) => Colors.white);

  void reset() {
    _current = Colors.red;
    _disabled = false;
    _squares = List.generate(9, (int index) => Colors.white);
    setState(() {});
  }

  bool checkWin() {
    Set<Color> t = {
      ...[_squares[0], _squares[1], _squares[2], _current]
    };
    if (t.length == 1) {
      _squares = List.generate(9, (int index) => Colors.white);
      _squares[0] = _squares[1] = _squares[2] = _current;
      return true;
    }
    t = {
      ...[_squares[3], _squares[4], _squares[5], _current]
    };
    if (t.length == 1) {
      _squares = List.generate(9, (int index) => Colors.white);
      _squares[3] = _squares[4] = _squares[5] = _current;
      return true;
    }
    t = {
      ...[_squares[6], _squares[7], _squares[8], _current]
    };
    if (t.length == 1) {
      _squares = List.generate(9, (int index) => Colors.white);
      _squares[6] = _squares[7] = _squares[8] = _current;
      return true;
    }
    t = {
      ...[_squares[0], _squares[4], _squares[8], _current]
    };
    if (t.length == 1) {
      _squares = List.generate(9, (int index) => Colors.white);
      _squares[0] = _squares[4] = _squares[8] = _current;
      return true;
    }
    t = {
      ...[_squares[2], _squares[4], _squares[6], _current]
    };
    if (t.length == 1) {
      _squares = List.generate(9, (int index) => Colors.white);
      _squares[2] = _squares[4] = _squares[6] = _current;
      return true;
    }

    t = {
      ...[_squares[0], _squares[3], _squares[6], _current]
    };
    if (t.length == 1) {
      _squares = List.generate(9, (int index) => Colors.white);
      _squares[0] = _squares[3] = _squares[6] = _current;
      return true;
    }
    t = {
      ...[_squares[1], _squares[4], _squares[7], _current]
    };
    if (t.length == 1) {
      _squares = List.generate(9, (int index) => Colors.white);
      _squares[1] = _squares[4] = _squares[7] = _current;
      return true;
    }
    t = {
      ...[_squares[2], _squares[5], _squares[8], _current]
    };
    if (t.length == 1) {
      _squares = List.generate(9, (int index) => Colors.white);
      _squares[2] = _squares[5] = _squares[8] = _current;
      return true;
    }

    return _squares.where((element) => element == Colors.white).isEmpty;
  }

  void changeCol(int ind) {
    if (_squares[ind] == Colors.white && !_disabled) {
      _squares[ind] = _current;
      _disabled = checkWin();
      if (_current == Colors.red)
        _current = Colors.green;
      else
        _current = Colors.red;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  changeCol(index);
                },
                child: AnimatedButton(
                  widgetColor: _squares[index],
                ),
              ),
            ),
          ),
          if (_disabled)
            RaisedButton(
                child: Text('Reset'),
                onPressed: () {
                  reset();
                }),
        ]),
      ),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Align(
          child: Text(
            'Tic Tac Toe',
          ),
        ),
      ),
    );
  }
}
