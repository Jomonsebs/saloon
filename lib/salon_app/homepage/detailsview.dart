import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentViewss extends StatelessWidget {
  final String salonId;

  const AppointmentViewss({Key? key, required this.salonId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book an Appointment",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('appointments').doc(salonId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
            return Center(child: Text("No appointment found."));
          }
          var appointmentData = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Salon Name: ${appointmentData['salonName']}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text("Day: ${appointmentData['day']}"),
                SizedBox(height: 8),
                Text("Time: ${appointmentData['time']}"),
                SizedBox(height: 8),
                Text("Mobile Number: ${appointmentData['mobileNumber']}"),
                SizedBox(height: 8),
                Text("Full Name: ${appointmentData['fullName']}"),
                SizedBox(height: 8),
                Text("Message: ${appointmentData['message']}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
