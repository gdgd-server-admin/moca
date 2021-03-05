import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ComposePage extends StatefulWidget{
  @override
  _CompsoePageState createState() => _CompsoePageState();

}

class _CompsoePageState extends State<ComposePage>{

  BeaconBroadcast beaconBroadcast = BeaconBroadcast();

  void _setBeaconConfig() async{

    var settings = Hive.box("settings");

    var newMajor = 1; // メジャーバージョン０はiOSに予約されているらしいので避ける
    var newMinor = 0;

    // boolを０１に変換してつなげていく
    var binaryString = "";
    binaryString = binaryString + (_value15 ? "1" : "0");
    binaryString = binaryString + (_value14 ? "1" : "0");
    binaryString = binaryString + (_value13 ? "1" : "0");
    binaryString = binaryString + (_value12 ? "1" : "0");
    binaryString = binaryString + (_value11 ? "1" : "0");
    binaryString = binaryString + (_value10 ? "1" : "0");
    binaryString = binaryString + (_value9 ? "1" : "0");
    binaryString = binaryString + (_value8 ? "1" : "0");
    binaryString = binaryString + (_value7 ? "1" : "0");
    binaryString = binaryString + (_value6 ? "1" : "0");
    binaryString = binaryString + (_value5 ? "1" : "0");
    binaryString = binaryString + (_value4 ? "1" : "0");
    binaryString = binaryString + (_value3 ? "1" : "0");
    binaryString = binaryString + (_value2 ? "1" : "0");
    binaryString = binaryString + (_value1 ? "1" : "0");
    binaryString = binaryString + (_value0 ? "1" : "0");
    // 2バイト分の2進数文字列ができあがる

    newMajor = download_ver;
    newMinor = int.parse(binaryString,radix: 2); // 10進数に変換する

    // 保存処理
    await settings.put("beacon_major_id",newMajor);
    await settings.put("beacon_minor_id",newMinor);

    /*
    設定が保存できたので新しい設定でビーコン送信の初期化処理を行う
     */
    try{
      BeaconStatus transmissionSupportStatus =
      await beaconBroadcast.checkTransmissionSupported();
      bool isAdvertising = await beaconBroadcast.isAdvertising();
      bool isTransmissionSupported =
          transmissionSupportStatus == BeaconStatus.supported;

      print("ビーコン発信中： $isAdvertising");
      print("送信に対応：　$isTransmissionSupported");
      if(isTransmissionSupported){
        beaconBroadcast.stop();
        final String iBeaconFormat =
            'm:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24';
        await beaconBroadcast
            .setUUID(Uuid().v5(Uuid.NAMESPACE_URL, 'moca.gdgd.jp.net'))
            .setIdentifier("moca.gdgd.jp.net")
            .setMajorId(newMajor)
            .setMinorId(newMinor)
            .setLayout(iBeaconFormat)
            .start();
      }else{
        print("やはり対応していないのでは？");
      }
    }catch(e){
      print(e);
    }

    // すべてが終わったらホーム画面に戻る
    Navigator.of(context).pop();
  }

  /* 各回答のフラグ */
  bool _value0 = false;
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;
  bool _value5 = false;
  bool _value6 = false;
  bool _value7 = false;
  bool _value8 = false;
  bool _value9 = false;
  bool _value10 = false;
  bool _value11 = false;
  bool _value12 = false;
  bool _value13 = false;
  bool _value14 = false;
  bool _value15 = false;

  /* 各質問の問題文 */
  String _question0 = "1個目の質問を読込中…";
  String _question1 = "2個目の質問を読込中…";
  String _question2 = "3個目の質問を読込中…";
  String _question3 = "4個目の質問を読込中…";
  String _question4 = "5個目の質問を読込中…";
  String _question5 = "6個目の質問を読込中…";
  String _question6 = "7個目の質問を読込中…";
  String _question7 = "8個目の質問を読込中…";
  String _question8 = "9個目の質問を読込中…";
  String _question9 = "10個目の質問を読込中…";
  String _question10 = "11個目の質問を読込中…";
  String _question11 = "12個目の質問を読込中…";
  String _question12 = "13個目の質問を読込中…";
  String _question13 = "14個目の質問を読込中…";
  String _question14 = "15個目の質問を読込中…";
  String _question15 = "16個目の質問を読込中…";

