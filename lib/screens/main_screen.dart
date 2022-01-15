import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_calculation/model/admob.dart';
import 'package:infinite_calculation/model/config_data.dart';
import 'package:infinite_calculation/model/profanity_text.dart';
import 'package:infinite_calculation/model/user_data.dart';
import 'package:infinite_calculation/screens/calculation_main_screen.dart';
import 'package:infinite_calculation/screens/leaderboard_screen.dart';
import 'package:infinite_calculation/screens/my_screen.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // String fontFamily = 'ONEMobilePOP';

  int _widgetIndex = 0;

  AdMob adMob = AdMob();

  String nickName = '';
  bool _isProfanity = false;
  bool _isTooShort = false;

  Future<void> nickNameNullCheck() async {
    if (Provider.of<UserData>(context, listen: false).userDataMap['nickName'] ==
        '') {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                '닉네임 설정',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              backgroundColor:
                  !_isDarkMode ? workShopGreySurface : workShopBlackGrey,
              titleTextStyle: TextStyle(
                fontSize: 30.0,
                fontFamily: 'ONEMobilePOP',
                color: !_isDarkMode ? workShopBlack : Color(0xffffffff),
              ),
              contentTextStyle: TextStyle(
                fontSize: 20.0,
                fontFamily: 'ONEMobilePOP',
                color: !_isDarkMode ? workShopBlack : Color(0xffffffff),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                      style: kTextFieldTextStyle,
                      keyboardType: TextInputType.name,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        nickName = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: '닉네임',
                        icon: FaIcon(
                          FontAwesomeIcons.solidSmile,
                          color: !_isDarkMode
                              ? workShopGreyFontColor
                              : Color(0xffffffff),
                          size: 25.0,
                        ),
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Visibility(
                    visible: _isProfanity,
                    child: const Text('다른 것으로 변경하세요'),
                  ),
                  Visibility(
                    visible: _isTooShort,
                    child: const Text('두 글자 이상으로 변경하세요'),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    _isProfanity = false;
                    _isTooShort = false;
                    Navigator.pop(context, 'Cancel');
                  },
                  child: Text(
                    '나중에',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: !_isDarkMode ? workShopBlack : Color(0xffffffff),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _isProfanity = false;
                    _isTooShort = false;
                    final plusFilter =
                        ProfanityFilter.filterAdditionally(customProfanityList);
                    bool hasProfanity = plusFilter.hasProfanity(nickName);
                    if (hasProfanity) {
                      _isProfanity = true;
                      setState(() {});
                    } else if (nickName.length <= 1) {
                      _isTooShort = true;
                      setState(() {});
                    } else {
                      Navigator.pop(context, 'Change');
                    }
                  },
                  child: const Text(
                    '설정',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ).then((returnVal) async {
        if (returnVal == 'Change') {
          try {
            Provider.of<UserData>(context, listen: false)
                .userDataMap['nickName'] = nickName;
            final uid = Provider.of<UserData>(context, listen: false)
                .userDataMap['uid'];
            FirebaseFirestore.instance
                .collection('UserData')
                .doc(uid)
                .set({
                  'nickName': nickName,
                }, SetOptions(merge: true))
                .then((value) => print("Score merged with existing data!"))
                .catchError((error) => print("Failed to merge data: $error"));

            Provider.of<UserData>(context, listen: false).justNotify();
          } catch (e) {
            print(e);
          }
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adMob.myBanner.load();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      nickNameNullCheck();
    });
  }

  bool _isDarkMode = false;
  Color indicatedTapColor = const Color(0xffffffff);
  Color unIndicatedTapColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    _isDarkMode = Provider.of<ConfigData>(context).isDarkMode;
    indicatedTapColor = !_isDarkMode ? workShopBlackGrey : Color(0xffffffff);
    unIndicatedTapColor =
        !_isDarkMode ? workShopGreyFontColor : workShopGreyFontColor;

    return SafeArea(
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            // appBar: AppBar(
            //   title: const Center(child: Text('무한의 계산')),
            // ),
// TabBarView
            body: IndexedStack(
              index: _widgetIndex,
              children: const [
                CalculationMainScreen(),
                LeaderBoardScreen(),
                MyScreen(),
                // TestPage(),
              ],
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
// mainAxisAlignment: MainAxisAlignment.end,
              children: [
                adMob.adContainer,
                TabBar(
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  onTap: (index) {
                    {
                      setState(() {
                        _widgetIndex = index;
                      });
                    }
                  },
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.calculate_rounded,
                        size: 30.0,
                        color: _widgetIndex == 0
                            ? indicatedTapColor
                            : unIndicatedTapColor,
                      ),
                      // text: '계산',
                    ),
                    Tab(
                      icon: FaIcon(
                        FontAwesomeIcons.crown,
                        size: 20.0,
                        color: _widgetIndex == 1
                            ? indicatedTapColor
                            : unIndicatedTapColor,
                      ),
                      // text: '순위',
                    ),
                    Tab(
                      icon: Icon(
                        Icons.person,
                        size: 30.0,
                        color: _widgetIndex == 2
                            ? indicatedTapColor
                            : unIndicatedTapColor,
                      ),
                      // text: '내 정보',
                    ),
//                     Tab(
//                       icon: Icon(
//                         Icons.person,
//                         size: 30.0,
//                         color: _widgetIndex == 3
//                             ? indicatedTapColor
//                             : unIndicatedTapColor,
//                       ),
// // text: 'my',
//                     ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
