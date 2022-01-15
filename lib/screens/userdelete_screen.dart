import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/model/user_data.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class UserDeleteScreen extends StatefulWidget {
  const UserDeleteScreen({Key? key}) : super(key: key);

  @override
  _UserDeleteScreenState createState() => _UserDeleteScreenState();
}

class _UserDeleteScreenState extends State<UserDeleteScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('계정 삭제'),
        actions: [
          TextButton(
            child: Text(
              '삭제',
              style: TextStyle(color: Colors.red, fontSize: 20.0),
            ),
            onPressed: () async {
              setState(() {
                showSpinner = true;
              });
              try {
                AuthCredential credential = EmailAuthProvider.credential(
                    email: email, password: password);
                final userCredential = await _auth.currentUser!
                    .reauthenticateWithCredential(credential);

                if (userCredential.user != null) {
                  try {
                    final _uid = Provider.of<UserData>(context, listen: false)
                        .userDataMap['uid'];

                    await _store.collection('UserData').doc(_uid).delete();
                  } on FirebaseAuthException catch (e) {
                    print(e);
                  }
                  try {
                    await _auth.currentUser!.delete();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          '계정이 삭제되었습니다.',
                          style: TextStyle(fontFamily: 'ONEMobilePOP'),
                        ),
                        action: SnackBarAction(label: '확인', onPressed: () {}),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'requires-recent-login') {
                      print(
                          'The user must reauthenticate before this operation can be executed.');
                    }
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
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: '비밀번호',
                      icon: const FaIcon(
                        FontAwesomeIcons.key,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    )),
                SizedBox(
                  height: 24.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
