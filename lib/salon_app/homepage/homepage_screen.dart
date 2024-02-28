import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estilo_salon/custom_shapes/primary_header_container.dart';
import 'package:estilo_salon/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import carousel_slider package

import '../../custom_shapes/container_homepage.dart';
import '../../utils/fonts.dart';
import '../../utils/image_strings.dart';
import '../../widgets/home_categories.dart';
import '../../widgets/search_container.dart';
import '../../widgets/section_heading_texts.dart';
import '../saloon_profils/saloon_views.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Set the title of the AppBar
        title: Text('Estilo Saloon'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Primary Header Container
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  // Search bar
                  TSearchContainer(
                    text: 'Search',
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),

                  // Categories
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        // Heading
                        TSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),

                        // Carousel for popular categories
                        _buildCarousel(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Top Rated Saloon Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Rated Saloon",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("View all tapped");
                        },
                        child: Text(
                          "View all",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  // Top rated saloon list
                  _buildTopRatedSaloonList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build the carousel for popular categories
  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
      items: [
        // Replace AssetImage with your actual images
        AssetImage(TImages.saloon1),
        AssetImage(TImages.saloon2),
        //AssetImage(TImages.saloon3),
      ].map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: image as ImageProvider<Object>,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  // Widget to build the list of top rated saloons
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
                var salonName = salonData['salonName'] ?? 'Saloon Name';
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
                        // Image of the saloon
                        Image.asset(
                          'assets/Hair_salon.png', // Update with your image asset path
                          width: double.infinity,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 8),
                        // Saloon name
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