import 'package:alcoholic_beverage_counter/widgets/list_item.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late TextEditingController _nameController;
  late TextEditingController _countController;
  // List data = [];
  // demo data
  List data = [
    {"name": "jin", "count": 2},
    {"name": "vodka", "count": 2},
  ];
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _countController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemBuilder: ((context, index) => ListItem(
                data: data,
                index: index,
                incrementCount: () {
                  setState(() {
                    data[index]["count"] += 1;
                  });
                },
                decrementCount: () {
                  setState(() {
                    if (data[index]["count"] <= 0) return;
                    data[index]["count"] -= 1;
                  });
                },
              )),
          itemCount: data.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("pressed");
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("お酒の追加"),
                  content: Column(
                    children: [
                      Flexible(
                          child: TextFormField(controller: _nameController)),
                      Flexible(
                          child: TextFormField(
                        controller: _countController,
                        keyboardType: TextInputType.number,
                      )),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          if (_nameController.text != "" &&
                              _countController.text != "") {
                            data.add({
                              "name": _nameController.text,
                              "count": int.parse(_countController.text)
                            });
                            Navigator.of(context).pop();
                            return;
                          }
                          return;
                        },
                        child: Text("追加")),
                    TextButton(
                        onPressed: () {
                          if (Navigator.canPop(context)) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text("キャンセル"))
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
