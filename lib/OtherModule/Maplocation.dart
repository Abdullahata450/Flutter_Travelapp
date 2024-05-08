// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Google Maps Image',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: GoogleMapsImage(),
//     );
//   }
// }
//
// class GoogleMapsImage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Maps Image'),
//       ),
//       body: Center(
//         child: GestureDetector(
//           onTap: () {
//             _openGoogleMaps();
//           },
//           child: Image.asset(
//             'assets/images/map_image.png',
//             width: 200, // Adjust the size as needed
//             height: 200,
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _openGoogleMaps() async {
//     const url = 'https://www.google.com/maps';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }
