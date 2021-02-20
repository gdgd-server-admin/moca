import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:hive/hive.dart';
import 'package:moca/model/beacon.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  HomePage() : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();
  final StreamController<String> beaconEventsController =
  StreamController<String>.broadcast();

  bool isMonitorStarted = false;
  bool isTransmissionStarted = false;
  bool isMonitorCheckPassed = false;
  bool isTransmissionCheckPassed = false;

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
              ),
              new Padding(
                padding: EdgeInsets.all(10.0),
                child:
                    Text(isTransmissionCheckPassed ? "ビーコン送信可能" : "ビーコン送信不可"),
              ),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(isTransmissionStarted ? "ビーコン送信開始" : "ビーコン未送信")),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(isMonitorCheckPassed ? "ビーコン受信可能" : "ビーコン受信不可")),
              new Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(isMonitorStarted ? "ビーコン受信開始" : "ビーコン未受信"),
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
      /* ビーコン送信処理の初期化 */
      var settings = Hive.box("settings");
      var major = await settings.get("beacon_major_id");
      var minor = await settings.get("beacon_minor_id");
      if (major != null && minor != null) {
        // 設定が保存されているのでビーコン送信処理を初期化して送信を始める
        try {
          BeaconStatus transmissionSupportStatus =
              await beaconBroadcast.checkTransmissionSupported();
          bool isAdvertising = await beaconBroadcast.isAdvertising();
          bool isTransmissionSupported =
              transmissionSupportStatus == BeaconStatus.supported;

          print("ビーコン発信中： $isAdvertising");
          print("送信に対応：　$isTransmissionSupported");

          if (!isAdvertising && isTransmissionSupported) {
            setState(() {
              isTransmissionCheckPassed = true;
            });
            final String iBeaconFormat =
                'm:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24';
            await beaconBroadcast
                .setUUID(Uuid().v5(Uuid.NAMESPACE_URL, 'moca.gdgd.jp.net'))
                .setIdentifier("moca.gdgd.jp.net")
                .setMajorId(major)
                .setMinorId(minor)
                .setLayout(iBeaconFormat)
                .start();
            print("ビーコンを送り始めた");
            setState(() {
              isTransmissionStarted = true;
            });
          } else {
            print("対応していないのでは？");
          }
        } catch (e) {
          print("ビーコンを送信しようとしてエラー");
          print(e);
        }
      }

      /* ビーコン受信処理の初期化 */
      await flutterBeacon.initializeScanning;

      AuthorizationStatus status = await flutterBeacon.authorizationStatus;
      if (! (status == AuthorizationStatus.allowed
          || status == AuthorizationStatus.always
          || status == AuthorizationStatus.whenInUse)) {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("位置情報サービスをオンにする必要があります"))
        );
        return;
      }
      setState(() {
        isMonitorCheckPassed = true;
      });

      final regions = <Region>[
        Region(
          identifier: 'moca.gdgd.jp.net',
          proximityUUID: Uuid().v5(Uuid.NAMESPACE_URL, 'moca.gdgd.jp.net'),
        ),
      ];

      StreamSubscription streamRanging = flutterBeacon.ranging(regions).listen((RangingResult result) {
        if (result != null && result.beacons.isNotEmpty) {
          result.beacons.forEach((beacon) {
            if (beacon.proximityUUID.toLowerCase() == Uuid().v5(Uuid.NAMESPACE_URL, 'moca.gdgd.jp.net').toString().toLowerCase()) {
              print('beaconを検出したよ！');
              print(beacon.toJson.toString());
              ReceivedBeacon recv = new ReceivedBeacon();
              recv.recvDate = DateTime.now();
              recv.rawMajor = beacon.major;
              recv.rawMinor = beacon.minor;

              // 数値からフラグに変換する処理を呼び出す

              var inbox = Hive.box("logs");
              inbox.put(beacon.macAddress,recv);
            }
          });
        }
      });

      StreamSubscription streamMonitoring = flutterBeacon.monitoring(regions).listen((MonitoringResult result) {
        if (result != null && result.region != null) {
          // バックグラウンドで動かすならモニタリングのほうがいいようだが？
          // Rangingのデータは貯めておいて離れたタイミングで書き込みに行く？
        }
      });

      setState(() {
        isMonitorStarted = true;
      });

    } on PlatformException catch (e) {
      // library failed to initialize, check code and message
      print(e);
    }
  }
}