  int download_ver = 1;

  @override
  void initState(){
    downloadData();
  }

  void downloadData() async {
    print("設定からURLを取り出してデータをダウンロードしてくる");

    var settings = Hive.box("settings");

    var url = await settings.get("server_address");
    print(url);

    final response = await http.get(url);

    print(response.statusCode);

    if(response.statusCode == 200){

      var latest_data = json.decode(response.body);

      setState(() {

        download_ver = latest_data['id'];

        _question0 = latest_data['q1'];
        _question1 = latest_data['q2'];
        _question2 = latest_data['q3'];
        _question3 = latest_data['q4'];
        _question4 = latest_data['q5'];
        _question5 = latest_data['q6'];
        _question6 = latest_data['q7'];
        _question7 = latest_data['q8'];
        _question8 = latest_data['q9'];
        _question9 = latest_data['q10'];
        _question10 = latest_data['q11'];
        _question11 = latest_data['q12'];
        _question12 = latest_data['q13'];
        _question13 = latest_data['q14'];
        _question14 = latest_data['q15'];
        _question15 = latest_data['q16'];
      });

    }else{
      print("データが取得できなかった");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("すれ違いアプリUCON"),
      ),
      body:
      new SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(0.0),
        child:
        new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CheckboxListTile(
                value: _value0,
                onChanged: (value) {
                  setState(() {
                    _value0 = value;
                  });
                },
                title: Text("$_question0"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: _value1,
                onChanged: (value) {
                  setState(() {
                    _value1 = value;
                  });
                },
                title: Text("$_question1"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: _value2,
                onChanged: (value) {
                  setState(() {
                    _value2 = value;
                  });
                },
                title: Text("$_question2"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: _value3,
                onChanged: (value) {
                  setState(() {
                    _value3 = value;
                  });
                },
                title: Text("$_question3"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: _value4,
                onChanged: (value) {
                  setState(() {
                    _value4 = value;
                  });
                },
                title: Text("$_question4"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: _value5,
                onChanged: (value) {
                  setState(() {
                    _value5 = value;
                  });
                },
                title: Text("$_question5"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: _value6,
                onChanged: (value) {
                  setState(() {
                    _value6 = value;
                  });
                },
                title: Text("$_question6"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: _value7,
                onChanged: (value) {
                  setState(() {
                    _value7 = value;
                  });
                },
                title: Text("$_question7"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: _value8,
                onChanged: (value) {
                  setState(() {
                    _value8 = value;
                  });
                },
                title: Text("$_question8"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: _value9,
                onChanged: (value) {
                  setState(() {
                    _value9 = value;
                  });
                },
                title: Text("$_question9"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: _value10,
                onChanged: (value) {
                  setState(() {
                    _value10 = value;
                  });
                },
                title: Text("$_question10"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: _value11,
                onChanged: (value) {
                  setState(() {
                    _value11 = value;
                  });
                },
                title: Text("$_question11"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: _value12,
                onChanged: (value) {
                  setState(() {
                    _value12 = value;
                  });
                },
                title: Text("$_question12"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: _value13,
                onChanged: (value) {
                  setState(() {
                    _value13 = value;
                  });
                },
                title: Text("$_question13"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: _value14,
                onChanged: (value) {
                  setState(() {
                    _value14 = value;
                  });
                },
                title: Text("$_question14"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              CheckboxListTile(
                value: _value15,
                onChanged: (value) {
                  setState(() {
                    _value15 = value;
                  });
                },
                title: Text("$_question15"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),
              ),
              new Container(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                width: 1.7976931348623157e+308,
                height: 80.0,
              )
            ]

        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _setBeaconConfig,
        tooltip: 'Refresh',
        child: Icon(Icons.send),
      ),
    );
  }
}