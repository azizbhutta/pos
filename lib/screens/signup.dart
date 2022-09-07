import 'dart:ffi';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:posproject/utils/utils.dart';
import '../services/auth_services.dart';
import '../widgets/round_button.dart';
import 'login.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  // final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  // final roleController = TextEditingController();


  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign Up',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    // TextFormField(
                    //   controller: nameController,
                    //   cursorColor: Colors.teal,
                    //   style: const TextStyle(color: Colors.teal),
                    //   decoration: const InputDecoration(
                    //     focusedBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.teal),
                    //     ),
                    //     hintText: 'Name',
                    //     // helperText : 'Enter User Name',
                    //     prefixIcon: Icon(Icons.account_circle_outlined,color: Colors.teal,),
                    //   ),
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Enter UserName';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    TextFormField(
                      controller: emailController,
                      cursorColor: Colors.teal,
                      style: const TextStyle(color: Colors.teal),
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        hintText: 'Email',
                        // helperText : 'Enter Email',
                        prefixIcon: Icon(Icons.email_outlined,color: Colors.teal,),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      cursorColor: Colors.teal,
                      style: const TextStyle(color: Colors.teal),
                      obscureText: true,
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        hintText: 'Password',
                        // helperText : 'Enter password',
                        prefixIcon: Icon(Icons.lock_outline,color: Colors.teal,),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            const SizedBox(
              height: 50,
            ),
            RoundButton(
              title: 'Sign Up',
              loading: loading,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  _auth
                      .createUserWithEmailAndPassword(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString())
                          // user : nameController.text.toString())
                      .then((value) {
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                }
                // final String email = emailController.text.trim();
                // final String username = nameController.text.trim();
                // final String password = passwordController.text.trim();
                // final String role = roleController.text.trim();
                //
                //
                // if(username.isEmpty){
                //   print("Username is Empty");
                // } else {
                //   if(password.isEmpty){
                //     print("Password is Empty");
                //   } else {
                //     context.read<AuthService>().signUp(
                //       username,
                //       password,
                //       email,
                //       role,
                //     ).then((value) async {
                //       User? user = FirebaseAuth.instance.currentUser;
                //
                //       await FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
                //         'uid': user?.uid,
                //         'username': username,
                //         'password': password,
                //         'role': 'user',
                //       });
                //     });
                //   }
                // }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: const Text('LogIn'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
