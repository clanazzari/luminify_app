import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

// TODO refactor

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luminify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Luminify - Luminaria de Mesa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: ColorGrid()),
    );
  }
}


class ColorGrid extends StatefulWidget {
  @override
  _ColorGridState createState() => _ColorGridState();
}

class _ColorGridState extends State<ColorGrid> {
  BluetoothConnection connection;
  final TextEditingController textEditingController = new TextEditingController();


  void _sendMessage(String text) async {
    connection.output.add(utf8.encode(text));
  }

  void bluetoothScan() async {
    try {
      print('Connecting');
      connection = await BluetoothConnection.toAddress("00:13:EF:02:0C:25");
      print('Connected to the device');
    } catch (exception) {
      print('Cannot connect, exception occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    bluetoothScan();
    
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        ColorBox(
          text: "Luz para trabalho", // branco
          color: Colors.white,
          callback: () {
            _sendMessage('000000EE00');
          },
        ),
        ColorBox(
          text: 'Luz para acordar', // branco quente, amarelado
          color: Colors.white70,
          callback: () {
            _sendMessage('000000EE66');
          },
        ),
        ColorBox(
          text: 'Luz para descansar', // amarelado
          color: Colors.amber[500],
          callback: () {
            _sendMessage('00000000EE');
          },
        ),
        ColorBox(
          text: 'Luz de balizamento noturna',
          color: Colors.amber[200],
          callback: () {
            _sendMessage('00000000AA');
          },
        ),
        ColorBox(
          text: 'Luz praa festa',
          color: Colors.pink[500],
          callback: () {
            _sendMessage('FF00220000');
          },
        ),
        ColorBox(
          text: 'Luz para limpeza',
          color: Colors.white,
          callback: () {
            _sendMessage('000000FF00');
          },
        ),
      ],
    );
  }
}


class ColorBox extends StatelessWidget {
  final Color color;
  final String text;
  final callback;

  const ColorBox({this.color, this.text, this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Text(text),
        color: color,
      ),
    );
  }
}
