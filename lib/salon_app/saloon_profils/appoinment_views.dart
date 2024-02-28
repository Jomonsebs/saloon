import 'package:estilo_salon/salon_app/saloon_profils/appointment_details_views.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentViews extends StatelessWidget {
  final String salonId;

  const AppointmentViews({Key? key, required this.salonId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController dayController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    TextEditingController mobileController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController messageController = TextEditingController();

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    Future<String?> getSalonName() async {
      try {
        DocumentSnapshot salonSnapshot =
            await FirebaseFirestore.instance.collection('salons').doc(salonId).get();
        Map<String, dynamic> salonData = salonSnapshot.data() as Map<String, dynamic>;
        return salonData['salonName'];
      } catch (e) {
        print('Failed to get salon name: $e');
        return null;
      }
    }

    void makeAppointment() async {
      String day = dayController.text;
      String time = timeController.text;
      String mobileNumber = mobileController.text;
      String fullName = nameController.text;
      String message = messageController.text;

      try {
        await FirebaseFirestore.instance.collection('appointments').add({
          'salonId': salonId,
          'day': day,
          'time': time,
          'mobileNumber': mobileNumber,
          'fullName': fullName,
          'message': message,
        });
        print("Appointment booked successfully");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SalonDetailsScreen(salonId: salonId)),
        );
      } catch (e) {
        print('Failed to book appointment: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book an Appointment",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: getSalonName(),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text("Salon not found."));
            }
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Salon Name: ${snapshot.data}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: dayController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a day';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Appointment Day",
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: timeController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a time';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Appointment Time",
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: mobileController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a mobile number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Mobile Number",
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Full Name",
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: messageController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a message';
                      }
                      return null;
                    },
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Message (Optional)",
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              makeAppointment();
            }
          },
          child: Text("Book Appointment"),
        ),
      ),
    );
  }
}
