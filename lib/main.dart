import 'package:flutter/material.dart';

import './screen/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.orange,
        fontFamily: 'Lato',
      ),
      home: ProtuctsOverviewScreen(),
    );
  }
}
