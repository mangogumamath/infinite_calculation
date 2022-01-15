import 'package:firebase_core/firebase_core.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/model/config_data.dart';
import 'package:infinite_calculation/model/user_data.dart';
import 'package:infinite_calculation/screens/first_login_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  FlameAudio.bgm.initialize();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserData>(
        create: (_) => UserData(),
        lazy: false,
      ),
      ChangeNotifierProvider<ConfigData>(
        create: (_) => ConfigData(),
        lazy: false,
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    isDarkMode = Provider.of<ConfigData>(context).isDarkMode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '무한의 계산',
      theme: !isDarkMode
          //light 모드
          ? ThemeData(
              fontFamily: 'ONEMobilePOP',
              //대화창 테마
              dialogTheme: DialogTheme(
                titleTextStyle: TextStyle(
                  color: workShopBlack,
                  fontFamily: 'ONEMobilePOP',
                ),
                contentTextStyle: TextStyle(
                  color: workShopBlack,
                  fontFamily: 'ONEMobilePOP',
                ),
              ),
              //기본 글자색
              textTheme: TextTheme(
                // subtitle1: TextStyle(color: workShopBlack),
                // subtitle2: TextStyle(color: workShopBlack),
                bodyText2: TextStyle(color: workShopBlack),
              ),
              //배경색
              canvasColor: Color(0xffffffff),
              //앱바
              appBarTheme: AppBarTheme(
                //앱바 버튼색
                foregroundColor: workShopBlack,
                //앱바 폰트색
                titleTextStyle: TextStyle(
                  fontFamily: 'ONEMobilePOP',
                  fontSize: 20.0,
                  color: workShopBlack,
                ),
                //앱바 배경색
                backgroundColor: Color(0xffffffff),
                elevation: 1.0,
              ),
              colorScheme: ColorScheme.light(
                primary: workShopYellow,
                primaryVariant: workShopYellow,
                secondary: workShopBlue,
                secondaryVariant: workShopBlue,
                surface: workShopGreySurface,
                background: Color(0xffffffff),
                error: Color(0xffb00020),
                onPrimary: workShopBlack,
                onSecondary: workShopBlack,
                onSurface: workShopBlack,
                onBackground: workShopBlack,
                onError: Color(0xffffffff),
                brightness: Brightness.light,
              ),
            )
          //dark 모드
          : ThemeData(
              fontFamily: 'ONEMobilePOP',
              //대화창 테마
              dialogTheme: DialogTheme(
                titleTextStyle: TextStyle(
                  color: Color(0xffffffff),
                  fontFamily: 'ONEMobilePOP',
                ),
                contentTextStyle: TextStyle(
                  color: Color(0xffffffff),
                  fontFamily: 'ONEMobilePOP',
                ),
              ),
              //기본 글자색
              textTheme: TextTheme(
                bodyText2: TextStyle(color: Color(0xffffffff)),
              ),
              //배경색
              canvasColor: workShopBlack,
              //앱바
              appBarTheme: AppBarTheme(
                //앱바 버튼색
                foregroundColor: Color(0xffffffff),
                //앱바 폰트색
                titleTextStyle: TextStyle(
                    fontFamily: 'ONEMobilePOP',
                    fontSize: 20.0,
                    color: Color(0xffffffff)),
                //앱바 배경색
                backgroundColor: workShopBlack,
                elevation: 1.0,
              ),
              colorScheme: ColorScheme.dark(
                primary: workShopYellow,
                primaryVariant: workShopDarkYellow,
                secondary: workShopBlue,
                secondaryVariant: workShopBlue,
                surface: workShopBlackGrey,
                background: workShopBlack,
                error: Color(0xffb00020),
                onPrimary: workShopBlack,
                onSecondary: Color(0xffffffff),
                onSurface: Color(0xffffffff),
                onBackground: Color(0xffffffff),
                onError: Color(0xffffffff),
                brightness: Brightness.dark,
              ),
            ),
      home: const FirstLoginScreen(),
    );
  }
}

// colorScheme: const ColorScheme.dark(
// primary: Color(0xffbb86fc),
// primaryVariant: Color(0xff3700B3),
// secondary: Color(0xff03dac6),
// secondaryVariant: Color(0xff03dac6),
// surface: Color(0xff1E1E1E),
// background: Color(0xff121212),
// error: Color(0xffcf6679),
// onPrimary: Colors.black,
// onSecondary: Colors.black,
// onSurface: Colors.white,
// onBackground: Colors.white,
// onError: Colors.black,
// brightness: Brightness.dark,
// ),
