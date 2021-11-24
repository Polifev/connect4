import 'dart:math';
import 'package:flutter_application_1/connect4/i_situation.dart';

class MonteCarlo {
  final int nGames, color;

  const MonteCarlo(this.nGames, this.color);

  int getScore(ISituation node) {
    int win = 0;
    for (int i = 0; i < nGames; i++) {
      ISituation gameNode = node.getCopy();
      while (gameNode.checkIfFinished() == 0) {
        List<int> index = gameNode.getPossibleIndex();
        int random = getRandom(index.length);
        gameNode.play(index[random]);
      }
      if (gameNode.checkIfFinished() == color) {
        win++;
      }
    }
    return win;
  }

  int getRandom(int max) {
    Random rn = Random();
    return rn.nextInt(max);
  }
}
