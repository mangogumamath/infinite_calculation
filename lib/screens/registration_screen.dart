import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/model/user_data.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = '/registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String nickName = '';
  bool? _ischecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('사용자 등록'),
        actions: [
          TextButton(
            child: Text(
              '확인',
              style: TextStyle(
                  color: _ischecked! ? Color(0xffbb86fc) : Colors.grey,
                  fontSize: 20.0),
            ),
            onPressed: !_ischecked!
                ? null
                : () async {
                    if (password.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            '6자리 이상의 비밀번호를 설정해주세요.',
                            style: TextStyle(fontFamily: 'ONEMobilePOP'),
                          ),
                          action: SnackBarAction(label: '확인', onPressed: () {}),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                      if (newUser != null) {
                        print('new User exist');
                        if (newUser.user != null) {
                          final time = Timestamp.now();
                          final registrationTimestamp =
                              DateTime.fromMicrosecondsSinceEpoch(
                                  time.microsecondsSinceEpoch);
                          Provider.of<UserData>(context, listen: false)
                                  .userDataMap['registrationTimestamp'] =
                              registrationTimestamp;

                          final uid = newUser.user!.uid;
                          await FirebaseFirestore.instance
                              .collection('UserData')
                              .doc(uid)
                              .set({
                                'uid': uid,
                                'email': email,
                                'nickName': nickName,
                                'registrationTimestamp': registrationTimestamp,
                              }, SetOptions(merge: true))
                              .then((value) =>
                                  print("Score merged with existing data!"))
                              .catchError((error) =>
                                  print("Failed to merge data: $error"));
                          Provider.of<UserData>(context, listen: false)
                              .signInUserData(newUser.user!);
                        }
                      }
                      setState(() {
                        showSpinner = false;
                      });

                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                  },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                    style: kTextFieldTextStyle,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: '이메일',
                      icon: const FaIcon(
                        FontAwesomeIcons.solidEnvelope,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    )),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    style: kTextFieldTextStyle,
                    obscureText: true,
                    obscuringCharacter: '*',
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: '6자리 이상의 비밀번호',
                      icon: const FaIcon(
                        FontAwesomeIcons.key,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    )),
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                    style: kTextFieldTextStyle,
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      nickName = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: '닉네임',
                      icon: const FaIcon(
                        FontAwesomeIcons.solidSmile,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    )),
                const SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _ischecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _ischecked = value;
                            });
                          },
                        ),
                        InkWell(
                          child: const SizedBox(
                            height: 30.0,
                            child: Center(
                              child: Text(
                                '[필수] 개인정보 수집 및 이용 동의',
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _ischecked = !_ischecked!;
                            });
                          },
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('개인정보 수집 및 이용 동의'),
                                titleTextStyle: const TextStyle(
                                    fontSize: 20.0, fontFamily: 'ONEMobilePOP'),
                                contentTextStyle: const TextStyle(
                                    fontSize: 15.0, fontFamily: 'ONEMobilePOP'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const [
                                      Text(
                                        '[필수] 개인정보 수집 및 이용 동의약관\n'
                                        '수집 항목:\n '
                                        '1. 이메일\n'
                                        '2. 서비스 이용 기록\n'
                                        '수집 목적:\n '
                                        '1. 이용자 식별 및 회원 관리\n'
                                        '2. 컨텐츠 서비스 제공\n'
                                        '보유 기간:\n'
                                        '계정삭제 후 지체없이 파기\n\n'
                                        '동의를 거부할 수 있으나 동의 거부시 서비스 이용이 제한됩니다.',
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('확인')),
                                ],
                              );
                            });
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.chevronRight,
                        size: 15.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
