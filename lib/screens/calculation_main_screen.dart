import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/model/admob.dart';
import 'package:infinite_calculation/model/config_data.dart';
import 'package:infinite_calculation/screens/main_calculation_screens/main_add_screen.dart';
import 'package:infinite_calculation/screens/main_calculation_screens/main_addsub_screen.dart';
import 'package:infinite_calculation/screens/main_calculation_screens/main_div_screen.dart';
import 'package:infinite_calculation/screens/main_calculation_screens/main_mix_screen.dart';
import 'package:infinite_calculation/screens/main_calculation_screens/main_mul_screen.dart';
import 'package:infinite_calculation/screens/main_calculation_screens/main_sub_screen.dart';
import 'package:infinite_calculation/widget/calculationtype_button.dart';
import 'package:infinite_calculation/widget/fractionwidget.dart';
import 'package:infinite_calculation/widget/powerwidget.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class CalculationMainScreen extends StatefulWidget {
  const CalculationMainScreen({Key? key}) : super(key: key);

  @override
  _CalculationMainScreenState createState() => _CalculationMainScreenState();
}

class _CalculationMainScreenState extends State<CalculationMainScreen> {
  AdMob adMob = AdMob();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adMob.myBanner.load();
  }

  //rive 다크모드 스위치 세팅
  SMIBool? rive_isDarkMode;
  SMIBool? rive_isInitDarkMode;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    // rive_isInitDarkMode =
    //     controller.findInput<bool>('isInitDarkMode') as SMIBool;
    // if (rive_isInitDarkMode != null) {
    //   rive_isInitDarkMode!
    //       .change(Provider.of<ConfigData>(context, listen: false).isDarkMode);
    // }
    rive_isDarkMode = controller.findInput<bool>('isDarkMode') as SMIBool;
    if (rive_isDarkMode != null) {
      rive_isDarkMode!
          .change(Provider.of<ConfigData>(context, listen: false).isDarkMode);
    }
  }

  _darkModeSwitch() {
    Provider.of<ConfigData>(context, listen: false).darkModeChange();
    if (rive_isDarkMode != null) {
      rive_isDarkMode!
          .change(Provider.of<ConfigData>(context, listen: false).isDarkMode);
    }
  }

  Color highlight1 = Colors.redAccent;
  Color highlight2 = Colors.blueAccent;
  Color highlight3 = Colors.orange;
  Color highlight4 = Colors.deepPurpleAccent;

  bool isDarkMode = false;
  Color cardColor = Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    isDarkMode = Provider.of<ConfigData>(context).isDarkMode;
    cardColor = Theme.of(context).colorScheme.surface;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '계산 유형 선택',
          style: TextStyle(),
        ),
        actions: [
          GestureDetector(
            child: SizedBox(
              width: 100.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RiveAnimation.asset(
                  'assets/rive/day_and_night.riv',
                  fit: BoxFit.contain,
                  onInit: _onRiveInit,
                ),
              ),
            ),
            onTap: _darkModeSwitch,
          ),
        ],
        // toolbarHeight: 50.0,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
          //   // childAspectRatio: 1 / 2, //item 의 가로 1, 세로 2 의 비율
          //   // mainAxisSpacing: 10, //수평 Padding
          //   // crossAxisSpacing: 10, //수직 Padding
          // ),
          // scrollDirection: Axis.horizontal,
          children: [
            Container(
              padding: EdgeInsets.all(30.0),
              child: Text(
                '중학교 기초 계산',
                style: TextStyle(fontSize: 30.0),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                '정수와 유리수의 계산',
                style: TextStyle(fontSize: 15.0, color: workShopGreyFontColor),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CalculationTypeButton(
                    backgroundColor: cardColor,
                    screen: MainAddScreen(),
                    topColor: Colors.red,
                    topChild: Text(
                      '(+3)+(-2)=?',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    bottomChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.plus,
                              size: 25.0,
                            ),
                            Text(
                              ' 덧셈',
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ],
                        ),
                        const FaIcon(
                          FontAwesomeIcons.chevronRight,
                          size: 25.0,
                        ),
                      ],
                    ),
                  ),
                  CalculationTypeButton(
                    backgroundColor: cardColor,
                    screen: MainSubScreen(),
                    topColor: Colors.blue,
                    topChild: Text(
                      '(-2)-(-3)=?',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    bottomChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.minus,
                              size: 25.0,
                            ),
                            Text(
                              ' 뺄셈',
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ],
                        ),
                        const FaIcon(
                          FontAwesomeIcons.chevronRight,
                          size: 25.0,
                        ),
                      ],
                    ),
                  ),
                  CalculationTypeButton(
                    backgroundColor: cardColor,
                    screen: MainAddSubScreen(),
                    topColor: Colors.amber,
                    topChild: Text(
                      '-5-7=?',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    bottomChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.plus,
                              size: 25.0,
                            ),
                            Text(
                              ' ',
                              style: TextStyle(fontSize: 25.0),
                            ),
                            FaIcon(
                              FontAwesomeIcons.minus,
                              size: 25.0,
                            ),
                            Text(
                              ' 덧셈과 뺄셈',
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ],
                        ),
                        const FaIcon(
                          FontAwesomeIcons.chevronRight,
                          size: 25.0,
                        ),
                      ],
                    ),
                  ),
                  CalculationTypeButton(
                    backgroundColor: cardColor,
                    screen: MainMulScreen(),
                    topColor: Colors.green,
                    topChild: Text(
                      '(+2)×(-3)=?',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    bottomChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.times,
                              size: 25.0,
                            ),
                            Text(
                              ' 곱셈',
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ],
                        ),
                        const FaIcon(
                          FontAwesomeIcons.chevronRight,
                          size: 25.0,
                        ),
                      ],
                    ),
                  ),
                  CalculationTypeButton(
                    backgroundColor: cardColor,
                    screen: MainDivScreen(),
                    topColor: Colors.deepPurpleAccent,
                    topChild: Text(
                      '(-6)÷(-3)=?',
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                    bottomChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.divide,
                              size: 25.0,
                            ),
                            Text(
                              ' 나눗셈',
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ],
                        ),
                        const FaIcon(
                          FontAwesomeIcons.chevronRight,
                          size: 25.0,
                        ),
                      ],
                    ),
                  ),
                  CalculationTypeButton(
                    backgroundColor: cardColor,
                    screen: MainMixScreen(),
                    topColor: Colors.pinkAccent,
                    topChild: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '(8-5)',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        Text(
                          '×',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        Text(
                          '(',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        FractionWidget(
                          -1,
                          2,
                          textStyle: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          ')',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        PowerWidget(
                          textStyle: TextStyle(
                            fontSize: 20,
                          ),
                          power: 2,
                        ),
                      ],
                    ),
                    bottomChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: const [
                              Icon(
                                Icons.calculate_rounded,
                                size: 25.0,
                              ),
                              Flexible(
                                child: Text(
                                  ' 혼합 계산',
                                  style: TextStyle(fontSize: 25.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const FaIcon(
                          FontAwesomeIcons.chevronRight,
                          size: 25.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
