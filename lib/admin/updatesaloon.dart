import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class updates extends StatelessWidget {
  const updates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('salons').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No salons found."));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot salon = snapshot.data!.docs[index];
              Map<String, dynamic> salonData = salon.data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  // Navigate to a page for updating or deleting the specific salon details
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdateDeletePage(salon: salon)),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text(salonData['salonName']),
                    subtitle: Text(salonData['about']),
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

class UpdateDeletePage extends StatelessWidget {
  final DocumentSnapshot salon;

  const UpdateDeletePage({required this.salon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update/Delete Salon Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to a page for updating salon details
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateSalonPage(salon: salon)),
                );
              },
              child: Text('Update Salon Details'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to a page for deleting salon details
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeleteSalonPage(salon: salon)),
                );
              },
              child: Text('Delete Salon'),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateSalonPage extends StatefulWidget {
  final DocumentSnapshot salon;

  const UpdateSalonPage({required this.salon});

  @override
  _UpdateSalonPageState createState() => _UpdateSalonPageState();
}

class _UpdateSalonPageState extends State<UpdateSalonPage> {
  TextEditingController salonNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController workingTimeController = TextEditingController();
  TextEditingController servicesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Populate text fields with existing salon details
    salonNameController.text = widget.salon['salonName'];
    phoneNumberController.text = widget.salon['phoneNumber'];
    aboutController.text = widget.salon['about'];
    addressController.text = widget.salon['address'];
    workingTimeController.text = widget.salon['workingTime'];
    servicesController.text = widget.salon['services'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Salon Details'),
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
                _updateSalonDetails(context);
              },
              child: Text('Update Salon Details'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateSalonDetails(BuildContext context) {
    FirebaseFirestore.instance.collection('salons').doc(widget.salon.id).update({
      'salonName': salonNameController.text,
      'phoneNumber': phoneNumberController.text,
      'about': aboutController.text,
      'address': addressController.text,
      'workingTime': workingTimeController.text,
      'services': servicesController.text,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Salon details updated successfully')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update salon details: $error')),
      );
    });
  }
}

class DeleteSalonPage extends StatelessWidget {
  final DocumentSnapshot salon;

  const DeleteSalonPage({required this.salon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Salon'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _deleteSalon(context);
          },
          child: Text('Delete Salon'),
        ),
      ),
    );
  }

  void _deleteSalon(BuildContext context) {
    FirebaseFirestore.instance.collection('salons').doc(salon.id).delete().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Salon deleted successfully')),
      );
      // Navigate back to the admin page after deletion
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete salon: $error')),
      );
    });
  }
}
