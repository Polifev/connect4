import 'package:flutter/material.dart';
import 'package:flutter_application_1/grid_cell.dart';

class Grid extends StatefulWidget {
  final int width, height;
  const Grid(this.width, this.height, {Key? key}) : super(key: key);

  @override
  State<Grid> createState() => GridState();
}

class GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = <Widget>[];
    for (int i = 0; i < widget.height; i++) {
      List<Widget> sublist = <Widget>[];
      for (int j = 0; j < widget.width; j++) {
        int occupation = 0;
        // TODO: get real occupation from model
        // TODO: forward callback to player if it is player's turn
        GridCell cell = GridCell(j, occupation, printColumn);
        sublist.add(cell);
      }
      list.add(
          Row(children: sublist, mainAxisAlignment: MainAxisAlignment.center));
    }
    return Column(
      children: list,
    );
  }

  void printColumn(int col) {
    SnackBar snackBar = SnackBar(
      content: Text("Column pressed: $col"),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
