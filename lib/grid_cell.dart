import 'package:flutter/material.dart';

class GridCell extends StatelessWidget {
  final int column, cellOccupation;
  final ValueSetter<int> onPressed;
  static final List<Color> colors = [Colors.white, Colors.red, Colors.yellow];

  const GridCell(this.column, this.cellOccupation, this.onPressed, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onPressed(column),
        child: Container(
          color: Colors.blue,
          height: 48,
          width: 48,
          child: Icon(Icons.circle, color: colors[cellOccupation], size: 40),
        ));
  }
}
