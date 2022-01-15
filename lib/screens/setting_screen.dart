import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/model/config_data.dart';
import 'package:infinite_calculation/model/profanity_text.dart';
import 'package:infinite_calculation/model/user_data.dart';
import 'package:infinite_calculation/screens/login_screen.dart';
import 'package:infinite_calculation/widget/agree_dialog.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  bool showSpinner = false;
  String email = '';
  String password = '';
  String nickName = '';
  bool _isLogin = false;
  bool _isAnonymousLogin = false;
  bool _isProfanity = false;
  bool _isTooShort = false;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    _isLogin = Provider.of<UserData>(context).isLogin;
    _isAnonymousLogin = Provider.of<UserData>(context).isAnonymousLogin;
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // ListTile(
            //   enabled: !_isLogin,
            //   title: Text(
            //     '로그인',
            //     style: TextStyle(fontSize: 25.0),
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => LoginScreen()),
            //     );
            //   },
            // ),
            // ListTile(
            //   title: Text(
            //     '사용자 등록',
            //     style: TextStyle(fontSize: 25.0),
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => RegistrationScreen()),
            //     );
            //   },
            // ),
            // ListTile(
            //   title: Text(
            //     '비밀번호 변경',
            //     style: TextStyle(fontSize: 25.0),
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => UserPasswordUpdateScreen()),
            //     );
            //   },
            // ),

            ListTile(
              enabled: _isLogin,
              title: Text(
                '닉네임 변경',
                style: TextStyle(fontSize: 25.0),
              ),
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => StatefulBuilder(
                    builder: (context, setState) {
                      final _isDarkMode =
                          Provider.of<ConfigData>(context, listen: false)
                              .isDarkMode;
                      return AlertDialog(
                        title: const Text(
                          '닉네임 변경',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        backgroundColor: !_isDarkMode
                            ? workShopGreySurface
                            : workShopBlackGrey,
                        titleTextStyle: TextStyle(
                          fontSize: 30.0,
                          fontFamily: 'ONEMobilePOP',
                          color:
                              !_isDarkMode ? workShopBlack : Color(0xffffffff),
                        ),
                        contentTextStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'ONEMobilePOP',
                          color:
                              !_isDarkMode ? workShopBlack : Color(0xffffffff),
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
                              '취소',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: !_isDarkMode
                                    ? workShopBlack
                                    : Color(0xffffffff),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _isProfanity = false;
                              _isTooShort = false;
                              final plusFilter =
                                  ProfanityFilter.filterAdditionally(
                                      customProfanityList);
                              bool hasProfanity =
                                  plusFilter.hasProfanity(nickName);
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
                              '변경',
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
                          .then((value) =>
                              print("Score merged with existing data!"))
                          .catchError(
                              (error) => print("Failed to merge data: $error"));

                      setState(() {
                        showSpinner = false;
                      });
                      Provider.of<UserData>(context, listen: false)
                          .justNotify();
                    } catch (e) {
                      print(e);
                    }
                  }
                });
              },
            ),
            ListTile(
              enabled: _isAnonymousLogin,
              title: Text(
                '게스트 계정 구글 연동',
                style: TextStyle(fontSize: 25.0),
              ),
              onTap: () async {
                bool _isAgree = false;
                var _popValue = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AgreeDialog()));
                if (_popValue == true) {
                  _isAgree = true;
                }
                if (_isAgree) {
                  try {
                    final GoogleSignInAccount? googleUser =
                        await GoogleSignIn().signIn();

                    // Obtain the auth details from the request
                    final GoogleSignInAuthentication? googleAuth =
                        await googleUser?.authentication;

                    // Create a new credential
                    final credential = GoogleAuthProvider.credential(
                      accessToken: googleAuth?.accessToken,
                      idToken: googleAuth?.idToken,
                    );

                    if (_auth.currentUser != null) {
                      final userCredential = await _auth.currentUser!
                          .linkWithCredential(credential);
                      if (userCredential.user != null) {
                        Provider.of<UserData>(context, listen: false)
                            .isAnonymousLogin = false;
                        await Provider.of<UserData>(context, listen: false)
                            .signInUserData(userCredential.user!);
                      }
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              },
            ),
            const Divider(
              height: 20.0,
              thickness: 2.0,
            ),
            ListTile(
              enabled: !_isLogin,
              title: Text(
                '로그인',
                style: TextStyle(fontSize: 25.0),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
// Provider.of<UserData>(context, listen: false)
//     .signOutUserData();
              },
            ),
            ListTile(
              enabled: _isLogin,
              title: Text(
                '로그아웃',
                style: TextStyle(fontSize: 25.0),
              ),
              onTap: () async {
                try {
                  await _auth.signOut();
                } catch (e) {
                  print(e);
                }

// Provider.of<UserData>(context, listen: false)
//     .signOutUserData();
              },
            ),

            ListTile(
              enabled: _isLogin && !_isAnonymousLogin,
              title: Text(
                '회원 탈퇴',
                style: TextStyle(fontSize: 25.0),
              ),
              onTap: () {
                // The function showDialog<T> returns Future<T>.
                // Use Navigator.pop() to return value (of type T).
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      '회원 탈퇴',
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                    content: const Text(
                      '계정 정보가 완전히 삭제됩니다.'
                      '\n계속하려면 탈퇴 버튼을 누르세요.',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          '취소',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          //uid Provider가 여기 있어야 읽어짐
                          final _uid =
                              Provider.of<UserData>(context, listen: false)
                                  .userDataMap['uid'];
                          try {
                            final userCredential = await signInWithGoogle();
                            if (userCredential.user != null) {
                              try {
                                await _store
                                    .collection('UserData')
                                    .doc(_uid)
                                    .delete();
                              } on FirebaseAuthException catch (e) {
                                print(e);
                              }
                              try {
                                await _auth.currentUser!.delete();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      '회원 탈퇴가 완료되었습니다.',
                                      style:
                                          TextStyle(fontFamily: 'ONEMobilePOP'),
                                    ),
                                    action: SnackBarAction(
                                        label: '확인', onPressed: () {}),
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
                        child: const Text(
                          '탈퇴',
                          style: TextStyle(fontSize: 20.0, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Column(
// children: [
// ListTile(
// title: Text(''),
// ),
// ElevatedButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => RegistrationScreen()),
// );
// },
// child: Text('사용자 등록'),
// ),
// ElevatedButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => LoginScreen()),
// );
// },
// child: Text('로그인'),
// ),
// ElevatedButton(
// onPressed: () {
// _auth.signOut();
// // Provider.of<UserData>(context, listen: false)
// //     .signOutUserData();
// },
// child: Text('로그아웃'),
// ),
// ],
// ),
