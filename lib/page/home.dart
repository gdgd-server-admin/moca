import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  HomePage() : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();

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
                    onPressed: () =>
                        Navigator.of(context).pushNamed("/compose"),
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

  @override
  void initState() {
    super.initState();

    initBeacon();
  }

  void _refreshView() {
    var settings = Hive.box("settings");
    var major = settings.get("beacon_major_id");
    var minor = settings.get("beacon_minor_id");
    print("beacon_major_id : $major");
    print("beacon_minor_id : $minor");
  }

  void initBeacon() async {
    try {
      // or if you want to include automatic checking permission
      await flutterBeacon.initializeAndCheckScanning;

      var settings = Hive.box("settings");
      var major = await settings.get("beacon_major_id");
      var minor = await settings.get("beacon_minor_id");
      if (major != null && minor != null) {
        // 設定が保存されているのでビーコン送信処理を初期化して送信を始める
        try {
          BeaconStatus transmissionSupportStatus = await beaconBroadcast.checkTransmissionSupported();
          bool isAdvertising = await beaconBroadcast.isAdvertising();

          if (!isAdvertising && transmissionSupportStatus == BeaconStatus.supported) {
            await beaconBroadcast
                .setUUID(Uuid().v5(Uuid.NAMESPACE_URL, 'moca.gdgd.jp.net'))
                .setMajorId(major)
                .setMinorId(minor)
                .start();
          }
        } catch (e) {
          print("ビーコンを送信しようとしてエラー");
          print(e);
        }
      }
    } on PlatformException catch (e) {
      // library failed to initialize, check code and message
      print(e);
    }
  }
}
