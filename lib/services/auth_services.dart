// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
//
// class AuthServiceProvider with ChangeNotifier{
//
//
//   Stream<User?> get authStateChanges => _auth.idTokenChanges();
//
//   Future<Object> login(String email, String password) async {
//     try{
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return "Logged In";
//     } catch(e) {
//       return e;
//     }
//   }
//
//   Future<Object> signUp(String? email, String? password, String? role, String? username) async {
//     try{
//       await _auth.createUserWithEmailAndPassword(email: email!, password: password!).then((value) async {
//         User? user = FirebaseAuth.instance.currentUser;
//
//         await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
//           'uid': user.uid,
//           'email': email,
//           'username': username,
//           'password': password,
//           'role': role
//         });
//       });
//       return "Signed Up";
//     } catch(e) {
//       print(e);
//       return e;
//     }
//   }
// }