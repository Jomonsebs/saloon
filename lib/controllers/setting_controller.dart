
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   bool isLoading = false;
//   User? currentUser;
//   String username = '';
//   String email = '';
//
//   Future<void> getUserData() async {
//     isLoading = true;
//     currentUser = _auth.currentUser;
//     if (currentUser != null) {
//       DocumentSnapshot<Map<String, dynamic>> user =
//       await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).get();
//       var userData = user.data();
//       username = userData?['fullname'] ?? '';
//       email = currentUser!.email ?? '';
//       isLoading = false;
//     }
//   }
// }