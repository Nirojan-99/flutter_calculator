import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'numbers.dart';

class NumbersRow extends StatelessWidget {
  final String _num1;
  final String num2;
  final String num3;
  final String num4;
  final Function addValue;
  const NumbersRow(this._num1, this.num2, this.num3, this.num4, this.addValue);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Numbers(_num1, addValue),
          Numbers(num2, addValue),
          Numbers(num3, addValue),
          Numbers(num4, addValue),
        ],
      ),
    );
  }
}
