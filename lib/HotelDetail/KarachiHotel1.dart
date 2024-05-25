import 'package:flutter/material.dart';
import '../OtherModule/Stays.dart';
import '../theams/Sendbookingmsg.dart';

class KarachiHotel1 extends StatelessWidget {
  final Hotel hotel;
  TextEditingController nameController = TextEditingController();

  KarachiHotel1({required this.hotel});

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
                hotel.name, // Use actual hotel name
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
              'assets/images/karh1.png', // Replace with actual image asset path
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10,),
            Image.asset(
              'assets/images/karh2.png', // Replace with actual image asset path
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
                          '789 Karachi Avenue, Karachi, Pakistan', // Use actual hotel location
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
                    'Executive Suite \n Buffet Breakfast \n Airport Shuttle', // Use actual nearby attractions
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey.shade900
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
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              String name=nameController.text;
                              String msg="Hello ${name} 👋\nCongratulations on reserving our hotel booking Looking Forward To See You! 😀🎉";
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
                child: Text('Reserve'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
