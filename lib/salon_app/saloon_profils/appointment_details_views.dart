import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SalonDetailsScreen extends StatelessWidget {
  final String salonId;

  const SalonDetailsScreen({Key? key, required this.salonId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salon Details"),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('salons').doc(salonId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(child: Text("Salon not found."));
          }
          var salonData = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Text("Salon Name: ${salonData['salonName'] ?? ''}"),
                    ),
                    Divider(), // Add a divider between different pieces of information
                    ListTile(
                      title: Text("Phone Number: ${salonData['phoneNumber'] ?? ''}"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Address: ${salonData['address'] ?? ''}"),
                    ),
                    // Add more details here as needed
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
