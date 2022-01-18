import 'package:flutter/material.dart';

//계산 종류
enum CalculationType {
  sameAdd,
  diffAdd,
  subtraction,
  addSub,
  multiplicationTwo,
  multiplicationMany,
  division,
  mix
}
//메인 화면 버튼 스타일
ButtonStyle mainSelectButtonStyle = ButtonStyle(
    // maximumSize: MaterialStateProperty.all<Size>(Size(200.0, 70.0)),
    // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(10.0)),

    // fixedSize: MaterialStateProperty.all<Size>(Size(200.0, 80.0)),
    // foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
    // backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF03DAC5)),
    );

//튜토리얼, 모드 선택 등의 버튼 스타일
ButtonStyle modeSelectButtonStyle = ButtonStyle(
  // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(10.0)),
  // fixedSize: MaterialStateProperty.all<Size>(Size(200.0, 80.0)),
  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF03DAC5)),
);

//답 선택 버튼 스타일
ButtonStyle calculationButtonStyle = ButtonStyle(
  // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(10.0)),
  fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(80.0)),
  backgroundColor: MaterialStateProperty.all<Color>(workShopYellow),
  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
  // backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF03DAC5)),
);

//텍스트필드 textstyle
TextStyle kTextFieldTextStyle = const TextStyle(fontSize: 20.0);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your email',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  // enabledBorder: OutlineInputBorder(
  //   borderSide: BorderSide(color: Color(0xffbb86fc), width: 1.0),
  //   borderRadius: BorderRadius.all(Radius.circular(32.0)),
  // ),
  // focusedBorder: OutlineInputBorder(
  //   borderSide: BorderSide(color: Color(0xffbb86fc), width: 2.0),
  //   borderRadius: BorderRadius.all(Radius.circular(32.0)),
  // ),
);

const kScoreTileTextStyle = TextStyle(
  fontSize: 20.0,
);

// const kSendButtonTextStyle = TextStyle(
//   color: Colors.lightBlueAccent,
//   fontWeight: FontWeight.bold,
//   fontSize: 18.0,
// );
//
// const kMessageTextFieldDecoration = InputDecoration(
//   contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//   hintText: 'Type your message here...',
//   border: InputBorder.none,
// );
//
// const kMessageContainerDecoration = BoxDecoration(
//   border: Border(
//     top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
//   ),
// );

//색상들

//워크샵
Color workShopBlack = const Color(0xff141522);
Color workShopBlackGrey = const Color(0xff2B2C38);
Color workShopYellow = const Color(0xffFFBB54);
Color workShopDarkYellow = const Color(0xffc49041);
Color workShopBlue = const Color(0xff0235ff);
Color workShopGreyFontColor = const Color(0xff9C9CA4);
Color workShopGreySurface = const Color(0xffF8F8FA);

//모노톤
Color mono1 = const Color(0xff1E2022);
Color mono2 = const Color(0xff52616B);
Color mono3 = const Color(0xffC9D6DF);
Color mono4 = const Color(0xffF0F5F9);

//핑크파스텔
Color sunsetPink1 = const Color(0xffFFC7C7);
Color sunsetPink2 = const Color(0xffFFE2E2);
Color sunsetPink3 = const Color(0xffF6F6F6);
Color sunsetPink4 = const Color(0xff8785A2);

//파스텔 네온 테마
Color pastelblue = const Color(0xff5B5EFD);
Color pastelskyblue = const Color(0xff37D0FD);
Color pastelyellow = const Color(0xffFFE699);
Color pastelgreen = const Color(0xff90FFCA);
Color pastelred = const Color(0xffFF7878);

//네온 테마
Color vividpurple = const Color(0xfff901ff);
Color purple = const Color(0xff7400fa);
Color greypurple = const Color(0xffa985d7);
Color white = const Color(0xffffffff);
Color blue = const Color(0xff560bf5);

//ppt 컬러
Color pptbblue = const Color(0xff05088D);
Color pptblue = const Color(0xff0510C9);
Color pptskyblue = const Color(0xff08E8F0);
Color pptpurble = const Color(0xff4C0AB1);
Color pptorange = const Color(0xffF64E55);
Color pptred = const Color(0xffF23C6C);
Color pptyellow = const Color(0xffF5EB96);

//day
Color day1 = const Color(0xff8a00d4);
Color day2 = const Color(0xffd527b7);
Color day3 = const Color(0xfff782c2);
Color day4 = const Color(0xfff9c46b);
Color day5 = const Color(0xffe3e3e3);

//night
Color night1 = const Color(0xff1f306e);
Color night2 = const Color(0xff553772);
Color night3 = const Color(0xff8f3b76);
Color night4 = const Color(0xffc7417b);
Color night5 = const Color(0xfff5487f);
Color nightBack1 = const Color(0xff252E42);
Color nightBack2 = const Color(0xff2F3B52);

//leaf
Color leaf1 = const Color(0xff454d66);
Color leaf2 = const Color(0xff309975);
Color leaf3 = const Color(0xff58b368);
Color leaf4 = const Color(0xffdad873);
Color leaf5 = const Color(0xffefeeb4);
