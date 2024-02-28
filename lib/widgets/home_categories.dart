// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import '../utils/image_strings.dart';
// import '../widgets/vertical_image_text.dart';

// class THomeCategories extends StatelessWidget {
//    THomeCategories({Key? key}) : super(key: key);

//   final List<String> images = [
//     'assets/image1.jpg',
//     'assets/image2.jpg',
//     'assets/image3.jpg',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Carousel Page'),
//       ),
//       body: Container( // Wrap the CarouselSlider.builder with a Container
//         height: 200, // Set a fixed height for the container
//         child: CarouselSlider.builder(
//           itemCount: images.length,
//           itemBuilder: (BuildContext context, int index, int realIndex) {
//             return Image.asset(
//               images[index],
//               fit: BoxFit.cover,
//             );
//           },
//           options: CarouselOptions(
//             aspectRatio: 16 / 9,
//             viewportFraction: 0.8,
//             initialPage: 0,
//             enableInfiniteScroll: true,
//             autoPlay: true,
//             autoPlayInterval: Duration(seconds: 3),
//             autoPlayAnimationDuration: Duration(milliseconds: 800),
//             autoPlayCurve: Curves.fastOutSlowIn,
//             enlargeCenterPage: true,
//             scrollDirection: Axis.horizontal,
//           ),
//         ),
//       ),
//     );
//   }
// }
