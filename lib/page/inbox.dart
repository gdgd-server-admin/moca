import 'package:flutter/material.dart';

class InboxPage extends StatefulWidget{
  @override
  _InboxPageState createState() => _InboxPageState();

}

class _InboxPageState extends State<InboxPage>{

  void _refreshView() {}

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
        onPressed: _refreshView,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }

}