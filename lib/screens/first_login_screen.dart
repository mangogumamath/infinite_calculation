import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/model/user_data.dart';
import 'package:infinite_calculation/screens/main_screen.dart';
import 'package:infinite_calculation/widget/agree_dialog.dart';
import 'package:infinite_calculation/widget/anonymous_login_button.dart';
import 'package:infinite_calculation/widget/google_login_button.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:upgrader/upgrader.dart';

class FirstLoginScreen extends StatefulWidget {
  const FirstLoginScreen({Key? key}) : super(key: key);

  @override
  _FirstLoginScreenState createState() => _FirstLoginScreenState();
}

class _FirstLoginScreenState extends State<FirstLoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool isLogin = false;

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  SMITrigger? _success;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _success = controller.findInput<bool>('success') as SMITrigger;
  }

  void _hitSuccess() => _success?.fire();

  @override
  Widget build(BuildContext context) {
    isLogin = Provider.of<UserData>(context).isLogin;

    return Scaffold(
      body: UpgradeAlert(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          // splashFactory: NoSplash.splashFactory,
          onTap: () {
            if (isLogin) {
              _hitSuccess();
              Future.delayed(Duration(milliseconds: 1500), () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainScreen()));
              });
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Expanded(flex: 2, child: SizedBox()),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  height: 80.0,
                  width: 200.0,
                  child: Center(
                    child: const Text(
                      '무한의 계산',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
                SizedBox(
                  height: 250.0,
                  child: RiveAnimation.asset(
                    'assets/rive/teddy_login_screen.riv',
                    fit: BoxFit.scaleDown,
                    onInit: _onRiveInit,
                  ),
                ),
                SizedBox(
                  height: 150.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: !isLogin,
                        child: GoogleLoginButton(
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
                                final userCredential = await signInWithGoogle();

                                if (userCredential.additionalUserInfo != null) {
                                  await Provider.of<UserData>(context,
                                          listen: false)
                                      .isNewUserRegisterData(userCredential);
                                }
                                if (userCredential.user != null) {
                                  await Provider.of<UserData>(context,
                                          listen: false)
                                      .signInUserData(userCredential.user!);
                                  isLogin = true;
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                        ),
                      ),
                      Visibility(
                        visible: !isLogin,
                        child: AnonymousLoginButton(
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
                                final userCredential =
                                    await _auth.signInAnonymously();
                                if (userCredential.additionalUserInfo != null) {
                                  await Provider.of<UserData>(context,
                                          listen: false)
                                      .isNewUserRegisterData(userCredential);
                                }
                                if (userCredential.user != null) {
                                  await Provider.of<UserData>(context,
                                          listen: false)
                                      .signInUserData(userCredential.user!);
                                  isLogin = true;
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                        ),
                      ),
                      Visibility(
                        visible: isLogin,
                        child: const Text(
                          '화면을 터치하세요',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(flex: 2, child: SizedBox()),
                Text('ver.1.1.5',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: workShopGreyFontColor,
                    )),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
