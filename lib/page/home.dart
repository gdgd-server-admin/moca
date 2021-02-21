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
          if (major != null && minor != null) {
            // 設定が保存されているのでビーコン送信処理を初期化して送信を始める
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
          }
        } else {
          print("対応していないのでは？");
        }
      } catch (e) {
        print("ビーコンを送信しようとしてエラー");
        print(e);
      }

      /* ビーコン受信処理の初期化 */
      await flutterBeacon.initializeScanning;

      AuthorizationStatus status = await flutterBeacon.authorizationStatus;
      if (!(status == AuthorizationStatus.allowed ||
          status == AuthorizationStatus.always ||
          status == AuthorizationStatus.whenInUse)) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("位置情報サービスをオンにする必要があります")));
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

      flutterBeacon.ranging(regions).listen((RangingResult result) {
        if (result != null && result.beacons.isNotEmpty) {
          result.beacons.forEach((beacon) {
            if (beacon.proximityUUID.toLowerCase() ==
                Uuid()
                    .v5(Uuid.NAMESPACE_URL, 'moca.gdgd.jp.net')
                    .toString()
                    .toLowerCase()) {
              print('beaconを検出したよ！');
              print(beacon.toJson.toString());
              ReceivedBeacon recv = new ReceivedBeacon();
              recv.recvDate = DateTime.now();
              recv.rawMajor = beacon.major;
              recv.rawMinor = beacon.minor;
              recv.ExtractMinor(); // 予め展開しておく

              // 数値からフラグに変換する処理を呼び出す

              var buffer = Hive.box("logs");
              buffer.put(beacon.macAddress, recv);
            }
          });
        }
      });

      flutterBeacon.monitoring(regions).listen((MonitoringResult result) {
        if (result != null && result.region != null) {
          // Rangingのデータは貯めておいて離れたタイミングで書き込みに行く
          if (result.monitoringEventType == MonitoringEventType.didExitRegion) {
            print("ビーコンのやり取りが終わったので画面に反映するよ");
            /*
            ここに到達する条件は
            「周りに存在していたmoca.gdgd.jp.netなビーコンが1個もなくなった」
            なので、この後行われる画面のリフレッシュの瞬間を目撃しても発信者の特定は難しい（はず）
             */
            var inbox = Hive.box("inbox");
            var buffer = Hive.box("logs");
            for (var i = 0; i < buffer.length; i++) {
              var row = buffer.getAt(i) as ReceivedBeacon;
              var newrow = new ReceivedBeacon();
              newrow.recvDate = row.recvDate;
              newrow.rawMajor = row.rawMajor;
              newrow.rawMinor = row.rawMinor;
              newrow.answer0 = row.answer0;
              newrow.answer1 = row.answer1;
              newrow.answer2 = row.answer2;
              newrow.answer3 = row.answer3;
              newrow.answer4 = row.answer4;
              newrow.answer5 = row.answer5;
              newrow.answer6 = row.answer6;
              newrow.answer7 = row.answer7;
              newrow.answer8 = row.answer8;
              newrow.answer9 = row.answer9;
              newrow.answer10 = row.answer10;
              newrow.answer11 = row.answer11;
              newrow.answer12 = row.answer12;
              newrow.answer13 = row.answer13;
              newrow.answer14 = row.answer14;
              newrow.answer15 = row.answer15;
              inbox.add(newrow); // コピーしたオブジェクトを保存用のBoxへ
            }
            buffer.clear(); // inboxに移し終わったので中身を空にする
          }
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
