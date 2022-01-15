import 'package:flutter/material.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/model/config_data.dart';
import 'package:infinite_calculation/widget/circledsign.dart';
import 'package:provider/provider.dart';

class SubTutorialScreen extends StatefulWidget {
  @override
  _SubTutorialScreenState createState() => _SubTutorialScreenState();
}

class _SubTutorialScreenState extends State<SubTutorialScreen>
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
                          text: '빼는 수의 부호',
                          style: TextStyle(
                            color: highlight4,
                            fontSize: 30.0,
                          ),
                        ),
                        TextSpan(
                          text: '를 ',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        TextSpan(
                          text: '바꾸어 더한다.',
                          style: TextStyle(
                            color: highlight3,
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
                        '(-5)-(+3)=?',
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
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '-',
                        color: highlight1.withOpacity(0.0),
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
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '-',
                        color: highlight3,
                      ),
                      Text(
                        '(',
                        style: TextStyle(
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
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '=(',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '-',
                        color: highlight1.withOpacity(0.0),
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
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '+',
                        color: highlight3,
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
                        '3',
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '=-8',
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
                        '(-5)-(+3)=-8',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
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
                          text: '빼는 수의 부호',
                          style: TextStyle(
                            color: highlight4,
                            fontSize: 30.0,
                          ),
                        ),
                        TextSpan(
                          text: '를 ',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        TextSpan(
                          text: '바꾸어 더한다.',
                          style: TextStyle(
                            color: highlight3,
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
                        '(-2)-(-5)=?',
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
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '-',
                        color: highlight1.withOpacity(0.0),
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
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '-',
                        color: highlight3,
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
                        '5',
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '=(',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '-',
                        color: highlight1.withOpacity(0.0),
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
                          fontSize: 40.0,
                        ),
                      ),
                      CircledSign(
                        text: '+',
                        color: highlight3,
                      ),
                      Text(
                        '(',
                        style: TextStyle(
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
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '=+3',
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
                        '(-2)-(-5)=+3',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
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
