import 'package:flutter/material.dart';

class Symbols extends StatelessWidget {
  String value;
  Function pressSymbols;
  bool isPressed;

  Symbols(this.value, this.pressSymbols, this.isPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 50,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              primary: Colors.orange,
              onSurface: Colors.orange,
              elevation: 0,
              backgroundColor:isPressed? Colors.orange:Colors.grey),
          onPressed: isPressed ? () => {pressSymbols(value)} : null,
          child: Text(
            value,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          )),
    );
  }
}
