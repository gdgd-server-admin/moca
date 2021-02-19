import 'package:flutter/material.dart';

class ComposePage extends StatefulWidget{
  @override
  _CompsoePageState createState() => _CompsoePageState();

}

class _CompsoePageState extends State<ComposePage>{

  void _setBeaconConfig(){

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
  String _question0 = "1個目の質問";
  String _question1 = "2個目の質問";
  String _question2 = "3個目の質問";
  String _question3 = "4個目の質問";
  String _question4 = "5個目の質問";
  String _question5 = "6個目の質問";
  String _question6 = "7個目の質問";
  String _question7 = "8個目の質問";
  String _question8 = "9個目の質問";
  String _question9 = "10個目の質問";
  String _question10 = "11個目の質問";
  String _question11 = "12個目の質問";
  String _question12 = "13個目の質問";
  String _question13 = "14個目の質問";
  String _question14 = "15個目の質問";
  String _question15 = "16個目の質問";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("compose"),
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