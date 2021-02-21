import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moca/model/beacon.dart';

class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  void _refreshView() {
    setState(() {
      _data = generateItems(20);
    });
  }
  List<ReceivedBeacon> _data;

  @override
  void initState() {
    super.initState();

    setState(() {
      _data = generateItems(20);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("inbox"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _buildPanel(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshView,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }

  // リストを作成
  List<ReceivedBeacon> generateItems(int numberOfItems) {
    var inbox = Hive.box("inbox");
    int idx_from = inbox.length - 1;
    int idx_to = (inbox.length - numberOfItems - 1 > 0) ? inbox.length - numberOfItems - 1 : 0;
    print(idx_from.toString() + "-" + idx_to.toString());
    List<ReceivedBeacon> result = new List<ReceivedBeacon>();
    if(inbox.length > 0){
      for(int i = idx_from;i > idx_to;i--){
        result.add(inbox.getAt(i));
      }
    }else{
      print("まだ何も受信していないのでは？");
    }
    result.sort((a,b) => a.recvDate.compareTo(b.recvDate));

    return result.reversed.toList();
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((ReceivedBeacon item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
                title: Text("${item.recvDate.year.toString()}年${item.recvDate.month.toString().padLeft(2," ")}月${item.recvDate.day.toString().padLeft(2," ")}日 ${item.recvDate.hour.toString().padLeft(2," ")}:${item.recvDate.minute.toString().padLeft(2," ")}"),
                onTap: () {
                  setState(() {
                    item.isExpanded = !item.isExpanded;
                  });
                });
          },
          body: Padding(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("質問１　×"),
                Text("質問２　〇"),
                Text("質問３　〇"),
                Text("質問４　×"),
                Text("質問５　〇"),
                Text("質問６　×"),
                Text("質問７　×"),
                Text("質問８　×"),
                Text("質問９　×"),
                Text("質問１０　×"),
                Text("質問１１　×"),
                Text("質問１２　×"),
                Text("質問１３　×"),
                Text("質問１４　×"),
                Text("質問１５　×"),
                Text("質問１６　×"),
              ],
            ),
            padding: const EdgeInsets.all(10.0),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
