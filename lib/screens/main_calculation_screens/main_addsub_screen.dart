import 'package:flutter/material.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/screens/practice_calcultion_screens/practice_screen.dart';
import 'package:infinite_calculation/screens/tutorial/addsubtutorial_screen.dart';
import 'package:infinite_calculation/widget/modeselect_button.dart';

class MainAddSubScreen extends StatefulWidget {
  @override
  _MainAddSubScreenState createState() => _MainAddSubScreenState();
}

class _MainAddSubScreenState extends State<MainAddSubScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('덧셈과 뺄셈'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            modeSelectbutton(
              text: '괄호와 양의 부호 생략\n튜토리얼',
              moveScreen: AddSubTutorialScreen(),
            ),
            modeSelectbutton(
              text: '괄호와 양의 부호가 생략된\n덧셈과 뺄셈',
              moveScreen:
                  PracticeScreen(calculationType: CalculationType.addSub),
            ),
          ],
        ),
      ),
    );
  }
}
