import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPagse extends StatefulWidget {
  const AdminPagse({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPagse> {
  TextEditingController salonNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController workingTimeController = TextEditingController();
  TextEditingController servicesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: salonNameController,
              decoration: InputDecoration(labelText: 'Salon Name'),
            ),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextFormField(
              controller: aboutController,
              decoration: InputDecoration(labelText: 'About'),
            ),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextFormField(
              controller: workingTimeController,
              decoration: InputDecoration(labelText: 'Working Time'),
            ),
            TextFormField(
              controller: servicesController,
              decoration: InputDecoration(labelText: 'Services'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addSalonDetails();
              },
              child: Text('Add Salon Details'),
            ),
          ],
        ),
      ),
    );
  }

  void _addSalonDetails() {
    FirebaseFirestore.instance.collection('salons').add({
      'salonName': salonNameController.text,
      'phoneNumber': phoneNumberController.text,
      'about': aboutController.text,
      'address': addressController.text,
      'workingTime': workingTimeController.text,
      'services': servicesController.text,
    }).then((value) {
      // Clear text fields after adding salon details
      salonNameController.clear();
      phoneNumberController.clear();
      aboutController.clear();
      addressController.clear();
      workingTimeController.clear();
      servicesController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Salon details added successfully')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add salon details: $error')),
      );
    });
  }
}
