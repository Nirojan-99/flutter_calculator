import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  var value;
  Display(this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        width: double.infinity,
        padding: EdgeInsets.all(15),
        child: Text(
          value,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.orange),
        ));
  }
}
