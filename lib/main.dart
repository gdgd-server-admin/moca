import 'package:flutter/material.dart';
import 'package:moca/model/beacon_adapter.dart';

import 'package:moca/page/inbox.dart';
import 'package:moca/page/home.dart';
import 'package:moca/page/compose.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.registerAdapter(BeaconAdapter());
  await Hive.openBox('settings'); // 設定用のBoxを開いておく
  await Hive.openBox('logs'); // 受診ログのBoxも開いておく
  await Hive.openBox('inbox'); // 画面表示用データを保存するBoxも開いておく
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
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),

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

