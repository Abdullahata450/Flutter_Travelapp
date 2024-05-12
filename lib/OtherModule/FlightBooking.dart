import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'Pyament.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlightBookingPage(),
    );
  }
}

class FlightBookingPage extends StatefulWidget {
  @override
  _FlightBookingPageState createState() => _FlightBookingPageState();
}

class _FlightBookingPageState extends State<FlightBookingPage> {
  String origin = '';
  String destination = '';
  List<Map<String, dynamic>> flights = [];
  List<Map<String, dynamic>> filteredFlights = [];
  DateTime selectedDate = DateTime.now(); // Add this line

  @override
  void initState() {
    super.initState();
    loadFlightData();
  }

  Future<void> loadFlightData() async {
    String jsonData = await rootBundle.loadString('assets/flight_data.json');
    Map<String, dynamic> jsonDataMap = jsonDecode(jsonData);
    setState(() {
      flights = List<Map<String, dynamic>>.from(jsonDataMap['data']);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Search'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      origin = value;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'Origin',
                      hintText: 'Enter origin city',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      destination = value;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'Destination',
                      hintText: 'Enter destination city',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                    'Select Date :  ${selectedDate.toString().substring(0, 10)}',
                    style: TextStyle(fontSize: 16.0)),
              ),
              // Search Button
              // ElevatedButton(
              //   onPressed: () {
              //     ElevatedButton.styleFrom(
              //         foregroundColor: Colors.yellow
              //     );
              //     // Filter flights based on origin and destination
              //     setState(() {
              //       filteredFlights = flights.where((flight) {
              //         String departureCity = flight['departure']['city'];
              //         String arrivalCity = flight['arrival']['city'];
              //         return departureCity.toLowerCase() == origin.toLowerCase() &&
              //             arrivalCity.toLowerCase() == destination.toLowerCase();
              //       }).toList();
              //     });
              //   },
              //   child: Text('Search Flights'),
              //
              // ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  // Filter flights based on origin and destination
                  setState(() {
                    filteredFlights = flights.where((flight) {
                      String departureCity = flight['departure']['city'];
                      String arrivalCity = flight['arrival']['city'];
                      return departureCity.toLowerCase() ==
                              origin.toLowerCase() &&
                          arrivalCity.toLowerCase() ==
                              destination.toLowerCase();
                    }).toList();
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  // Background color
                  backgroundColor: Colors.indigo.shade200,
                  // Text color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 3, // Shadow elevation
                ),
                child: Text('Search Flights'),
              ),

              SizedBox(height: 20.0),
              // Display filtered flight data
              ListView.builder(
                shrinkWrap: true,
                itemCount: filteredFlights.length,
                itemBuilder: (context, index) {
                  return FlightCard(flight: filteredFlights[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FlightCard extends StatelessWidget {
  final Map<String, dynamic> flight;

  FlightCard({required this.flight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showTicketMessage(context, flight); // Pass flight data to the method
      },
      child: Card(
        color: Colors.yellow.shade100,
        child: ListTile(
          title: Text(
            '${flight['airline']['name']} - ${flight['flight']['number']}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Departure: ${flight['departure']['airport']} \n Time : ${flight['departure']['scheduled']}',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.indigo),
              ),
              Text(
                  'Arrival: ${flight['arrival']['airport']} \n Time: ${flight['arrival']['scheduled']}',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.green.shade800)),
            ],
          ),
        ),
      ),
    );
  }
}

void _showTicketMessage(BuildContext context, Map<String, dynamic> flight) {
  // Accept flight data as a parameter
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.indigo.shade200,
        title: Text(
          'Buy Ticket',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        content: Text(
            'Do you want to buy a ticket for this flight? \n Price 16500 Rs',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text('No',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              // Navigate to ticket purchase screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PaymentForm(flight: flight)),
              );
            },
            child: Text('Yes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ),
        ],
      );
    },
  );
}
