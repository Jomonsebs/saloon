

 import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:firebase_auth/firebase_auth.dart';
 import 'package:flutter/cupertino.dart';

 class AuthController {


//   var userNameController = TextEditingController();
//   var emailController = TextEditingController();
//   var passwordController = TextEditingController();
//   UserCredential? userCredential;
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   signupUser() async {
//
//
//     userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: emailController.text, password: passwordController.text);
//     await storeUserData(userCredential!.user!.uid,userNameController.text,emailController.text);
//
//   }
//
//   storeUserData(String uid,String userName,String email) async {
//     var store = FirebaseFirestore.instance.collection('users').doc(uid);
//     await store.set({'userName':userName,'email':email});
//   }
//
//
  signout() async {
    await FirebaseAuth.instance.signOut();
  }
}







  //sign in with email and password
//   Future<UserCredential> signInWithEmailAndPassword(String email, String password) async
//   {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential;
//     } catch (e) {
//       print("Error signing in: $e");
//       throw e;
//     }
//   }
//
//   //Register with email and password
//   Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential;
//     } catch (e) {
//       print("Error registering user: $e");
//       throw e;
//     }
//   }
//
//   //sign out
//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       print("Error signing out: $e");
//       throw e;
//     }
//   }
// }




