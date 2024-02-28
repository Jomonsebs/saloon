
//BOOKING PAGE FOR CHECKIN & CHECKDATE
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class XSM extends StatefulWidget {
//   const XSM({super.key, required this.details, required this.cost});
//
//   final String details;
//   final String cost;
//
//   @override
//   State<XSM> createState() => _XSMState();
// }
//
// class _XSMState extends State<XSM> {
//   DateTime? _checkInDate;
//   DateTime? _checkOutDate;
//
//   Future<void> _selectCheckInDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime.now(),
//         lastDate: DateTime.now().add(Duration(days: 365)));
//     if (picked != null && picked != _checkInDate) {
//       setState(() {
//         _checkInDate = picked;
//       });
//     }
//   }
//
//   Future<void> _selectCheckOutDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: _checkInDate ?? DateTime.now(),
//         lastDate: DateTime.now().add(Duration(days: 365)));
//     if (picked != null && picked != _checkOutDate) {
//       setState(() {
//         _checkOutDate = picked;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Booking Page'),
//           backgroundColor: Color.fromARGB(255, 165, 19, 21),
//           elevation: 0,
//         ),
//         backgroundColor: Color.fromARGB(255, 250, 217, 217),
//         body: Center(
//           child: SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'CHECK-IN',
//                                       style: TextStyle(fontSize: 16.0),
//                                     ),
//                                     InkWell(
//                                       onTap: () => _selectCheckInDate(context),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color: Colors.blue, width: 1.0),
//                                           borderRadius:
//                                               BorderRadius.circular(5.0),
//                                         ),
//                                         height: 50.0,
//                                         alignment: Alignment.center,
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Icon(Icons.calendar_today),
//                                             SizedBox(width: 5.0),
//                                             _checkInDate == null
//                                                 ? Text('Select date')
//                                                 : Text(
//                                                     '${_checkInDate!.day}/${_checkInDate!.month}/${_checkInDate!.year}'),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'CHECK-OUT',
//                                       style: TextStyle(fontSize: 16.0),
//                                     ),
//                                     InkWell(
//                                       onTap: () => _selectCheckOutDate(context),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color: Colors.blue, width: 1.0),
//                                           borderRadius:
//                                               BorderRadius.circular(5.0),
//                                         ),
//                                         height: 50.0,
//                                         alignment: Alignment.center,
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Icon(Icons.calendar_today),
//                                             SizedBox(width: 5.0),
//                                             _checkOutDate == null
//                                                 ? Text('Select date')
//                                                 : Text(
//                                                     '${_checkOutDate!.day}/${_checkOutDate!.month}/${_checkOutDate!.year}'),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 45.0),
//                         SizedBox(height: 45.0),
//                         Text(
//                           'Cost per Night: ${widget.cost}',
//                           style: TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 30.0),
//                         Text(
//                           'Only pay the Booking Confirmation Amount ',
//                           style: TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 30.0),
//                         ElevatedButton(
//                           onPressed: () {
//                             if (_checkInDate == null || _checkOutDate == null) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     'Please select check-in and check-out dates',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   backgroundColor: Colors.red,
//                                 ),
//                               );
//                               return;
//                             }
//                             final userId =
//                                 FirebaseAuth.instance.currentUser!.uid;
//                             final userEmail =
//                                 FirebaseAuth.instance.currentUser!.email;
//                             FirebaseFirestore.instance
//                                 .collection('bookings')
//                                 .add({
//                               'details': widget.details,
//                               'cost': widget.cost,
//                               'checkIn': _checkInDate!,
//                               'checkOut': _checkOutDate!,
//                               'userId': userId,
//                               'userEmail': userEmail,
//                             });
//                             SnackBar(
//                               content: Text(
//                                 'Booking added successfully',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               backgroundColor: Color.fromARGB(255, 165, 19, 21),
//                             );
//                           },
//                           child: Text('Pay Now'),
//                           style: ElevatedButton.styleFrom(
//                             primary: Color.fromARGB(255, 165, 19, 21),
//                             onPrimary: Colors.white,
//                             textStyle: TextStyle(fontSize: 16.0),
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 32.0,
//                               vertical: 16.0,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }
