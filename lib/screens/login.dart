import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:posproject/screens/signup.dart';
import 'package:posproject/utils/utils.dart';
import '../widgets/round_button.dart';
import 'addproducts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  // final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  RegExp regExpUsername = RegExp("fazeel");

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProductForm())
      );
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
        child: Scaffold(
           // backgroundColor: const Color(0xFFb5ba97),
          extendBodyBehindAppBar: true,
          // appBar: AppBar(
          //   elevation: 0,
          //   centerTitle: true,
          //   automaticallyImplyLeading: false,
          //   title: const Text('LogIn',
          //       style:
          //           TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                //       decoration: const BoxDecoration(
    //         gradient: LinearGradient(
    //           colors: [
    //             // Colors.orange,
    //             // Colors.blueGrey,
    //             Color(0xFFc0ffdf),
    //             Color(0xFF84ffea),
    //             Color(0xFF50ffd6),
    //           ],
    //           begin: Alignment.topRight,
    //           end: Alignment.bottomLeft,
    //         ),
    //       ),
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
                                    "Welcome Back!",
                                    style: TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.bold,letterSpacing: 2.0,fontFamily: 'Lemon',
                                        color: Colors.white)
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "You Have Been Missed!",
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
                            validator: (value){
                              if(value!.isEmpty){
                                Fluttertoast.showToast(msg: "please provide your email");
                              }else if(!regExpUsername.hasMatch(value)){
                                Fluttertoast.showToast(msg: "please enter valid email");
                              }return;
                            },
                            controller: emailController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration:  InputDecoration(
                              hintText: 'Email ',
                              hintStyle: const TextStyle(color: Colors.black),
                              // labelText: 'Email',
                              // labelStyle: const TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold, color: Colors.black),
                              fillColor : Colors.white,
                              filled : true,
                              // floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                // borderSide: const BorderSide(color: Colors.redAccent),

                              ),
                               // focusedBorder: OutlineInputBorder(
                               //   borderRadius: BorderRadius.circular(50.0),
                               //   borderSide: const BorderSide(color: Colors.black),
                               // ),

                              // helperText : 'Enter Email',
                              prefixIcon: const Icon(Icons.email_outlined,color: Colors.blue,),
                            ),
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
                              // labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                              // floatingLabelBehavior: FloatingLabelBehavior.always,
                              fillColor : Colors.white,
                              filled : true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  // borderSide: const BorderSide(color: Colors.white)
                              ),
                              // focusedBorder: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(50.0),
                              //   borderSide: const BorderSide(color: Colors.white),
                              // ),
                              // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide(color: Colors.white)),

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
                    // backgroundColor: const Color(0xFFb5ba97),
                    title: 'LogIn',
                    loading: loading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        login();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have account?",
                      style : TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white) ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SingUpScreen()));
                        },
                        child: const Text('SignUp'),
                      )
                    ],
                  )
                ],
              ),
            ),
           ),
        ),
      // ),
    );
  }
}
