import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  final List<String> _props = <String>[
    'salut',
    'salut(Germană)',
    'mă numesc',
    'mă numesc(Germană)',
    'cum ești?',
    'cum ești?(Germană)',
    'sunt bine',
    'sunt bine(Germană)',
  ];
  final List<String> _propsGER = <String>[
    'Hallo',
    'mein Name ist',
    'wie gehts',
    'es geht mir gut',
  ];
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  Future<void> sound(int id) async {
    try {
      if (id % 2 == 0)
        await assetsAudioPlayer.open(
          Audio.network('https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&q=${_props[id]}&tl=ro'),
        );
      else {
        await assetsAudioPlayer.open(
          Audio.network('https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&q=${_propsGER[id ~/ 2]}&tl=de'),
        );
      }
      // ignore: empty_catches
    } catch (t) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: _props.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Card(
                  elevation: 10,
                  color: Colors.blue,
                  child: Align(
                    child: Text('${_props[index]}'),
                  ),
                ),
                onTap: () {
                  sound(index);
                },
              );
            }),
      ),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Align(
          child: Text(
            'Basic Phrases',
          ),
        ),
      ),
    );
  }
}
