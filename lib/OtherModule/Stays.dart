import 'package:flutter/material.dart';

import '../HotelDetail/Lahorehotel1.dart';
import '../HotelDetail/Lahorehotel2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Stays(),
    );
  }
}

class Stays extends StatefulWidget {
  @override
  _StaysState createState() => _StaysState();
}

class _StaysState extends State<Stays> {
  // Define mapping of cities to their corresponding hotel data
  final Map<String, List<Hotel>> cityHotelData = {
    'Lahore': [
      Hotel(name: 'Indigo Heights Hotel & Suites', imagePath: 'assets/images/lhrh1.jpg', price: 100),
      Hotel(name: 'Park Lane Hotel', imagePath: 'assets/images/lhrh2.jpg', price: 150),
    ],
    'Karachi': [
      Hotel(name: 'Hotel DEF', imagePath: '', price: 120),
      Hotel(name: 'Hotel GHI', imagePath: '', price: 130),
    ],
    // Add more cities and their hotel data as needed
  };

  List<String> filteredCities = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCities.addAll(cityHotelData.keys);
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      setState(() {
        filteredCities = cityHotelData.keys.where((city) => city.toLowerCase().contains(query.toLowerCase())).toList();
      });
    } else {
      setState(() {
        filteredCities.addAll(cityHotelData.keys);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel Booking'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                filterSearchResults(value);
              },
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCities.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(filteredCities[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HotelPage(city: filteredCities[index], hotels: cityHotelData[filteredCities[index]]!),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HotelPage extends StatelessWidget {
  final String city;
  final List<Hotel> hotels;

  HotelPage({required this.city, required this.hotels});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels in $city'),
      ),
      body: ListView(
        children: hotels.map((hotel) {
          return HotelCard(hotel: hotel);
        }).toList(),
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final Hotel hotel;

  HotelCard({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Navigate to a different page based on the hotel's data
          switch (hotel.name) {
            case 'Indigo Heights Hotel & Suites':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LahoreHotel1(hotel: hotel),
                ),
              );
              break;
            case 'Park Lane Hotel':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LahoreHotel2(hotel: hotel),
                ),
              );
              break;
          // Add cases for more hotels if needed
            default:
            // Do nothing
          }
        },
        child: Column(
          children: [
            hotel.imagePath.isNotEmpty
                ? Image.asset(
              hotel.imagePath,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : Placeholder( // Placeholder if imagePath is empty
              fallbackHeight: 150,
              fallbackWidth: double.infinity,
            ),
            ListTile(
              title: Text(hotel.name),
              subtitle: Text('Price: \$${hotel.price.toStringAsFixed(2)}'),
            ),
          ],
        ),
      ),
    );
  }
}

class Hotel {
  final String name;
  final String imagePath;
  final double price;

  Hotel({required this.name, required this.imagePath, required this.price});
}
