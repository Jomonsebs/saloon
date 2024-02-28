import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estilo_salon/salon_app/homepage/detailsview.dart';
import 'package:estilo_salon/salon_app/saloon_profils/appoinment_views.dart';
import 'package:flutter/material.dart';

import '../../utils/fonts.dart';
import '../../utils/image_strings.dart';
import '../saloon_profils/appointment_details_views.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  // Future<QuerySnapshot<Map<String,dynamic>>>getAppointmnets() {
  //   return FirebaseFirestore.instance.collection('appointments').get();
  // }

  @override
  Widget build(BuildContext context) {

    //var controller = Get.put(AppointmentController());

    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(
            title: "Appointments",color: Colors.black),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('appointments').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
    if (snapshot.hasError) {
    return Center(
    child: Text('Error: ${snapshot.error}'),
    );
    }
    final List<DocumentSnapshot> appointments = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (BuildContext context,int index) {
    //final appointment = appointments[index];
                    return ListTile(
                      onTap: () {
                        // Navigator.push(context,MaterialPageRoute(
                        //     builder: (context) => AppointmentViewss(salonId: '',)));
                      },
                      leading: CircleAvatar(child: Image.asset(TImages.saloon1),),
                      title: AppStyles.bold(title: "Saloon Name"),
                      subtitle: AppStyles.normal(title: "Appointment time",color: AppColors.textColor.withOpacity(0.5)),
                    );

                  }),
            );
          }

      ),
    );
  }
}
