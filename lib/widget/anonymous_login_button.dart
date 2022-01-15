import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infinite_calculation/constants.dart';

class AnonymousLoginButton extends StatelessWidget {
  AnonymousLoginButton({Key? key, this.onTap}) : super(key: key);
  final Function()? onTap;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: workShopGreyFontColor,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: SizedBox(
            height: 50.0,
            width: 250.0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Image(
                    height: 40.0,
                    width: 40.0,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/anonymous_user.png'),
                  ),
                  Text(
                    '게스트 로그인',
                    style: TextStyle(fontSize: 20.0, color: Colors.black45),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
