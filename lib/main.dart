import 'package:flutter/material.dart';
import 'package:connect_4/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connect 4',
      theme: ThemeData(
          primarySwatch: Colors.green, scaffoldBackgroundColor: Colors.grey),
      home: const MyHomePage(title: 'AI powered Connect 4'),
    );
  }
}
