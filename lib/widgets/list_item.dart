import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  ListItem(
      {Key? key,
      required this.data,
      required this.index,
      required this.incrementCount,
      required this.decrementCount,
      required this.deleteItem})
      : super(key: key);
  List data;
  int index;
  Function()? incrementCount;
  Function()? decrementCount;
  Function()? deleteItem;
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _countEditingController = TextEditingController();
  TextEditingController _percentEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onLongPress: () {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text("名前の変更"),
                    content: Column(
                      children: [
                        Flexible(
                            child: TextFormField(
                          initialValue: data[index]["name"],
                          controller: _nameEditingController,
                        ))
                      ],
                    ),
                  );
                });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: Colors.grey.withOpacity(0.3)))),
            padding:
                const EdgeInsets.only(left: 30, top: 20, bottom: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    data[index]["name"],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(children: [
                  IconButton(
                      // increment count
                      onPressed: incrementCount,
                      icon: Icon(Icons.add)),
                  IconButton(
                      // decrement count
                      onPressed: decrementCount,
                      icon: Icon(Icons.remove))
                ]),
                Text(
                  data[index]["count"].toString(),
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                    // delete item
                    onPressed: deleteItem,
                    icon: Icon(Icons.delete))
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 10,
            left: 30,
            child: Text("${data[index]["alcoholDegree"].toString()}%"))
      ],
    );
  }
}
