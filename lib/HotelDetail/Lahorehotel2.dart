import 'dart:convert';

import 'package:flutter/material.dart';
import '../OtherModule/Stays.dart';
import '../theams/Sendbookingmsg.dart';
import 'package:http/http.dart' as http;

class LahoreHotel2 extends StatefulWidget {
  final Hotel hotel;

  LahoreHotel2({required this.hotel});

  @override
  _LahoreHotel2State createState() => _LahoreHotel2State();
}

class _LahoreHotel2State extends State<LahoreHotel2> {
  TextEditingController nameController = TextEditingController();
  TextEditingController peopleController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  List<String> roomTypes = ['Standard', 'Deluxe', 'Suite'];
  String selectedRoomType = 'Standard'; // Default selected room type

  @override
  void dispose() {
    nameController.dispose();
    peopleController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hotel Name
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.blue,
              child: Text(
                widget.hotel.name, // Use actual hotel name
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // Hotel Images (Replace with actual image widgets)
            Image.asset(
              'assets/images/lhrh5.jpg', // Replace with actual image asset path
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Image.asset(
              'assets/images/lhrh6.jpg', // Replace with actual image asset path
              height: 200,
              fit: BoxFit.cover,
            ),
            // Location
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // Align children vertically
                    children: [
                      Icon(
                        Icons.location_on, // Location icon
                        color: Colors.grey,
                      ),
                      SizedBox(width: 8.0), // Add spacing between icon and text
                      Expanded( // Use Expanded to allow the text to take all available space
                        child: Text(
                          '107 B-3, M.M. Alam Road, Gulberg III, Gulberg, 54660 Lahore', // Use actual hotel location
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0), // Add spacing between text and subtitle
                  Text(
                    'Superior Queen Room \n Breakfast Included \n All Types of Rooms Available', // Use actual nearby attractions
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ],
              ),
            ),
            // Reserve Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Reservation'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Your Name',
                                ),
                              ),
                              TextField(
                                controller: peopleController,
                                decoration: InputDecoration(
                                  labelText: 'Number of People',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              TextField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                              SizedBox(height: 16.0),
                              DropdownButtonFormField(
                                value: selectedRoomType,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedRoomType = value!;
                                  });
                                },
                                items: roomTypes.map((String roomType) {
                                  return DropdownMenuItem<String>(
                                    value: roomType,
                                    child: Text(roomType),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  labelText: 'Room Type',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              String name = nameController.text;
                              String msg = "Hello $name 👋\nCongratulations on reserving our ${widget.hotel.name} booking. Looking forward to seeing you! 😀🎉";
                              sendbookMessage(msg);
                              Navigator.of(context).pop();
                            },
                            child: Text('Confirm'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Reserve'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
