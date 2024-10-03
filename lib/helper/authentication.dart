// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class AuthenticationHelper {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   get user => _auth.currentUser;
//
//   // SIGN UP METHOD
//
//   Future<User?> signUp(String email, String password) async {
//     try {
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: email.trim(),
//         password: password,
//       );
//       return userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       // handle error
//     }
//     return null;
//   }
//
// // SIGN IN METHOD
//
//   Future<User?> signIn(
//       {required String email, required String password}) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       throw e;
//     }
//   }
//
//   // SIGN OUT METHOD
//   Future signOut() async {
//     await _auth.signOut();
//     if (kDebugMode) {
//       print("Sign Out");
//     }
//   }
//
//   // GOOGLE SIGN IN METHOD
//   Future<UserCredential> signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     final GoogleSignInAuthentication? googleAuth =
//         await googleUser?.authentication;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
// }
