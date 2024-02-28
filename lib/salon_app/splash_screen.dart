
import 'package:estilo_salon/salon_app/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin
{
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds:6 ),() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => WelcomeScreen()
          ));
    });

  }

  @override
  void dispose(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays:SystemUiOverlay.values);
    super.dispose();

  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue,Colors.purpleAccent],
            // begin: Alignment.topRight,
            // end: Alignment.bottomLeft
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Hair_salon.png'),
            //  Icon(Icons.shopping_cart, size: 80, color: Colors.white54,),

            SizedBox(height: 20,),
            Text('Estilo Salon',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 40
              ),)
          ],
        ),
      ),
      // bottomNavigationBar:
      // SizedBox(height: 30,
      //   child: Text('powered by pursuits',
      //     textAlign: TextAlign.center,
      //     style: TextStyle(color: Colors.black),
      //   ),
      // ),
    );
  }
}
