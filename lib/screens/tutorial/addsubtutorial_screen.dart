import 'package:flutter/material.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/model/config_data.dart';
import 'package:infinite_calculation/widget/circledsign.dart';
import 'package:provider/provider.dart';

class AddSubTutorialScreen extends StatefulWidget {
  @override
  _AddSubTutorialScreenState createState() => _AddSubTutorialScreenState();
}

class _AddSubTutorialScreenState extends State<AddSubTutorialScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late TabController tabController;
  String fontFamily = 'ONEMobilePOP';
  Color highlight1 = Colors.redAccent;
  Color highlight2 = Colors.blueAccent;
  Color highlight3 = Colors.orange;
  Color highlight4 = Colors.deepPurpleAccent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1) * 0.3,
    );

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    _isDarkMode = Provider.of<ConfigData>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text('설명(옆으로 넘기세요)'),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 30.0,
                        color: !_isDarkMode ? workShopBlack : Color(0xffffffff),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '양수는 ',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        TextSpan(
                          text: '양의 부호와 괄호를 생략',
                          style: TextStyle(
                            color: highlight3,
                            fontSize: 30.0,
                          ),
                        ),
                        TextSpan(
                          text: '하여 나타낼 수 있다.',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '(',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '+',
                        color:
                            highlight1.withOpacity(animationController.value),
                      ),
                      Text(
                        '3',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '=3',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '(',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '+',
                        color:
                            highlight1.withOpacity(animationController.value),
                      ),
                      Text(
                        '3',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '+',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '(',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '+',
                        color:
                            highlight1.withOpacity(animationController.value),
                      ),
                      Text(
                        '2',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '=3+2',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '(',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '+',
                        color:
                            highlight1.withOpacity(animationController.value),
                      ),
                      Text(
                        '2',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '-',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '(',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '+',
                        color:
                            highlight1.withOpacity(animationController.value),
                      ),
                      Text(
                        '4',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '=2-4',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '2+5=',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '(',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '+',
                        color:
                            highlight1.withOpacity(animationController.value),
                      ),
                      Text(
                        '2',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '+',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '(',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '+',
                        color:
                            highlight1.withOpacity(animationController.value),
                      ),
                      Text(
                        '5',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '1-3=',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '(',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '+',
                        color:
                            highlight1.withOpacity(animationController.value),
                      ),
                      Text(
                        '1',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '-',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '(',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '+',
                        color:
                            highlight1.withOpacity(animationController.value),
                      ),
                      Text(
                        '3',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 30.0,
                        color: !_isDarkMode ? workShopBlack : Color(0xffffffff),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '음수는 ',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        TextSpan(
                          text: '식의 맨 앞에 나올 때 괄호를 생략',
                          style: TextStyle(
                            color: highlight3,
                            fontSize: 30.0,
                          ),
                        ),
                        TextSpan(
                          text: '하여 나타낼 수 있다.',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '(',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '-',
                        color:
                            highlight2.withOpacity(animationController.value),
                      ),
                      Text(
                        '2',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '=',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '-',
                        color:
                            highlight2.withOpacity(animationController.value),
                      ),
                      Text(
                        '2',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '(',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '-',
                        color:
                            highlight2.withOpacity(animationController.value),
                      ),
                      Text(
                        '2',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '+',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '(',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '+',
                        color:
                            highlight1.withOpacity(animationController.value),
                      ),
                      Text(
                        '4',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '=',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '-',
                        color:
                            highlight2.withOpacity(animationController.value),
                      ),
                      Text(
                        '2+4',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '(',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '+',
                        color:
                            highlight1.withOpacity(animationController.value),
                      ),
                      Text(
                        '3',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '-',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '(',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '-',
                        color:
                            highlight2.withOpacity(animationController.value),
                      ),
                      Text(
                        '4',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '=3-(',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '-',
                        color:
                            highlight2.withOpacity(animationController.value),
                      ),
                      Text(
                        '4)',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '-1-3=',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '(',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '-',
                        color:
                            highlight2.withOpacity(animationController.value),
                      ),
                      Text(
                        '1',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '-',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        '(',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '+',
                        color:
                            highlight1.withOpacity(animationController.value),
                      ),
                      Text(
                        '3',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          color: highlight3,
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TabPageSelector(
            controller: tabController,
          ),
        ],
      ),
    );
  }
}
