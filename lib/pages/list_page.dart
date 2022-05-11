import 'package:alcoholic_beverage_counter/widgets/list_item.dart';
import 'package:alcoholic_beverage_counter/widgets/parameter_row.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late TextEditingController _nameController;
  late TextEditingController _countController;
  late TextEditingController _alcoholDegreeController;
  // List data = [];
  // demo data
  List data = [
    {"name": "jin", "count": 2, "alcoholDegree": 47},
    {"name": "vodka", "count": 2, "alcoholDegree": 40},
  ];
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _countController = TextEditingController();
    _alcoholDegreeController = TextEditingController();
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
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  "飲んだお酒一覧",
                  style: TextStyle(color: Colors.grey[600], fontSize: 20),
                ),
              ),
              Expanded(
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
                        deleteItem: () {
                          setState(() {
                            data.removeAt(index);
                          });
                        },
                      )),
                  itemCount: data.length,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          print("pressed");
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("お酒の追加"),
                  content: Column(
                    children: [
                      ParameterRow(
                        controller: _nameController,
                        rowName: "名前",
                      ),
                      ParameterRow(
                        controller: _countController,
                        rowName: "杯数",
                        tailText: "杯",
                      ),
                      ParameterRow(
                        controller: _alcoholDegreeController,
                        rowName: "アルコール度数",
                        tailText: "%",
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          if (_nameController.text != "" &&
                              _countController.text != "" &&
                              _alcoholDegreeController.text != "") {
                            data.add({
                              "name": _nameController.text,
                              "count": int.parse(_countController.text),
                              "alcoholDegree":
                                  int.parse(_alcoholDegreeController.text)
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
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "リスト"),
        BottomNavigationBarItem(icon: Icon(Icons.auto_graph), label: "グラフ"),
      ]),
    );
  }
}
