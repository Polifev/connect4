import 'package:flutter/material.dart';
import 'package:flutter_application_1/connect4_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Connect4Screen(const ["HUMAN", "AI"]),
        ],
      ),
      floatingActionButton: null,
    );
  }
}
