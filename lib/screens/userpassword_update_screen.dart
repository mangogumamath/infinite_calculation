import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UserPasswordUpdateScreen extends StatefulWidget {
  const UserPasswordUpdateScreen({Key? key}) : super(key: key);

  @override
  _UserPasswordUpdateScreenState createState() =>
      _UserPasswordUpdateScreenState();
}

class _UserPasswordUpdateScreenState extends State<UserPasswordUpdateScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  String email = '';
  String oldPassword = '';
  String newPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('비밀번호 변경'),
        actions: [
          TextButton(
            child: Text(
              '변경',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () async {
              if (newPassword.length < 6) {
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
                AuthCredential credential = EmailAuthProvider.credential(
                    email: email, password: oldPassword);
                final userCredential = await _auth.currentUser!
                    .reauthenticateWithCredential(credential);

                if (userCredential.user != null) {
                  try {
                    await _auth.currentUser!.updatePassword(newPassword);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          '비밀번호가 변경되었습니다.',
                          style: TextStyle(fontFamily: 'ONEMobilePOP'),
                        ),
                        action: SnackBarAction(label: '확인', onPressed: () {}),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    print(e);
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
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                      oldPassword = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: '현재 비밀번호',
                      icon: const FaIcon(
                        FontAwesomeIcons.key,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    )),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                    style: kTextFieldTextStyle,
                    obscureText: true,
                    obscuringCharacter: '*',
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      newPassword = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: '새로운 비밀번호',
                      icon: const FaIcon(
                        FontAwesomeIcons.key,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
