import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => new _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var _serverAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('すれ違いアプリUCON'),
      ),
      body: new SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(10.0),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Text(
                "サーバアドレス",
                style: new TextStyle(
                    fontSize: 12.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
              new TextField(
                controller: _serverAddress,
                style: new TextStyle(
                    fontSize: 32.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
              Container(
                height: 48.0,
              ),
              Container(
                height: 64.0,
                child: new RaisedButton(
                    key: null,
                    onPressed: buttonPressed,
                    color: const Color(0xFFe0e0e0),
                    child: new Text(
                      "ほぞん",
                      style: new TextStyle(
                          fontSize: 48.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    )),
              ),
            ]),
      ),
    );
  }

  void buttonPressed() async {
    var settings = Hive.box("settings");

    var txt = _serverAddress.text;
    await settings.put("server_address",txt);
    Navigator.of(context).pop();
  }

  @override
  void initState(){
    var settings = Hive.box("settings");
    _serverAddress.text = settings.get("server_address");
  }
}
