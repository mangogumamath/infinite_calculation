import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  UserData() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        signOutUserData();
      } else {
        print('User is signed in!');
        signInUserData(user);
      }
    });
  }
  int userRanking = 0;
  List topRankerList = [];
  bool isLogin = false;
  bool isAnonymousLogin = false;

  //사용자 데이터
  Map<String, dynamic> userDataMap = {
    'uid': '',
    'email': '',
    'nickName': '',
    'registrationTimestamp': Timestamp(0, 0),
    'userHighScoreOfAll': 0,
    'sameAddHighScore': 0,
    'diffAddHighScore': 0,
    'subtractionHighScore': 0,
    'addSubHighScore': 0,
    'multiplicationTwoHighScore': 0,
    'multiplicationManyHighScore': 0,
    'divisionHighScore': 0,
    'mixHighScore': 0
  };
  //Clear용 데이터. Clear(초기화)는 변수보다 구체적인 값으로 하는 것이 에러가 안난다.
  // Map<String, dynamic> userDataMapForClear = {
  //   'uid': '',
  //   'email': '',
  //   'nickName': '',
  //   'userHighScoreOfAll': 0,
  //   'sameAddHighScore': 0,
  //   'diffAddHighScore': 0,
  //   'subtractionHighScore': 0,
  //   'addSubHighScore': 0,
  //   'multiplicationTwoHighScore': 0,
  //   'multiplicationManyHighScore': 0,
  //   'divisionHighScore': 0,
  //   'mixHighScore': 0
  // };
  Future<void> isNewUserRegisterData(UserCredential newUserCredential) async {
    if (newUserCredential.additionalUserInfo!.isNewUser) {
      try {
        print('new User exist');

        final time = Timestamp.now();
        final registrationTimestamp =
            DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
        userDataMap['registrationTimestamp'] = registrationTimestamp;

        final uid = newUserCredential.user!.uid;
        await FirebaseFirestore.instance
            .collection('UserData')
            .doc(uid)
            .set({
              'uid': uid,
              'registrationTimestamp': registrationTimestamp,
            }, SetOptions(merge: true))
            .then((value) => print("Score merged with existing data!"))
            .catchError((error) => print("Failed to merge data: $error"));
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> signInUserData(User user) async {
    userDataMap = {
      'uid': '',
      'email': '',
      'nickName': '',
      'registrationTimestamp': Timestamp(0, 0),
      'userHighScoreOfAll': 0,
      'sameAddHighScore': 0,
      'diffAddHighScore': 0,
      'subtractionHighScore': 0,
      'addSubHighScore': 0,
      'multiplicationTwoHighScore': 0,
      'multiplicationManyHighScore': 0,
      'divisionHighScore': 0,
      'mixHighScore': 0,
    };
    userRanking = 0;
    isLogin = true;

    if (user.isAnonymous) {
      isAnonymousLogin = true;
    }

    //uid 받기
    final uid = user.uid;
    //UserData를 Firestore에서 받아와서 userDataMap을 update하기
    await FirebaseFirestore.instance
        .collection('UserData')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        final snapShotDataMap = documentSnapshot.data() as Map<String, dynamic>;
        snapShotDataMap.forEach((key, value) {
          //만약 update할 key가 없으면 만들도록 함.
          userDataMap.update(key, (_) => value, ifAbsent: () => value);
        });
      } else {
        print('Document does not exist on the database');
      }
    });
    // print(userDataMapForClear);

    getScoreRank();

    notifyListeners();
  }

  void signOutUserData() {
    //Clear는 구체적인 값으로 하는게 에러가 안난다.
    userDataMap = {
      'uid': '',
      'email': '',
      'nickName': '',
      'registrationTimestamp': Timestamp(0, 0),
      'userHighScoreOfAll': 0,
      'sameAddHighScore': 0,
      'diffAddHighScore': 0,
      'subtractionHighScore': 0,
      'addSubHighScore': 0,
      'multiplicationTwoHighScore': 0,
      'multiplicationManyHighScore': 0,
      'divisionHighScore': 0,
      'mixHighScore': 0,
    };
    userRanking = 0;
    isLogin = false;
    isAnonymousLogin = false;

    notifyListeners();
  }

  void justNotify() {
    notifyListeners();
  }

  void checkUserHighScoreOfAll() {
    userDataMap['userHighScoreOfAll'] = userDataMap['sameAddHighScore'] +
        userDataMap['diffAddHighScore'] +
        userDataMap['subtractionHighScore'] +
        userDataMap['addSubHighScore'] +
        userDataMap['multiplicationTwoHighScore'] +
        userDataMap['multiplicationManyHighScore'] +
        userDataMap['divisionHighScore'] +
        userDataMap['mixHighScore'];

    notifyListeners();
  }

  Future<void> getScoreRank() async {
    await FirebaseFirestore.instance
        .collection('UserData')
        .where('userHighScoreOfAll',
            isGreaterThan: userDataMap['userHighScoreOfAll'])
        .orderBy('userHighScoreOfAll', descending: true)
        // .limit(100)
        .get()
        .then((QuerySnapshot querySnapshot) {
      userRanking = querySnapshot.docs.length + 1;
    });

    notifyListeners();
  }
}
