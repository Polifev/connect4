import 'package:flutter/material.dart';

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
        sublist.add(
          Container(
              color: Colors.blue, height: 48, width: 48, child: Text("$i;$j")),
        );
      }
      list.add(Row(
        children: sublist,
      ));
    }
    return Center(child: Column(children: list));
  }
}
