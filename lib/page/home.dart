import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  HomePage() : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('すれ違いアプリMOCA'),
      ),
      body: new Padding(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Padding(
                child: new RaisedButton(
                    key: null,
                    onPressed: () => Navigator.of(context).pushNamed("/compose"),
                    color: const Color(0xFFe0e0e0),
                    child: new Text(
                      "とばす",
                      style: new TextStyle(
                          fontSize: 64.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    )),
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              ),
              new Padding(
                child: new RaisedButton(
                    key: null,
                    onPressed: () => Navigator.of(context).pushNamed("/inbox"),
                    color: const Color(0xFFe0e0e0),
                    child: new Text(
                      "ひろう",
                      style: new TextStyle(
                          fontSize: 64.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    )),
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              )
            ]),
        padding: const EdgeInsets.all(10.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshView,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }

  void _refreshView() {
    var settings = Hive.box("settings");
    var major = settings.get("beacon_major_id");
    var minor = settings.get("beacon_minor_id");
    print("beacon_major_id : $major");
    print("beacon_minor_id : $minor");
  }
}
