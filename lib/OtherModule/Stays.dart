import 'package:flutter/material.dart';

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
      Hotel(name: 'Hotel ABC', imageUrl: 'https://www.gstatic.com/webp/gallery3/2.png', price: 100),
      Hotel(name: 'Hotel XYZ', imageUrl: 'https://www.gstatic.com/webp/gallery3/3.png', price: 150),
    ],
    'Karachi': [
      Hotel(name: 'Hotel DEF', imageUrl: 'https://www.gstatic.com/webp/gallery/4.jpg', price: 120),
      Hotel(name: 'Hotel GHI', imageUrl: 'https://www.gstatic.com/webp/gallery/5.jpg', price: 130),
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
      child: Column(
        children: [
          Image.network(
            hotel.imageUrl,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(hotel.name),
            subtitle: Text('Price: \$${hotel.price.toStringAsFixed(2)}'),
            onTap: () {
              // Handle hotel selection, booking, etc.
              // You can navigate to another page for booking or implement it here.
            },
          ),
        ],
      ),
    );
  }
}

class Hotel {
  final String name;
  final String imageUrl;
  final double price;

  Hotel({required this.name, required this.imageUrl, required this.price});
}
