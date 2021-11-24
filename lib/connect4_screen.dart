import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/connect4/connect4.dart';
import 'package:flutter_application_1/connect4/i_situation.dart';

import 'package:flutter_application_1/grid.dart';
import 'package:flutter_application_1/ia/connect4_ai.dart';
import 'package:flutter_application_1/ia/monte_carlo.dart';

ISituation? backgroundWork(ISituation currentSituation) {
  Connect4AI ai = Connect4AI(
      3,
      MonteCarlo(100, currentSituation.getCurrentplayer()),
      currentSituation.getCurrentplayer());
  return ai.getNextMove(currentSituation);
}

class Connect4Screen extends StatefulWidget {
  final List<String> players;

  Connect4Screen(this.players, {Key? key}) : super(key: key);

  @override
  State<Connect4Screen> createState() => _Connect4ScreenState();
}

class _Connect4ScreenState extends State<Connect4Screen> {
  late int currentPlayer;
  late Future<ISituation?> currentSituation;

  _Connect4ScreenState() : super() {
    currentPlayer = 0;
    currentSituation = Future.value(Connect4(0));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ISituation?>(
      future: currentSituation, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<ISituation?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          ISituation? situation = snapshot.data;
          if (situation == null) {
            return ErrorWidget("OOPS");
          } else {
            return Column(children: [
              const SizedBox(height: 48),
              Grid(situation.getGrid(), onHumanPlay)
            ]);
          }
        } else if (snapshot.hasData) {
          ISituation? situation = snapshot.data;
          if (situation == null) {
            return ErrorWidget("OOPS");
          } else {
            return Column(children: [
              const SizedBox(height: 48),
              Grid(situation.getGrid(), (v) {}),
              const SizedBox(height: 16),
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text("Waiting for AI to play...")
            ]);
          }
        } else {
          return const Text("Loading...");
        }
      },
    );
  }

  void onHumanPlay(int column) {
    if (widget.players[currentPlayer] == "HUMAN") {
      setState(() {
        currentSituation = currentSituation.then<ISituation>((situation) {
          if (situation == null) {
            throw Error();
          }

          // We add 1 to the column to match ai programming
          ISituation? nextSituation = situation.play(column + 1);
          if (nextSituation != null) {
            currentPlayer = (currentPlayer + 1) % 2;
            return nextSituation;
          } else {
            return situation;
          }
        }).then((situation) {
          if (widget.players[currentPlayer] == "AI") {
            currentPlayer = (currentPlayer + 1) % 2;
            return compute(
              backgroundWork,
              situation,
            );
          } else {
            return situation;
          }
        });
      });
    }
  }
}
