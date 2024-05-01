// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../theams/BottomNavbar.dart';
// import '../theams/Homeappbar.dart';
//
// void main() {
//   runApp(Homepage());
// }
//
// class Homepage extends StatelessWidget {
//   final List<String> cityNames = [
//     "Lahore",
//     "Karachi",
//     "Islamabad",
//     "Multan",
//     "KPK",
//     "Kashmir"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//           backgroundColor: Colors.indigo.shade50,
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(90),
//             child: HomeAppBar(),
//           ),
//           body: SafeArea(
//             child: Padding(
//               padding: EdgeInsetsDirectional.symmetric(vertical: 30),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 260,
//                       child: ListView.builder(
//                         itemCount: 6,
//                         scrollDirection: Axis.horizontal,
//                         shrinkWrap: true,
//                         itemBuilder: (BuildContext context, int index) {
//                           return InkWell(
//                             onTap: () {},
//                             child: Container(
//                                 width: 150,
//                                 padding: EdgeInsets.all(20),
//                                 margin: EdgeInsets.only(left: 15),
//                                 decoration: BoxDecoration(
//                                   color: Colors.black,
//                                   borderRadius: BorderRadius.circular(15),
//                                   image: DecorationImage(
//                                     image: AssetImage(
//                                         "assets/images/city${index + 1}.jpg"),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       alignment: Alignment.topRight,
//                                       child: Icon(
//                                         Icons.bookmark_add_outlined,
//                                         size: 29,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//
//                                     Spacer(),
//                                     Container(
//                                       child: Text(
//                                         cityNames[index],
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//
//                                     ),
//
//
//                                   ],
//
//                                 ),
//
//                             ),
//
//                           );
//                         },
//                       ),
//
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           // bottomNavigationBar.(
//           //
//           // )
//           bottomNavigationBar: Gnav()),
//     );
//   }
// }