import 'package:flutter/material.dart';

import '../HotelDetail/Lahorehotel1.dart';
import '../HotelDetail/Lahorehotel2.dart';
import '../HotelDetail/IslamabadHotel1.dart';
import '../HotelDetail/IslamabadHotel2.dart';
import '../HotelDetail/KarachiHotel1.dart';
import '../HotelDetail/KarachiHotel2.dart';
import '../HotelDetail/KashmirHotel1.dart'; // Changed from KPKHotel1.dart to KashmirHotel1.dart
import '../HotelDetail/KashmirHotel2.dart'; // Changed from KPKHotel2.dart to KashmirHotel2.dart
import '../HotelDetail/MultanHotel1.dart';
import '../HotelDetail/MultanHotel2.dart';

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
  final Map<String, List<Hotel>> cityHotelData = {
    'Lahore': [
      Hotel(name: 'Indigo Heights Hotel & Suites', imagePath: 'assets/images/lhrh1.jpg', price: 100),
      Hotel(name: 'Park Lane Hotel', imagePath: 'assets/images/lhrh2.jpg', price: 150),
    ],
    'Islamabad': [
      Hotel(name: 'Ramada by Wyndham Islamabad', imagePath: 'assets/images/islh1.png', price: 120),
      Hotel(name: 'SK Residence', imagePath: 'assets/images/islh2.png', price: 130),
    ],
    'Karachi': [
      Hotel(name: 'four squares hotel', imagePath: 'assets/images/karh1.png', price: 120),
      Hotel(name: 'Hotel 7', imagePath: 'assets/images/karh2.png', price: 130),
    ],
    'Kashmir': [ // Changed from 'KPK' to 'Kashmir'
      Hotel(name: 'Srinagar Homes', imagePath: 'assets/images/kpk1.jpg', price: 110),
      Hotel(name: 'Pearl Continental Hotel, Muzaffarabad', imagePath: 'assets/images/kpk2.jpg', price: 140),
    ],
    'Multan': [
      Hotel(name: 'Hotel One Lalazar Multan', imagePath: 'assets/images/mult1.jpg', price: 110),
      Hotel(name: 'S Chalet Multan', imagePath: 'assets/images/mult3.jpg', price: 140),
    ],
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
            case 'Ramada by Wyndham Islamabad':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IslamabadHotel1(hotel: hotel),
                ),
              );
              break;
            case 'SK Residence':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IslamabadHotel2(hotel: hotel),
                ),
              );
              break;
            case 'four squares hotel':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KarachiHotel1(hotel: hotel),
                ),
              );
              break;
            case 'Hotel 7':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KarachiHotel2(hotel: hotel),
                ),
              );
              break;
            case 'Srinagar Homes':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KPKHotel1(hotel: hotel), // Changed from KPKHotel1 to KashmirHotel1
                ),
              );
              break;
            case 'Pearl Continental Hotel, Muzaffarabad':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KPKHotel1(hotel: hotel), // Changed from KPKHotel2 to KashmirHotel2
                ),
              );
              break;
            case 'Hotel One Lalazar Multan':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MultanHotel1(hotel: hotel),
                ),
              );
              break;
            case 'S Chalet Multan':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MultanHotel2(hotel: hotel),
                ),
              );
              break;
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
