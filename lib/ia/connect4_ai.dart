import 'dart:math';

import 'package:connect_4/connect4/connect4.dart';
import 'package:connect_4/connect4/i_situation.dart';
import 'package:connect_4/ia/monte_carlo.dart';

class Connect4AI {
  static const loseScore = -1, winScore = 100, tieScore = 0;

  late List<ISituation> _situations;
  final MonteCarlo mc;
  final int depth, color;

  Connect4AI(this.depth, this.mc, this.color);

  ISituation? getNextMove(ISituation root) {
    int nextMoveScore = minimax(root, depth, -1000, 1000, true);
    // Retrieve the best node based on the score
    for (ISituation situation in _situations) {
      if (situation.getScore() == nextMoveScore) {
        return situation;
      }
    }
    return null;
  }

  int minimax(
      ISituation root, int depth, int alpha, int beta, bool maximizingPlayer) {
    if (root.checkIfFinished() == Connect4.red) {
      return color == Connect4.red ? winScore : loseScore;
    }
    if (root.checkIfFinished() == Connect4.yellow) {
      return color == Connect4.red ? loseScore : winScore;
    }
    if (root.checkIfFinished() == Connect4.full) {
      return tieScore;
    }
    if (depth == 0) {
      return mc.getScore(root);
    }
    if (maximizingPlayer) {
      List<ISituation> currentSituations = root.getNextSituations();
      if (depth == this.depth) {
        _situations =
            currentSituations; //Stocks the first Node situations to select once the tree is computed
      }
      int maxEval = -1000;
      for (ISituation child in currentSituations) {
        int eval = minimax(child, depth - 1, alpha, beta, false);
        child.setScore(
            eval); // Add the score to select once the tree is computed
        maxEval = max(maxEval, eval);
        alpha = max(eval, alpha);
        if (beta <= alpha) {
          break;
        }
      }
      return maxEval;
    } else {
      int minEval = 1000;
      for (ISituation child in root.getNextSituations()) {
        int eval = minimax(child, depth - 1, alpha, beta, true);
        minEval = min(minEval, eval);
        beta = min(eval, beta);
        if (beta <= alpha) {
          break;
        }
      }
      return minEval;
    }
  }
}
