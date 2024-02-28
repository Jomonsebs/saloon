import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailAddressController = TextEditingController();

  @override
  void dispose() {
    emailAddressController.dispose();
  super.dispose();
  }
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
          email: emailAddressController.text.trim());
      showDialog(
          context: context, builder: (context){
        return AlertDialog(
          content: Text('Password reset link sent!'),
        );
      }
      );
    } on FirebaseAuthException catch (e) {
      print("Error $e");
      showDialog(
          context: context, builder: (context){
            return AlertDialog(
              content: Text(e.message.toString()),
            );
      }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Forgot Password"),
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text('Enter your Email and we will send you a password reset link',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),
          ),

          // SizedBox(height: 40,),
          // TextFormField(
          //   controller: emailAddressController,
          //   style: TextStyle(color: Colors.black,fontFamily: 'SFUIDisplay'),
          //   decoration: InputDecoration(
          //       border: InputBorder.none,
          //       labelText: 'EMAIL',
          //       prefixIcon: Icon(Icons.email_rounded),
          //       labelStyle: TextStyle(fontSize: 12)
          //   ),
          // ),

          SizedBox(height: 10,),

          Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: emailAddressController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email_rounded),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: 'Email',
              fillColor:Colors.grey[200],
              filled: true,
            ),
          ),
          ),

          SizedBox(height: 20,),
          MaterialButton(
              onPressed: passwordReset,
          child: Text('Reset Password'),
          color: Colors.deepPurple[200],)
        ],
      ),
    );
  }
}
