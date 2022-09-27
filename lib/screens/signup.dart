import 'dart:ffi';
import 'package:fluttertoast/fluttertoast.dart';
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

  // RegExp regExpUsername = RegExp("fazeel");

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  void validate(){
    if (_formKey.currentState!.validate()){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const LoginScreen()));
    }else{
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   elevation: 0,
      //   centerTitle: true,
      //     automaticallyImplyLeading: false,
      //   title: const Text('Sign Up',
      //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      //   backgroundColor: Colors.transparent,
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/1.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                                "Hello!",
                                style: TextStyle(fontSize: 30,
                                    fontWeight: FontWeight.w900,letterSpacing: 2.0,fontFamily: 'Lemon',
                                    color: Colors.white)
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Here To Get Welcomed!",
                              style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w400,fontFamily: 'Pacifico',
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      TextFormField(
                        controller: emailController,
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration:  InputDecoration(
                          hintText: 'Email Address',
                          hintStyle: const TextStyle(color: Colors.black),
                          // labelText: 'Email',
                          // labelStyle: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: Colors.white),
                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                          fillColor : Colors.white,
                          filled : true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(color: Colors.red)
                          ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(50.0),
                          //   borderSide: const BorderSide(color: Colors.white),
                          // ),

                          // helperText : 'Enter Email',
                          prefixIcon: Icon(Icons.email_outlined,color: Colors.blue,),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            Fluttertoast.showToast(msg: "please provide your email");
                          }
                          // else if(!regExpUsername.hasMatch(value)){
                          //   Fluttertoast.showToast(msg: "please enter valid email");
                          // }
                            return;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        obscureText: true,
                        decoration:  InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.black),
                          // labelText: 'Password',
                          // labelStyle: const TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold, color: Colors.white),
                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                          fillColor : Colors.white,
                          filled : true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(color: Colors.white)
                          ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(50.0),
                          //   borderSide: const BorderSide(color: Colors.white),
                          // ),

                          // helperText : 'Enter Email',
                          prefixIcon: Icon(Icons.lock_outline,color: Colors.blue,),
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
                    validate();
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
                  const Text("Already have account?",
              style : TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
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
      ),
    );
  }
}
