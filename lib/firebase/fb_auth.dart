
import 'package:firebase_auth/firebase_auth.dart';

class FbAuth {
  var auth = FirebaseAuth.instance;

  Future<void> createAccount(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<bool> chickLogin(String email, String password) async {
    var user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    if (user != null) {
      return true;
    } else {
      return false;
    }

  }
}
