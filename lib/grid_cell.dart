import 'package:flutter/material.dart';

class GridCell extends StatefulWidget {
  final int column, cellOccupation;
  final ValueSetter<int> onPressed;

  const GridCell(this.column, this.cellOccupation, this.onPressed, {Key? key})
      : super(key: key);

  @override
  State<GridCell> createState() => GridCellState();
}

class GridCellState extends State<GridCell> {
  static final List<Color> colors = [Colors.black, Colors.yellow, Colors.red];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => widget.onPressed(widget.column),
        child: Container(
          color: Colors.blue,
          height: 48,
          width: 48,
          child: Icon(Icons.circle,
              color: colors[widget.cellOccupation], size: 40),
        ));
  }
}
