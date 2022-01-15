import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String a = '3';
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Math.tex(
          r'\frac {' '$a' r'} {8}-(1-(-\frac {1}{6})^56)=',
          textStyle: TextStyle(
            fontSize: 50,
          ),
        ),
      ),
    ]);
  }
}
