import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estilo_salon/controllers/auth_controller.dart';
import 'package:estilo_salon/salon_app/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/fonts.dart';
import '../../utils/image_strings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await _firestore.collection('users').doc(_user!.uid).get();
    setState(() {
      _userData = userSnapshot.data();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(
          title: 'Settings',
        ),
      ),
      body: _userData == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Image.asset(TImages.clipper),
                  ),
                  title: AppStyles.bold(
                    title: _userData?['username'] ?? 'No Username',
                  ),
                  subtitle: AppStyles.normal(
                    title: _userData?['email'] ?? 'No Email',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: settingsList.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () async {
                      if (index == 2) {
                        await AuthController().signout();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ),
                        );
                      }
                    },
                    leading: Icon(
                      settingsListIcon[index],
                      color: Colors.black,
                    ),
                    title: AppStyles.bold(title: settingsList[index]),
                  ),
                ),
              ],
            ),
    );
  }
}
