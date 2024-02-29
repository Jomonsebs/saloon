
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:estilo_salon/salon_app/homepage/saloon_screen.dart';
import 'package:estilo_salon/salon_app/homepage/settings_screen.dart';
import 'package:flutter/material.dart';

import 'appointment_screen.dart';
import 'categori_screen.dart';
import 'homepage_screen.dart';

class BottomNavi extends StatefulWidget {
  const BottomNavi({super.key});

  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {

  @override

  int currentIndex = 0;
   late PageController pageController;

  @override

  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override

  void dispose() {
    pageController.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {
    return Scaffold(

      body: SizedBox.expand(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: const [
            HomePageScreen(),
            AppointmentScreen(),
            CategoriScreen(),
            SaloonDemoVideoPlayer(),
            SettingsScreen(),
          ],
        ),
      ),


      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            pageController.jumpToPage(index);
          });

        },
        items: <BottomNavyBarItem> [
          BottomNavyBarItem(
              icon: Icon(Icons.home), title: Text("Home")),
          BottomNavyBarItem(
              icon: Icon(Icons.book), title: Text("Appointments")),
          BottomNavyBarItem(
              icon: Icon(Icons.category), title: Text("Category")),
          BottomNavyBarItem(
              icon: Icon(Icons.person), title: Text("Saloon")),
          BottomNavyBarItem(
              icon: Icon(Icons.settings), title: Text("Settings")),
        ],
      ),
    );
  }
}