import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // LOGIN
  Future<User?> login(String emailAddress, String password) async {
    try {
      UserCredential credential =
          await _auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided.';
      } else {
        throw e.message ?? 'Login failed';
      }
    }
  }

  // SIGN UP
  Future<User?> signUp(String emailAddress, String password) async {
    try {
      UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'Account already exists for this email.';
      } else {
        throw e.message ?? 'Signup failed';
      }
    }
  }

  // LOGOUT
  Future<void> logOut() async {
    await _auth.signOut();
  }

  // CURRENT USER
  User? get currentUser => _auth.currentUser;
}
