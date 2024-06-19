import 'package:flutter/material.dart';
import '../OtherModule/Stays.dart';
import '../theams/Sendbookingmsg.dart';

class IslamabadHotel1 extends StatefulWidget {
  final Hotel hotel;

  IslamabadHotel1({required this.hotel});

  @override
  _IslamabadHotel1State createState() => _IslamabadHotel1State();
}

class _IslamabadHotel1State extends State<IslamabadHotel1> {
  TextEditingController nameController = TextEditingController();
  List<String> roomTypes = ['Standard', 'Deluxe', 'Suite'];
  String selectedRoomType = 'None'; // Default selected room type

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
                widget.hotel.name, // Use actual hotel name from widget
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
              'assets/images/islh3.png', // Replace with actual image asset path
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Image.asset(
              'assets/images/islh4.png', // Replace with actual image asset path
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          '123 Islamabad Road, Islamabad, Pakistan', // Use actual hotel location
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Deluxe Suite \n Free Wi-Fi \n Swimming Pool', // Use actual nearby attractions
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
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
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
                                    decoration: InputDecoration(
                                      labelText: 'Number of People',
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                  TextField(
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
                                  String msg =
                                      "Hello $name 👋\nCongratulations on reserving our hotel booking. Looking forward to seeing you! 😀🎉";
                                  sendbookMessage(msg);
                                },
                                child: Text('Confirm'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Handle reservation cancellation
                                  Navigator.of(context).pop();
                                  // Add your logic for canceling the reservation here
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          );
                        },
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
