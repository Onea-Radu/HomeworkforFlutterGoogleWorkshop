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
  double number = null;
  String text;
  String error = null;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/pngegg.png'),
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
            ),
            TextField(
              onChanged: (String str) {
                setState(() {
                  text = str;
                });
              },
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter(RegExp(r'(^\d*\.?\d*)'),
                    allow: true)
              ],
              decoration: InputDecoration(
                errorText: error,
                hintText: 'enter the amount in EUR',
              ),
            ),
            RaisedButton(
                onPressed: () {
                  if (text == '') {
                    number = null;
                    error = 'You have not entered a value yet.';
                  } else {
                    try {
                      number = double.parse(text);
                      error = null;
                    } catch (identifier) {
                      print(identifier);
                      error = 'Something went wrong';
                    }
                  }
                  setState(() {});
                },
                child: Text(
                  'CONVERT!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            if (number != null)
              Text(
                '${(number * 4.5).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 50, color: Colors.black54),
              )
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Align(
          child: Text(
            'Currency Converter',
          ),
        ),
      ),
    );
  }
}
