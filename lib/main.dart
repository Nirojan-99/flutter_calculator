import 'package:dummy_app/Widgets/Display.dart';
import 'package:dummy_app/Widgets/NumbersRow.dart';
import 'package:dummy_app/Widgets/Symbols.dart';
import 'package:dummy_app/Widgets/numbers.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var value = [];
  String total = "";
  String AC = "AC";
  bool isPressed = false;
  bool isAddable = true;
  String enteredNum = "";

  void rearrange(var array, int num) {
    if (num == array.length) {
      return;
    } else {
      if (num + 2 <= array.length - 1) {
        array[num] = array[num + 2];
        rearrange(array, num + 1);
      } else {
        return;
      }
    }
  }

  void positionCal(var array, var add, var sub, var mul, var div) {
    add.length = 0;
    sub.length = 0;
    mul.length = 0;
    div.length = 0;

    for (int i = 0; i < array.length; i++) {
      if (array[i] == "+") {
        add.add(i);
      } else if (array[i] == "-") {
        sub.add(i);
      } else if (array[i] == "*") {
        mul.add(i);
      } else if (array[i] == "/") {
        div.add(i);
      }
    }
  }

  void cal(var array) {
    var add = [];
    var sub = [];
    var mul = [];
    var div = [];

    positionCal(array, add, sub, mul, div);

    for (var i = 0; i < div.length; i++) {
      for (int item in div) {
        double val =
            double.parse(array[item - 1]) / double.parse(array[item + 1]);
        array[item - 1] = val.toString();
        rearrange(array, item);
        array.length -= 2;
      }
    }

    positionCal(array, add, sub, mul, div);

    for (var i = 0; i < mul.length; i++) {
      for (int item in mul) {
        double val =
            double.parse(array[item - 1]) * double.parse(array[item + 1]);
        array[item - 1] = val.toString();
        rearrange(array, item);
        array.length -= 2;
      }
    }

    positionCal(array, add, sub, mul, div);

    for (var i = 0; i < add.length; i++) {
      for (int item in add) {
        double val =
            double.parse(array[item - 1]) + double.parse(array[item + 1]);
        array[item - 1] = val.toString();
        rearrange(array, item);
        array.length -= 2;
      }
    }

    positionCal(array, add, sub, mul, div);

    for (var i = 0; i < sub.length; i++) {
      for (int item in sub) {
        double val =
            double.parse(array[item - 1]) - double.parse(array[item + 1]);
        array[item - 1] = val.toString();
        rearrange(array, item);
        array.length -= 2;
      }
    }
  }

//add to array
  void addValue(String number) {
    setState(() {
      for (var i = 0; i < 10; i++) {
        if (number == i.toString() || number == ".") {
          isPressed = true;
          break;
        } else {
          isPressed = false;
        }
      }

      if (number == "AC" || number == "C") {
        value.length = 0;
        total = "";
        enteredNum = "";
        AC = "AC";
      } else if (number == "BS") {
        // value.length > 0 ? value.length -= 1 : value.length = 0;

      } else if (number == "=") {
        value.add(enteredNum);
        isPressed = true;
        cal(value);
        total = value[0];
        print(value);
        return;
      } else if (number == "%") {
        value.add(enteredNum);
        cal(value);
        value.add("/");
        value.add("100");
        cal(value);
        total = value[0] + "%";
      } else {
        //else part
        if (enteredNum.length > 0) {
          if (number == "+" ||
              number == "-" ||
              number == "*" ||
              number == "/") {
            isAddable = true;
          } else {
            for (var i = 0; i < 10; i++) {
              if (enteredNum[enteredNum.length - 1] == i.toString() ||
                  enteredNum[enteredNum.length - 1] == ".") {
                isAddable = false;
                enteredNum += number;
                break;
              }
            }
          }
        } else {
          enteredNum += number;
          isAddable = false;
        }

        if (isAddable) {
          value.add(enteredNum);
          value.add(number);
          enteredNum = "";
        }
        total += number;
      }
    });

    // total = "";
    // for (String i in value) {
    //   total += i;
    // }
    if (!value.isEmpty) {
      AC = "C";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Calculator"),
          ),
          body: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[Display(total)],
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      // NumbersRow(AC, "BS", "%", "/", addValue),
                      // NumbersRow("7", "8", "9", "*", addValue),
                      // NumbersRow("4", "5", "6", "-", addValue),
                      // NumbersRow("1", "2", "3", "+", addValue),
                      // NumbersRow("", "0", ".", "=", addValue),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Symbols("AC", addValue, true),
                            Symbols("BS", addValue, true),
                            Symbols("%", addValue, isPressed),
                            Symbols("/", addValue, isPressed)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Numbers("7", addValue),
                            Numbers("8", addValue),
                            Numbers("9", addValue),
                            Symbols("*", addValue, isPressed)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Numbers("4", addValue),
                            Numbers("5", addValue),
                            Numbers("6", addValue),
                            Symbols("-", addValue, isPressed)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Numbers("1", addValue),
                            Numbers("2", addValue),
                            Numbers("3", addValue),
                            Symbols("+", addValue, isPressed)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Numbers(null, addValue),
                            Numbers("0", addValue),
                            Numbers(".", addValue),
                            Symbols("=", addValue, isPressed)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
