import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:connect_4/grid_cell.dart';

class Grid extends StatelessWidget {
  final List<List<int>> gridContent;
  final ValueSetter<int> onColumnClick;
  const Grid(this.gridContent, this.onColumnClick, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int height = gridContent.length;
    int width = gridContent[0].length;

    List<Widget> list = <Widget>[];
    for (int i = 0; i < height; i++) {
      List<Widget> sublist = <Widget>[];
      for (int j = 0; j < width; j++) {
        int cellContent = gridContent[height - i - 1][j];
        GridCell cell = GridCell(j, cellContent, onColumnClick);
        sublist.add(cell);
      }
      list.add(
          Row(children: sublist, mainAxisAlignment: MainAxisAlignment.center));
    }
    return Column(
      children: list,
    );
  }
}
