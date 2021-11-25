import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:connect_4/connect4/connect4.dart';
import 'package:connect_4/connect4/i_situation.dart';

import 'package:connect_4/grid.dart';
import 'package:connect_4/ia/connect4_ai.dart';
import 'package:connect_4/ia/monte_carlo.dart';

ISituation? backgroundWork(ISituation? currentSituation) {
  if (currentSituation == null) {
    return null;
  }
  Connect4AI ai = Connect4AI(
      3,
      MonteCarlo(100, currentSituation.getCurrentplayer()),
      currentSituation.getCurrentplayer());
  return ai.getNextMove(currentSituation);
}

class Connect4Screen extends StatefulWidget {
  final List<String> players;
  final Function(int, List<List<int>>) onGameEnd;

  const Connect4Screen(this.players, this.onGameEnd, {Key? key})
      : super(key: key);

  @override
  State<Connect4Screen> createState() => _Connect4ScreenState();
}

class _Connect4ScreenState extends State<Connect4Screen> {
  late int currentPlayer;
  late Future<ISituation?> currentSituation;

  _Connect4ScreenState() : super() {
    currentPlayer = 0;
    currentSituation = Future.value(Connect4(0));
    tryAiPlay();
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
              const SizedBox(height: 64),
              /*const Text("Turn of "),
              (currentPlayer == 0)
                  ? const Text("Red",
                      style: TextStyle(
                          color: Colors.white, backgroundColor: Colors.red))
                  : const Text("Yellow",
                      style: TextStyle(
                          color: Colors.black, backgroundColor: Colors.yellow)),*/
              Grid(situation.getGrid(), onHumanPlay)
            ]);
          }
        } else if (snapshot.hasData) {
          ISituation? situation = snapshot.data;
          if (situation == null) {
            return ErrorWidget("OOPS");
          } else {
            return Column(//mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              const SizedBox(height: 64),
              /*const Text("Turn of "),
              (currentPlayer == 0)
                  ? const Text("Red",
                      style: TextStyle(
                          color: Colors.white, backgroundColor: Colors.red))
                  : const Text("Yellow",
                      style: TextStyle(
                          color: Colors.black, backgroundColor: Colors.yellow)),*/
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
        });
      });
    }
    checkEndOfGame();
    tryAiPlay();
  }

  void tryAiPlay() {
    currentSituation.then((situation) {
      if (widget.players[currentPlayer] == "AI") {
        setState(() {
          currentSituation = currentSituation.then((nextSituation) {
            if (situation != null && situation.checkIfFinished() == 0) {
              currentPlayer = (currentPlayer + 1) % 2;
              checkEndOfGame();
              tryAiPlay();
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
    });
  }

  void checkEndOfGame() {
    setState(() {
      currentSituation = currentSituation.then((situation) {
        if (situation == null) {
          return null;
        }
        int status = situation.checkIfFinished();
        if (status != 0) {
          widget.onGameEnd(status, situation.getGrid());
        }
        return situation;
      });
    });
  }
}
