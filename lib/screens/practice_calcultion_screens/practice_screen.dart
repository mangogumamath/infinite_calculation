import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/model/admob.dart';
import 'package:infinite_calculation/model/calculation_brain.dart';
import 'package:infinite_calculation/model/config_data.dart';
import 'package:infinite_calculation/model/level_brain.dart';
import 'package:infinite_calculation/model/user_data.dart';
import 'package:infinite_calculation/widget/choose_answer_button.dart';
import 'package:infinite_calculation/widget/fraction_reduced_widget.dart';
import 'package:infinite_calculation/widget/right_wrong_widget.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class PracticeScreen extends StatefulWidget {
  PracticeScreen({Key? key, required this.calculationType}) : super(key: key);
  CalculationType calculationType;
  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen>
    with TickerProviderStateMixin {
  CalculationBrain calculationBrain =
      CalculationBrain(calculationType: CalculationType.sameAdd);
  late LevelBrain levelBrain;
  late AdMob adMob;

  bool rightAnswerBool = true;

  late AnimationController animationController;
  late Animation animation;

  late AnimationController gaugeController;
  double timeGaugeValue = 0.0;

  bool isButtonDisabled = false;

  String levelText = '';

  Widget chooseButtonA = ChooseAnswerButton();
  Widget chooseButtonB = ChooseAnswerButton();
  Widget chooseButtonC = ChooseAnswerButton();
  Widget chooseButtonD = ChooseAnswerButton();

  int _maxScore = 0;
  String scoreKey = '';

  bool _isDarkMode = false;

  final _fireStore = FirebaseFirestore.instance;

  Future<void> _setMaxScore() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    _maxScore = calculationBrain.score;
    Provider.of<UserData>(context, listen: false).userDataMap[scoreKey] =
        calculationBrain.score;
    // prefs.setInt('maxScore', _maxScore);
    //?????? ??????
    Provider.of<UserData>(context, listen: false).checkUserHighScoreOfAll();

    final uid =
        Provider.of<UserData>(context, listen: false).userDataMap['uid'];

    await _fireStore
        .collection('UserData')
        .doc(uid)
        .set({
          scoreKey: calculationBrain.score,
          'userHighScoreOfAll': Provider.of<UserData>(context, listen: false)
              .userDataMap['userHighScoreOfAll'],
        }, SetOptions(merge: true))
        .then((value) => print("Score merged with existing data!"))
        .catchError((error) => print("Failed to merge data: $error"));
  }

  void _getMaxScore() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // _maxScore = (prefs.getInt('maxScore') ?? 0);

    _maxScore =
        Provider.of<UserData>(context, listen: false).userDataMap[scoreKey] ??
            0;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //??????????????? ????????????
    adMob = AdMob();
    adMob.myBanner.load();

    //?????? ????????? ?????? ????????? ??? ??????
    scoreKey = describeEnum(widget.calculationType) + 'HighScore';

    //???????????? ????????????
    _getMaxScore();

    //??????????????? ???????????? ??????
    calculationBrain =
        CalculationBrain(calculationType: widget.calculationType);
    //??????????????? ???????????? ??????
    levelBrain = LevelBrain(calculationType: widget.calculationType);
    //?????? ????????? ?????? ?????? ??????
    levelBrain.levelUpCheck(
        calculationBrain.score, calculationBrain.calculationType);
    //?????? ??????
    calculationBrain.resetNumber();

    //?????? ?????? ?????? ??????????????? ??????
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.elasticOut);

    //?????? ?????? ?????? ??????????????? ?????????
    animationController.addListener(() {
      setState(() {});
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });

    //?????? ????????? ?????? ??????????????? ??????
    gaugeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: levelBrain.quizTimeSecond),
    );
    gaugeController.forward();

    //?????? ????????? ??????????????? ?????????
    gaugeController.addListener(() {
      timeGaugeValue = 1 - gaugeController.value;
      setState(() {});
    });
    gaugeController.addStatusListener((status) {
      //?????? ????????? ??????
      if (status == AnimationStatus.completed) {
        if (_maxScore < calculationBrain.score) {
          _setMaxScore();
        }

        isButtonDisabled = true;

        _isDarkMode =
            Provider.of<ConfigData>(context, listen: false).isDarkMode;
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              //?????? ?????? ?????????
              // if (Random().nextInt(10) + 1 <= 3) {
              //   adMob.showInterstitialAd();
              // }
              return AlertDialog(
                title: const Text('??????'),
                backgroundColor:
                    !_isDarkMode ? workShopGreySurface : workShopBlackGrey,
                titleTextStyle: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'ONEMobilePOP',
                  color: !_isDarkMode ? workShopBlack : Color(0xffffffff),
                ),
                contentTextStyle: TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'ONEMobilePOP',
                  color: !_isDarkMode ? workShopBlack : Color(0xffffffff),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      adMob.adContainer,
                      const SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: Text(
                          calculationBrain.score.toString() + ' ???',
                        ),
                      ),
                      Center(
                        child: Text(
                          '????????????: ' + _maxScore.toString() + ' ???',
                          style: TextStyle(
                              fontSize: 30.0,
                              fontFamily: 'ONEMobilePOP',
                              color: workShopGreyFontColor),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        '??????',
                        style: TextStyle(
                          fontSize: 20.0,
                          color:
                              !_isDarkMode ? workShopBlack : Color(0xffffffff),
                        ),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => PracticeScreen(
                                  calculationType: widget.calculationType,
                                )));
                      },
                      child: const Text(
                        '?????? ??????',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      )),
                ],
              );
            });
      }
    });
  }

  //?????? ???????????? ??????????????? ??? ????????? ????????? ??????.
  void showMark_goGauge_levelUpCheck_function(bool rightAnswerBool) {
    //?????? ??????
    levelBrain.levelUpCheck(
        calculationBrain.score, calculationBrain.calculationType);

    //?????? ?????? ??????????????? ??????
    animationController.reset();
    animationController.forward();

    //????????? ?????? ?????? ????????? ?????? ?????? ??? ????????? ??????
    if (rightAnswerBool) {
      gaugeController.duration = Duration(seconds: levelBrain.quizTimeSecond);
      gaugeController.reset();
      gaugeController.forward();
    }
  }

  //?????? ???????????? ??????????????? ??? ????????? ????????? ??????.
  void chooseAnswerButton_function(dynamic submittedAnswer) {
    //?????? ??????
    setState(() {
      calculationBrain.checkAnswer(
          submittedAnswer,
          (timeGaugeValue * levelBrain.scoreMul).round(),
          (levelBrain.minusScore).round());
      rightAnswerBool = calculationBrain.checkBool;
      showMark_goGauge_levelUpCheck_function(rightAnswerBool);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //?????????????????? ??????
    animationController.dispose();
    gaugeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _isDarkMode = Provider.of<ConfigData>(context).isDarkMode;

    //??????????????? ???????????? ?????? ?????? ?????? ??????
    if (widget.calculationType == CalculationType.division ||
        widget.calculationType == CalculationType.mix) {
      chooseButtonA = ChooseAnswerButton(
        isDisabled: isButtonDisabled,
        buttonChild: FractionReducedWidget(
          calculationBrain.choiceA_value.numerator,
          calculationBrain.choiceA_value.denominator,
          dividerColor: Colors.black,
          dividerWidth: 30.0,
          textStyle: const TextStyle(fontSize: 30.0),
        ),
        onPressed: () {
          chooseAnswerButton_function(calculationBrain.choiceA_value);
        },
      );
      chooseButtonB = ChooseAnswerButton(
        isDisabled: isButtonDisabled,
        buttonChild: FractionReducedWidget(
          calculationBrain.choiceB_value.numerator,
          calculationBrain.choiceB_value.denominator,
          dividerColor: Colors.black,
          dividerWidth: 30.0,
          textStyle: const TextStyle(fontSize: 30.0),
        ),
        onPressed: () {
          chooseAnswerButton_function(calculationBrain.choiceB_value);
        },
      );
      chooseButtonC = ChooseAnswerButton(
        isDisabled: isButtonDisabled,
        buttonChild: FractionReducedWidget(
          calculationBrain.choiceC_value.numerator,
          calculationBrain.choiceC_value.denominator,
          dividerColor: Colors.black,
          dividerWidth: 30.0,
          textStyle: const TextStyle(fontSize: 30.0),
        ),
        onPressed: () {
          chooseAnswerButton_function(calculationBrain.choiceC_value);
        },
      );
      chooseButtonD = ChooseAnswerButton(
        isDisabled: isButtonDisabled,
        buttonChild: FractionReducedWidget(
          calculationBrain.choiceD_value.numerator,
          calculationBrain.choiceD_value.denominator,
          dividerColor: Colors.black,
          dividerWidth: 30.0,
          textStyle: const TextStyle(fontSize: 30.0),
        ),
        onPressed: () {
          chooseAnswerButton_function(calculationBrain.choiceD_value);
        },
      );
    } else {
      chooseButtonA = ChooseAnswerButton(
        isDisabled: isButtonDisabled,
        buttonText: calculationBrain.choiceA_text,
        onPressed: () {
          chooseAnswerButton_function(calculationBrain.choiceA_value);
        },
      );
      chooseButtonB = ChooseAnswerButton(
        isDisabled: isButtonDisabled,
        buttonText: calculationBrain.choiceB_text,
        onPressed: () {
          chooseAnswerButton_function(calculationBrain.choiceB_value);
        },
      );
      chooseButtonC = ChooseAnswerButton(
        isDisabled: isButtonDisabled,
        buttonText: calculationBrain.choiceC_text,
        onPressed: () {
          chooseAnswerButton_function(calculationBrain.choiceC_value);
        },
      );
      chooseButtonD = ChooseAnswerButton(
        isDisabled: isButtonDisabled,
        buttonText: calculationBrain.choiceD_text,
        onPressed: () {
          chooseAnswerButton_function(calculationBrain.choiceD_value);
        },
      );
    }

    //rive ??????
    // SMINumber? rive_inputValue;
    // double rive_score = 50.0;
    //
    // void _onRiveInit(Artboard artboard) {
    //   final controller =
    //       StateMachineController.fromArtboard(artboard, 'State Machine 1');
    //   artboard.addController(controller!);
    //
    //   rive_inputValue = controller.findInput<double>('input') as SMINumber;
    //   if (rive_inputValue != null) {
    //     rive_inputValue!.change(rive_score);
    //   }
    // }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '??????: ' + calculationBrain.score.toString(),
                    style: const TextStyle(
                      fontSize: 40.0,
                    ),
                  ),
                  Text(
                    levelBrain.levelText,
                    style: TextStyle(
                      color: levelBrain.levelTextColor,
                      fontSize: 40.0,
                    ),
                  ),
                ],
              ), // ????????? ??????
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: (timeGaugeValue * 10000).round() + 1,
                    child: Container(
                      height: 10.0,
                      color: timeGaugeValue > 0.3
                          ? levelBrain.levelTextColor
                          : Colors.redAccent,
                    ),
                  ),
                  Flexible(
                    flex: (10000 - timeGaugeValue * 10000).round(),
                    child: Container(
                      height: 10.0,
                      color: Colors.white70,
                    ),
                  )
                ],
              ), //?????? ?????????
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   width: 200.0,
                  //   height: 200.0,
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //     child: RiveAnimation.asset(
                  //       'assets/rive/tree_demo.riv',
                  //       fit: BoxFit.scaleDown,
                  //       onInit: _onRiveInit,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 100.0,
                    width: 100.0,
                    child: Center(
                      child: RightWrongWidget(
                          iconsize: animation.value * 80.0,
                          answerBool: rightAnswerBool),
                    ),
                  ),
                ],
              ), //???????????? ???????????? ???????????? ?????????
            ],
          ),
          calculationBrain.questionWidget, //?????? ??????
          Column(
            children: [
              Row(
                children: [
                  chooseButtonA,
                  chooseButtonB,
                ],
              ), //?????? A, B
              Row(
                children: [
                  chooseButtonC,
                  chooseButtonD,
                ],
              ), //?????? C, D
            ],
          ),
        ],
      ),
    );
  }
}
