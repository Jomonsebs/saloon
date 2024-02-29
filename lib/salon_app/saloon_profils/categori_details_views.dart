import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/fonts.dart';
import '../../widgets/appbar.dart';
import 'saloon_views.dart';

class CategoriDetailsViews extends StatelessWidget {
  const CategoriDetailsViews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Category")),
      body: _buildTopRatedSaloonList(),
    );
  }

  Widget _buildTopRatedSaloonList() {
    return SizedBox(
      height: 150,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('salons').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var salonData = snapshot.data!.docs[index].data() as Map<String, dynamic>; // Cast to Map<String, dynamic>
                var salonId = snapshot.data!.docs[index].id;
                var salonName = salonData['salonName'] ?? 'Salon Name';
                var address = salonData['address'] ?? 'Location';
                return GestureDetector(
                  onTap: () {
                    // Navigate to the detailed view of the salon
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SaloonViews(salonId: salonId)),
                    );
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.only(right: 8),
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image of the salon (You can use your own image asset)
                        Image.asset(
                          'assets/Hair_salon.png', // Update with your image asset path
                          width: double.infinity,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 8),
                        // Salon name
                        Text(
                          salonName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // Location
                        Text(
                          address,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
