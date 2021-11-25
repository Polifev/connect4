import 'package:flutter/material.dart';
import 'package:connect_4/connect4_screen.dart';
import 'package:connect_4/grid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool player0AI = false;
  bool player1AI = false;
  List<String> players = ["HUMAN", "HUMAN"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/connect4.png'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("AI enabled for player 1"),
              Switch(
                  value: player0AI,
                  onChanged: (val) {
                    setState(() {
                      player0AI = val;
                      players[0] = val ? "AI" : "HUMAN";
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("AI enabled for player 2"),
              Switch(
                  value: player1AI,
                  onChanged: (val) {
                    setState(() {
                      player1AI = val;
                      players[1] = val ? "AI" : "HUMAN";
                    });
                  }),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _GameRoute(players)),
                );
              },
              child: const Text("Launch game"))
        ],
      ),
      floatingActionButton: null,
    );
  }
}

class _GameRoute extends StatelessWidget {
  final List<String> players;

  const _GameRoute(this.players, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Connect 4 game'),
        ),
        body: Connect4Screen(players, (winState, grid) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => _ScoreRoute(winState, grid)),
          );
        }));
  }
}

class _ScoreRoute extends StatelessWidget {
  static final _messages = ["Red won !", "Yellow won !", "Tie !!!"];
  static final _messageColors = [Colors.red, Colors.yellow, Colors.green];
  final int _winState;
  final List<List<int>> _finalGrid;

  const _ScoreRoute(this._winState, this._finalGrid, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Game over"),
        ),
        body: Column(children: [
          const SizedBox(height: 32),
          Text(
            _messages[_winState - 1],
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: _messageColors[_winState - 1]),
          ),
          const SizedBox(
            height: 32,
          ),
          Grid(_finalGrid, (v) {}),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
            child: const Text("Back to main menu"),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ]));
  }
}
