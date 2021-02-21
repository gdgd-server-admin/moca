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
                Text("質問１　" + (item.answer0 ? "☑" : "☐")),
                Text("質問２　" + (item.answer1 ? "☑" : "☐")),
                Text("質問３　" + (item.answer2 ? "☑" : "☐")),
                Text("質問４　" + (item.answer3 ? "☑" : "☐")),
                Text("質問５　" + (item.answer4 ? "☑" : "☐")),
                Text("質問６　" + (item.answer5 ? "☑" : "☐")),
                Text("質問７　" + (item.answer6 ? "☑" : "☐")),
                Text("質問８　" + (item.answer7 ? "☑" : "☐")),
                Text("質問９　" + (item.answer8 ? "☑" : "☐")),
                Text("質問１０　" + (item.answer9 ? "☑" : "☐")),
                Text("質問１１　" + (item.answer10 ? "☑" : "☐")),
                Text("質問１２　" + (item.answer11 ? "☑" : "☐")),
                Text("質問１３　" + (item.answer12 ? "☑" : "☐")),
                Text("質問１４　" + (item.answer13 ? "☑" : "☐")),
                Text("質問１５　" + (item.answer14 ? "☑" : "☐")),
                Text("質問１６　" + (item.answer15 ? "☑" : "☐")),
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
