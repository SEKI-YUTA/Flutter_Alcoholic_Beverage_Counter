import 'package:alcoholic_beverage_counter/screens/graph_screen.dart';
import 'package:alcoholic_beverage_counter/screens/list_screen.dart';
import 'package:alcoholic_beverage_counter/widgets/parameter_row.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static List data = [
    {"name": "jin", "count": 2, "alcoholDegree": 47},
    {"name": "vodka", "count": 2, "alcoholDegree": 40},
  ];
  int _currentIndex = 0;

  late TextEditingController _nameController;
  late TextEditingController _countController;
  late TextEditingController _alcoholDegreeController;
  // List data = [];
  // demo data
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
    _nameController.dispose();
    _countController.dispose();
    _alcoholDegreeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = <Widget>[
      ListScreen(
        data: data,
      ),
      const GraphScreen()
    ];
    return Scaffold(
      body: pages.elementAt(_currentIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text("お酒の追加"),
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
                            setState(() {
                              data.add({
                                "name": _nameController.text,
                                "count": int.parse(_countController.text),
                                "alcoholDegree":
                                    int.parse(_alcoholDegreeController.text)
                              });
                            });
                            Navigator.of(context).pop();
                            return;
                          }
                          return;
                        },
                        child: const Text("追加")),
                    TextButton(
                        onPressed: () {
                          if (Navigator.canPop(context)) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("キャンセル"))
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "リスト"),
          BottomNavigationBarItem(icon: Icon(Icons.auto_graph), label: "グラフ"),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
