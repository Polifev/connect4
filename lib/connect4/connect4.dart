import 'dart:core';
import 'i_situation.dart';

class Connect4 implements ISituation {
  static const red = 1, yellow = 2, empty = 0, full = 3;

  late List<List<int>> _grid;
  late int _currentPlayer, _lastMoveCol, _lastMoveLine, _score;

  Connect4(int start) {
    _grid = List.generate(6, (i) => List.filled(7, 0, growable: false),
        growable: false);
    if (start != red && start != yellow) {
      start = red;
    }
    _currentPlayer = start;
    _lastMoveCol = -1;
    _lastMoveLine = -1;
  }

  Connect4 _copy() {
    Connect4 copy = Connect4(0);
    copy._currentPlayer = _currentPlayer;
    List<List<int>> gridCopy = List.generate(
        6, (i) => List.generate(7, (j) => _grid[i][j]),
        growable: false);
    copy._grid = gridCopy;
    copy._lastMoveCol = _lastMoveCol;
    copy._lastMoveLine = _lastMoveLine;
    return copy;
  }

  @override
  int checkIfFinished() {
    //Check from last move
    if (_lastMoveLine == -1 && _lastMoveCol == -1) {
      // -> IA START
      return empty;
    }
    int toCheck = _grid[_lastMoveLine][_lastMoveCol - 1]; // R or Y
    //Vertical
    int count = 0;
    int i = _lastMoveLine;
    while (i >= 0 && _grid[i][_lastMoveCol - 1] == toCheck) {
      i--;
      count++;
    }
    if (count == 4) {
      return toCheck;
    }
    //Horizontal
    count = 1;
    //Left
    i = _lastMoveCol - 2;
    while (i >= 0 && _grid[_lastMoveLine][i] == toCheck) {
      count++;
      i--;
    }
    //Right
    i = _lastMoveCol;
    while (i < 7 && _grid[_lastMoveLine][i] == toCheck) {
      count++;
      i++;
    }
    if (count >= 4) {
      return toCheck;
    }
    //Diagonal right
    count = 1;
    //Bottom Left
    i = _lastMoveLine;
    int j = _lastMoveCol - 1;
    i--;
    j--;
    while (i >= 0 && j >= 0 && _grid[i][j] == toCheck) {
      count++;
      i--;
      j--;
    }
    //Up Right
    i = _lastMoveLine;
    j = _lastMoveCol - 1;
    i++;
    j++;
    while (i < 6 && j < 7 && _grid[i][j] == toCheck) {
      count++;
      i++;
      j++;
    }
    if (count >= 4) {
      return toCheck;
    }
    //Diagonal left
    count = 1;
    //Bottom Right
    i = _lastMoveLine;
    j = _lastMoveCol - 1;
    i--;
    j++;
    while (i >= 0 && j < 7 && _grid[i][j] == toCheck) {
      count++;
      i--;
      j++;
    }
    //Up Left
    i = _lastMoveLine;
    j = _lastMoveCol - 1;
    i++;
    j--;
    while (i < 6 && j >= 0 && _grid[i][j] == toCheck) {
      count++;
      i++;
      j--;
    }
    if (count >= 4) {
      return toCheck;
    }
    //Grid Full ?
    for (i = 0; i < 6; i++) {
      for (j = 0; j < 7; j++) {
        if (_grid[i][j] == empty) {
          return empty; //Not Finished
        }
      }
    }
    return full; //Grid full -> Tie
  }

  @override
  ISituation getCopy() {
    return _copy();
  }

  @override
  List<ISituation> getNextSituations() {
    List<ISituation> situations = List<ISituation>.empty(growable: true);
    for (int i = 1; i <= 7; i++) {
      ISituation? nextMove = _copy().play(i);
      if (nextMove != null) {
        situations.add(nextMove);
      }
    }
    return situations;
  }

  @override
  List<int> getPossibleIndex() {
    List<int> index = List<int>.empty(growable: true);
    for (int i = 1; i <= 7; i++) {
      ISituation? nextMove = _copy().play(i);
      if (nextMove != null) {
        index.add(i);
      }
    }
    return index;
  }

  @override
  int getScore() {
    return _score;
  }

  @override
  ISituation? play(int move) {
    if (_grid[5][move - 1] != empty) {
      //Already filled
      return null;
    } else {
      int i = 0;
      while (_grid[i][move - 1] != empty) {
        i++;
      }
      _grid[i][move - 1] = _currentPlayer;
      _switchPlayer();
      _lastMoveCol = move;
      _lastMoveLine = i;
      return this;
    }
  }

  void _switchPlayer() {
    if (_currentPlayer == red) {
      _currentPlayer = yellow;
    } else {
      _currentPlayer = red;
    }
  }

  @override
  void setScore(int value) {
    _score = value;
  }

  @override
  List<List<int>> getGrid() {
    return _grid;
  }
}
