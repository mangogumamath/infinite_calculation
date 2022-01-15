import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:infinite_calculation/model/user_data.dart';
import 'package:infinite_calculation/widget/agree_dialog.dart';
import 'package:infinite_calculation/widget/anonymous_login_button.dart';
import 'package:infinite_calculation/widget/google_login_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

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
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: Center(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GoogleLoginButton(
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
                          await Provider.of<UserData>(context, listen: false)
                              .isNewUserRegisterData(userCredential);
                        }
                        if (userCredential.user != null) {
                          await Provider.of<UserData>(context, listen: false)
                              .signInUserData(userCredential.user!);
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                ),
                AnonymousLoginButton(
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
                        final userCredential = await _auth.signInAnonymously();
                        print(userCredential);
                        if (userCredential.additionalUserInfo != null) {
                          await Provider.of<UserData>(context, listen: false)
                              .isNewUserRegisterData(userCredential);
                        }
                        if (userCredential.user != null) {
                          await Provider.of<UserData>(context, listen: false)
                              .signInUserData(userCredential.user!);
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
