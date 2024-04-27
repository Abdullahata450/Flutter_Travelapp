import 'package:flutter/material.dart';

class FlightBookingPage extends StatefulWidget {



  @override
  _FlightBookingPageState createState() => _FlightBookingPageState();
}

class _FlightBookingPageState extends State<FlightBookingPage> {
  String selectedFromCity = 'Karachi';
  String selectedToCity = 'Islamabad';
  DateTime selectedDate = DateTime.now();

  List<Map<String, dynamic>> flightDetails = [
    {
      'fromCity': 'Karachi',
      'toCity': 'Islamabad',
      'flightNumber': 'ABC123',
      'airline': 'Airline A',
      'departureTime': '08:00 AM',
      'arrivalTime': '10:00 AM',
      'price': 200,
    },
    {
      'fromCity': 'Karachi',
      'toCity': 'Lahore',
      'flightNumber': 'XYZ456',
      'airline': 'Airline B',
      'departureTime': '10:30 AM',
      'arrivalTime': '12:30 PM',
      'price': 250,
    },
    {
      'fromCity': 'Lahore',
      'toCity': 'Karachi',
      'flightNumber': 'DEF789',
      'airline': 'Airline C',
      'departureTime': '02:00 PM',
      'arrivalTime': '04:00 PM',
      'price': 180,
    },
    {
      'fromCity': 'Lahore',
      'toCity': 'Quetta',
      'flightNumber': 'GHI234',
      'airline': 'Airline D',
      'departureTime': '05:30 PM',
      'arrivalTime': '07:30 PM',
      'price': 300,
    },
    {
      'fromCity': 'Lahore',
      'toCity': 'Islamabad',
      'flightNumber': 'JKL567',
      'airline': 'Airline E',
      'departureTime': '09:00 AM',
      'arrivalTime': '11:00 AM',
      'price': 220,
    },
  ];

  List<Map<String, dynamic>> filteredFlightDetails = [];

  @override
  void initState() {
    super.initState();
    filterFlightDetails();
  }

  void filterFlightDetails() {
    filteredFlightDetails = flightDetails
        .where((flight) =>
    flight['fromCity'] == selectedFromCity &&
        flight['toCity'] == selectedToCity)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Booking'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // From city selection
            DropdownButtonFormField<String>(
              value: selectedFromCity,
              items: <String>['Karachi', 'Islamabad', 'Lahore', 'Quetta']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedFromCity = newValue!;
                  filterFlightDetails();
                });
              },
              decoration: InputDecoration(
                labelText: 'From',
              ),
            ),
            SizedBox(height: 20),

            // To city selection
            DropdownButtonFormField<String>(
              value: selectedToCity,
              items: <String>['Islamabad', 'Lahore', 'Karachi', 'Quetta']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedToCity = newValue!;
                  filterFlightDetails();
                });
              },
              decoration: InputDecoration(
                labelText: 'To',
              ),
            ),
            SizedBox(height: 20),

            // Date selection
            InkWell(
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != selectedDate) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              child: Container(
                height: 35,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Display filtered flight details
            ListView.builder(
              shrinkWrap: true,
              itemCount: filteredFlightDetails.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                        '${filteredFlightDetails[index]['airline']} - ${filteredFlightDetails[index]['flightNumber']}'),
                    subtitle: Text(
                        'Departure: ${filteredFlightDetails[index]['departureTime']} - Arrival: ${filteredFlightDetails[index]['arrivalTime']}'),
                    trailing: Text('\$${filteredFlightDetails[index]['price']}'),
                    onTap: () {
                      // Add booking logic here
                      print('Booking ticket from ${filteredFlightDetails[index]['fromCity']} to ${filteredFlightDetails[index]['toCity']} on $selectedDate');
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: FlightBookingPage(),
//   ));
// }