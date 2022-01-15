import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/model/config_data.dart';
import 'package:infinite_calculation/model/user_data.dart';
import 'package:infinite_calculation/widget/reusable_card.dart';
import 'package:provider/provider.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  String nickName = '';
  Map<String, dynamic> _userDataMap = {};
  int userRanking = 0;
  int userHighScoreOfAll = 0;
  Map rankerMap = {};

  bool isLoadRankerButtonDisabled = false;

  // final _auth = FirebaseAuth.instance;

  // void _loadScore() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _maxScore = (prefs.getInt('maxScore') ?? 0);
  //   });
  // }

  // AdMob adMob = AdMob();

  final scrollController = ScrollController();

  Future<void> loadRanker() async {
    try {
      rankerMap = {};
      await FirebaseFirestore.instance
          .collection('UserData')
          .orderBy('userHighScoreOfAll', descending: true)
          .limit(100)
          .get()
          .then((QuerySnapshot querySnapshot) {
        int _counter = 0;
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          _counter++;
          final queryUserMap =
              queryDocumentSnapshot.data() as Map<String, dynamic>;
          rankerMap['$_counter'] = queryUserMap;
        }
      });
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  FaIcon topRankerIcon(int rank) {
    if (rank == 1) {
      return const FaIcon(
        FontAwesomeIcons.crown,
        size: 25.0,
        color: Color(0xFFFFE100),
      );
    } else if (rank == 2) {
      return const FaIcon(
        FontAwesomeIcons.crown,
        size: 25.0,
        color: Color(0xFFC1C1C1),
      );
    } else if (rank == 3) {
      return const FaIcon(
        FontAwesomeIcons.crown,
        size: 25.0,
        color: Color(0xFF974242),
      );
    } else {
      return const FaIcon(
        FontAwesomeIcons.chessPawn,
        size: 0.0,
        color: Colors.white,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // adMob.myBanner.load();
    loadRanker();
  }

  bool isDarkMode = false;
  Color cardColor = Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    _userDataMap = Provider.of<UserData>(context).userDataMap;
    nickName = _userDataMap['nickName'];
    userRanking = Provider.of<UserData>(context).userRanking;
    userHighScoreOfAll = _userDataMap['userHighScoreOfAll'];

    isDarkMode = Provider.of<ConfigData>(context).isDarkMode;
    cardColor = Theme.of(context).colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '순위',
          style: TextStyle(),
        ),
        // toolbarHeight: 50.0,
        actions: [
          IconButton(
            onPressed: isLoadRankerButtonDisabled
                ? null
                : () async {
                    isLoadRankerButtonDisabled = true;
                    setState(() {});
                    loadRanker();
                    Future.delayed(const Duration(seconds: 5), () {
                      isLoadRankerButtonDisabled = false;
                      setState(() {});
                    });
                  },
            icon: const FaIcon(
              FontAwesomeIcons.syncAlt,
              size: 25.0,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            // adMob.adContainer,

            ReusableCard(
              colour: Theme.of(context).colorScheme.primary,
              cardChild: Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.solidUserCircle,
                    size: 30.0,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            ' ' + nickName,
                            style: const TextStyle(fontSize: 25.0),
                            // overflow: TextOverflow.clip,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            ' ' +
                                userRanking.toString() +
                                ' 위' +
                                '   ' +
                                userHighScoreOfAll.toString() +
                                ' 점',
                            style: const TextStyle(fontSize: 20.0),
                            // overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Text(
                '1위~100위',
                style: TextStyle(fontSize: 25.0),
              ),
            ]),

            Expanded(
              child: Scrollbar(
                controller: scrollController,
                isAlwaysShown: true,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 100,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> empty = {
                      'nickName': '',
                      'userHighScoreOfAll': ''
                    };
                    Map<String, dynamic> ranker =
                        rankerMap['${index + 1}'] ?? empty;
                    return Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: cardColor,
                      ),
                      height: 80.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${index + 1} 위 ',
                                style: const TextStyle(fontSize: 30.0),
                              ),
                              topRankerIcon(index + 1),
                            ],
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(
                                    ranker.containsKey('nickName')
                                        ? ranker['nickName']
                                        : 'unknown',
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        color: workShopGreyFontColor),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    ranker.containsKey('userHighScoreOfAll')
                                        ? ranker['userHighScoreOfAll']
                                                .toString() +
                                            ' 점'
                                        : 'unknown',
                                    style: const TextStyle(fontSize: 25.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            //최고점수 삭제 버튼
            // ElevatedButton(
            //     onPressed: _removeScore, child: FaIcon(FontAwesomeIcons.eraser)),
            // Text('로그인'),
            // Text(
            //   '본 앱은 정수와 유리수의 계산을 연습하기 위해 만들어졌습니다.',
            //   style: TextStyle(fontSize: 40.0),
            // ),
            // Text(
            //   '기능 준비중',
            //   style: TextStyle(fontSize: 40.0),
            // ),
          ],
        ),
      ),
    );
  }
}
