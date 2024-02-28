import 'package:estilo_salon/salon_app/signin_screen.dart';
import 'package:estilo_salon/salon_app/signup_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/homscren.jpg'),
            fit: BoxFit.cover,

            // colorFilter: ColorFilter.mode(
            //     Colors.black.withOpacity(0.7), BlendMode.darken),

          ),
        ),

        child: Column(
          children: [
            Padding(padding: EdgeInsets.fromLTRB(5, 120, 5, 20),
            ),
            // Image.asset('assets/img2.webp',height:100,
            // ),

            SizedBox(height: 30,),
            Button(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignUP()));
              },
              text: 'SIGN UP',
            ),

            SizedBox(height: 70,),
            Button(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignIn()));
              },
              text: 'SIGN IN',
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30,right: 20),
              child: Align(alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignIn()));
                    },
                    child: Text('Skip',
                      style: TextStyle(color: Colors.red,fontSize: 20),)),
              ),
            )
          ],),
      ),
    );
  }
}

class Button extends StatelessWidget {
  String text;
  final void Function() onPressed;
  Button({
    super.key,required this.text,required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,width: 150,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
              )
          ),
          child: Text(text,
            style: TextStyle(color: Color.fromARGB(255, 94, 92, 92),
                fontSize: 22),
          )
      ),
    );
  }
}


