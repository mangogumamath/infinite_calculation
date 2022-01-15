import 'package:flutter/material.dart';
import 'package:infinite_calculation/constants.dart';

class GoogleLoginButton extends StatelessWidget {
  GoogleLoginButton({Key? key, this.onTap}) : super(key: key);
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: workShopGreySurface,
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
                    image: AssetImage('assets/images/google_logo_icon.png'),
                  ),
                  Text(
                    '구글 로그인',
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
