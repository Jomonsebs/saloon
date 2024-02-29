import 'package:estilo_salon/admin/adminaction.dart';
import 'package:estilo_salon/admin/adminhome.dart';
import 'package:estilo_salon/admin/updatesaloon.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home Page'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Number of columns
        padding: EdgeInsets.all(16.0),
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          _buildMenuItem(context, 'Add Saloons', Icons.people, AdminPagse()), // Pass the page object to navigate to
          _buildMenuItem(context, 'Manage Booking', Icons.shopping_cart,AppointmentScreen()),
          _buildMenuItem(context, 'Manage Saloons', Icons.shopping_basket, updates()),
        //  _buildMenuItem(context, 'Analytics', Icons.analytics,AdminPagse()),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        // Navigate to corresponding page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40.0, color: Theme.of(context).primaryColor),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
