
import 'package:d_locker/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogin(context) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text('Signning In',style: TextStyle(color: Colors.white),)
            ],
          ),
        );
      },
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = userCredential.user!;
    userCollection.doc(user.uid).set(
      {
        "username":user.displayName,
        "profilepic":user.photoURL,
        "email":user.email,
        "uid":user.uid,
        "userCreated":DateTime.now()
      }
    );

    notifyListeners();
    Navigator.of(context).pop();
  }

  Future logout(context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 8,),
                Text('Logging Out',style: TextStyle(color: Colors.white,fontSize: 14),)
              ],
            ),
          ),
        );
      },
    );
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    notifyListeners();
    Navigator.of(context).pop();
  }

  Future<void> deleteAccount(context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
    await FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
    Navigator.of(context).pop();
  }
}