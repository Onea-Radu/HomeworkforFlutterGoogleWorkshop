import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  List<String> _strlst = [];
  int _pag = 0;

  String _txt = '';

  int get _page {
    _pag++;
    return _pag;
  }

  Future<void> getNextPage() async {
    final http.Response h = await http.get('https://yts.mx/api/v2/list_movies.json?page=$_page&genre=$_genre');
    final Map<String, dynamic> j = jsonDecode(h.body);
    final List<dynamic> y = j['data']['movies'].map((e) => e['title']).toList();
    final List<String> t = y.cast<String>();
    print(t.toString());
    _strlst.addAll(t);
    setState(() {});
  }

  String get _genre {
    if (_txt == null || _txt.isEmpty) {
      return _txt;
    }
    return _txt;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            children: [
              Text('Filter by genre:', style: TextStyle(fontSize: 18)),
              Spacer(),
              Expanded(
                flex: 64,
                child: TextField(onSubmitted: (value) {
                  _txt = value;
                  _strlst = [];
                  _pag = 0;
                  setState(() {});
                  getNextPage();
                }),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _strlst.length + 1,
              itemBuilder: (context, index) {
                if (index == _strlst.length) {
                  getNextPage();
                  return Card(
                    child: ListTile(
                      title: Text('Loading...'),
                    ),
                  );
                }
                return Card(
                  child: ListTile(
                    title: Text(_strlst[index]),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Align(
          child: Text(
            'Movie Lister',
          ),
        ),
      ),
    );
  }
}
