import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estilo_salon/utils/fonts.dart';
import 'package:estilo_salon/utils/image_strings.dart';
import 'package:velocity_x/velocity_x.dart';
import 'appoinment_views.dart';

class SaloonViews extends StatelessWidget {
  final String salonId;

  const SaloonViews({Key? key, required this.salonId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      appBar: AppBar(
        title: AppStyles.bold(
          title: "Salon Name",
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('salons').doc(salonId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final salonData = snapshot.data!.data() as Map<String, dynamic>?;

          if (salonData == null) {
            return Center(child: Text("Salon not found."));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: Image.asset(TImages.saloon1),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppStyles.bold(
                              title: salonData['salonName'],
                              color: AppColors.textColor,
                            ),
                            AppStyles.bold(
                              title: "Category",
                              color: AppColors.textColor.withOpacity(0.5),
                            ),
                            Spacer(),
                            VxRating(
                              selectionColor: AppColors.yellowColor,
                              onRatingUpdate: (value) {},
                              maxRating: 5,
                              count: 5,
                              value: 4,
                              stepInt: true,
                            )
                          ],
                        ),
                      ),
                      AppStyles.bold(
                        title: "See all reviews",
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: AppStyles.bold(title: "Phone Number", color: AppColors.textColor),
                        subtitle: AppStyles.normal(
                          title: salonData['phoneNumber'],
                          color: AppColors.textColor.withOpacity(0.5),
                        ),
                        trailing: Container(
                          width: 50,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.yellowColor,
                          ),
                          child: Icon(Icons.phone, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 10),
                      AppStyles.bold(title: "About", color: AppColors.textColor),
                      SizedBox(height: 10),
                      AppStyles.normal(
                        title: salonData['about'],
                        color: AppColors.textColor.withOpacity(0.5),
                      ),
                      SizedBox(height: 10),
                      AppStyles.bold(title: "Address", color: AppColors.textColor),
                      SizedBox(height: 10),
                      AppStyles.normal(
                        title: salonData['address'],
                        color: AppColors.textColor.withOpacity(0.5),
                      ),
                      SizedBox(height: 10),
                      AppStyles.bold(title: "Working Time", color: AppColors.textColor),
                      SizedBox(height: 10),
                      AppStyles.normal(
                        title: salonData['workingTime'],
                        color: AppColors.textColor.withOpacity(0.5),
                      ),
                      SizedBox(height: 10),
                      AppStyles.bold(title: "Services", color: AppColors.textColor),
                      SizedBox(height: 10),
                      AppStyles.normal(
                        title: salonData['services'],
                        color: AppColors.textColor.withOpacity(0.5),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppointmentViews(salonId: salonId,)),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: Text("Book an Appointment"),
        ),
      ),
    );
  }
}
