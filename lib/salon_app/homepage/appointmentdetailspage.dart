import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentDetailsPage extends StatelessWidget {
  const AppointmentDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Details"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('appointments').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No appointments found."));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot appointment = snapshot.data!.docs[index];
              Map<String, dynamic> appointmentData = appointment.data() as Map<String, dynamic>;

              // Check if the appointment is approved or not
              bool isApproved = appointmentData['approved'] ?? false;

              return ListTile(
                title: Text("Day: ${appointmentData['day']}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Time: ${appointmentData['time']}"),
                    Text("Mobile Number: ${appointmentData['mobileNumber']}"),
                    Text("Full Name: ${appointmentData['fullName']}"),
                    if (appointmentData['message'] != null) Text("Message: ${appointmentData['message']}"),
                    Text("Booking Approved: ${isApproved ? 'Yes' : 'No'}"), // Display booking approval status
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
