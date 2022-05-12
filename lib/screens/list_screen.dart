import 'package:alcoholic_beverage_counter/widgets/list_item.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key? key, required this.data}) : super(key: key);
  List data;

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      data: widget.data,
                      index: index,
                      incrementCount: () {
                        setState(() {
                          widget.data[index]["count"] += 1;
                        });
                      },
                      decrementCount: () {
                        setState(() {
                          if (widget.data[index]["count"] <= 0) return;
                          widget.data[index]["count"] -= 1;
                        });
                      },
                      deleteItem: () {
                        setState(() {
                          widget.data.removeAt(index);
                        });
                      },
                    )),
                itemCount: widget.data.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
