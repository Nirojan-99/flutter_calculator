import 'package:flutter/material.dart';

class Numbers extends StatefulWidget {
  final _value;
  final Function addValue;
  const Numbers(this._value, this.addValue);

  @override
  State<Numbers> createState() => _NumbersState();
}

class _NumbersState extends State<Numbers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 50,
      child:widget._value == null ? SizedBox() : OutlinedButton(
          style: OutlinedButton.styleFrom(
              primary: Colors.blue,
              onSurface: Colors.blue,
              elevation: 0,
              backgroundColor: Colors.blue),
          onPressed: () => {widget.addValue(widget._value)},
          child: Text(
            widget._value,
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          )),
    );
  }
}
