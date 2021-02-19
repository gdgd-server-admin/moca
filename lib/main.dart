import 'package:flutter/material.dart';

import 'package:moca/page/inbox.dart';
import 'package:moca/page/home.dart';
import 'package:moca/page/compose.dart';

void main() {
  runApp(MocaApp());
}

class MocaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'すれ違いアプリMOCA',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomePage(),
        '/compose': (BuildContext context) => new ComposePage(),
        '/inbox': (BuildContext context) => new InboxPage(),
      },
    );
  }
}

