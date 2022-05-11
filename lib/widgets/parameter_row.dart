import 'package:flutter/material.dart';

class ParameterRow extends StatelessWidget {
  ParameterRow(
      {Key? key,
      required this.controller,
      required this.rowName,
      this.tailText})
      : super(key: key);

  final TextEditingController controller;
  final String rowName;
  final String? tailText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(rowName),
        SizedBox(
          width: 10,
        ),
        Flexible(child: TextFormField(controller: controller)),
        tailText != null ? Text(tailText ?? "") : Text("")
      ],
    );
  }
}
