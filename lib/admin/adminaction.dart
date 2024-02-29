import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estilo_salon/admin/adminaction.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({Key? key}) : super(key: key);
  
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

              // Check if adminApproved field is null, if so, default to false
              bool adminApproved = appointmentData['adminApproved'] ?? false;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Day: ${appointmentData['day']}"),
                        SizedBox(height: 8),
                        Text("Time: ${appointmentData['time']}"),
                        SizedBox(height: 8),
                        Text("Mobile Number: ${appointmentData['mobileNumber']}"),
                        SizedBox(height: 8),
                        Text("Full Name: ${appointmentData['fullName']}"),
                        SizedBox(height: 8),
                        if (appointmentData['message'] != null)
                          Text("Message: ${appointmentData['message']}"),
                        SizedBox(height: 8),
                        Text("Admin Approved: ${adminApproved ? 'Yes' : 'No'}"),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Approve the appointment
                                FirebaseFirestore.instance.collection('appointments').doc(appointment.id).update({
                                  'adminApproved': true,
                                }).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("Appointment Approved"),
                                  ));
                                }).catchError((error) {
                                  print("Failed to approve appointment: $error");
                                });
                              },
                              child: Text("Approve"),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                // Reject the appointment
                                FirebaseFirestore.instance.collection('appointments').doc(appointment.id).update({
                                  'adminApproved': false,
                                }).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("Appointment Rejected"),
                                  ));
                                }).catchError((error) {
                                  print("Failed to reject appointment: $error");
                                });
                              },
                              child: Text("Reject"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
