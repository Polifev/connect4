abstract class ISituation {
  List<ISituation> getNextSituations();

  List<int> getPossibleIndex();

  int checkIfFinished();

  ISituation? play(int move);

  ISituation getCopy();

  int getScore();

  void setScore(int value);

  List<List<int>> getGrid();

  int getCurrentplayer();
}
