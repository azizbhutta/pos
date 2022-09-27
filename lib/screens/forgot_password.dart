import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:posproject/utils/utils.dart';
import 'package:posproject/widgets/round_button.dart';

import 'login.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  void validate(){
    if (_formKey.currentState!.validate()){
      _auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
        Utils().toastMessage('We Have send You Email To Recover Password , Please Check Email');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const LoginScreen()));
      }).onError((error, stackTrace){
        Utils().toastMessage(error.toString());
      });

    }else{
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeeeeee),
      appBar: AppBar(
        title: const Text('Forgot Password',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.redAccent,),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: emailController,
                  validator: (value){
                    if(value!.isEmpty){
                      Fluttertoast.showToast(msg: "Please enter your email");
                    }else{
                      return;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email ',
                    hintStyle:  TextStyle(color: Colors.black),
                    // labelText: 'Email',
                    // labelStyle: const TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold, color: Colors.black),
                    fillColor : Colors.white,
                    filled : true,
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    prefixIcon:  Icon(Icons.email_outlined,color: Colors.blue,),
                  ),
                ),
              ),
            const SizedBox(height: 40,),
            RoundButton(title: 'Forgot', onTap: (){
              validate();
            }
            )
          ],
        ),
      ),
    );
  }
}
