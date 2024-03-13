import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';

import '../../main/main_screen.dart';
part 'onboarding_store.g.dart';

class OnboardingStore = _OnboardingStoreBase with _$OnboardingStore;

abstract class _OnboardingStoreBase with Store {
  @action
  Future<void> googleSignIn(BuildContext context) async {
    final googleSignIn = GoogleSignIn();
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;

        final userCredential = await FirebaseAuth.instance.signInWithCredential(
          GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ),
        );
        if (userCredential.user != null) {
          await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const MainScreen()),
            (route) => false,
          );
        } else {
          await Fluttertoast.showToast(msg: "Something Went Wrong");
        }
      } else {
        // isLoginLoading = false;
      }
    } on Exception catch (e) {
      // isLoginLoading = false;
      await Fluttertoast.showToast(msg: e.toString());
    }
  }
}
//dart run build_runner build --delete-conflicting-outputs