import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Indoor Navigation',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(child: MyHomePage()),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: MaterialButton(
          color: Colors.brown.shade500,
          height: double.infinity,
          minWidth: 1000.0,
          onPressed: () {
            Future.delayed(Duration(milliseconds: 300), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NextPage(value: _textController.text),
                  ));
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.mic,
                size: 170,
                color: Colors.white,
              ),
              Text(
                'Tap Anywhere!!',
                style: TextStyle(color: Colors.white70),
              ),
              new ListTile(
                title: new TextField(
                  controller: _textController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatefulWidget {
  String value;
  NextPage({Key? key, required this.value}) : super(key: key);

  @override
  _NextPageState createState() => new _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();

  speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setLanguage("th-TH");
    await flutterTts.setPitch(1);
    await flutterTts.speak("${widget.value}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //child: Padding(
      //padding: const EdgeInsets.all(32),
      child: Center(
        //mainAxisSize: MainAxisSize.min,
        //children: <Widget>[
        // TextFormField(
        //  controller: textEditingController,
        //),
        child: MaterialButton(
          minWidth: 1200,
          height: double.infinity,
          onPressed: () => speak(),
          color: Colors.brown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(
                Icons.graphic_eq,
                size: 170,
                color: Colors.white,
              ),
              Text(
                'Tap Anywhere!!',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        //],
      ),
      //),
    );
  }
}
