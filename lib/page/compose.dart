import 'package:flutter/material.dart';

class ComposePage extends StatefulWidget{
  @override
  _CompsoePageState createState() => _CompsoePageState();

}

class _CompsoePageState extends State<ComposePage>{

  void _setBeaconConfig(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      body: Center(
        child: Text("not implemented"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _setBeaconConfig,
        tooltip: 'Refresh',
        child: Icon(Icons.send),
      ),
    );
  }

}