import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../theams/Sendbookingmsg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GuidScreen(),
    );
  }
}

class GuidScreen extends StatefulWidget {
  @override
  _GuidScreenState createState() => _GuidScreenState();
}

class _GuidScreenState extends State<GuidScreen> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  String lahoreAgent = '';
  String karachiImgUrl = '';
  String islamabadImgUrl = '';

  @override
  void initState() {
    super.initState();
    getImageUrls();
  }

  Future<void> getImageUrls() async {
    try {
      final lahoreRef = storage.ref().child('me.jpg');
      final karachiRef = storage.ref().child('humayun.jpg');
      final islamabadRef = storage.ref().child('me.jpg');

      final lahoreUrl = await lahoreRef.getDownloadURL();
      final karachiUrl = await karachiRef.getDownloadURL();
      final islamabadUrl = await islamabadRef.getDownloadURL();

      setState(() {
        lahoreAgent = lahoreUrl;
        karachiImgUrl = karachiUrl;
        islamabadImgUrl = islamabadUrl;
      });
    } catch (e) {
      print('Failed to get image URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tourist Guide - Pakistan'),
        backgroundColor: Colors.indigo.shade200,
      ),
      body: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("assets/images/pakistanflag.jpeg"),
          //   fit: BoxFit.cover,
          //   colorFilter: ColorFilter.mode(
          //     Colors.black.withOpacity(0.7),
          //     BlendMode.dstATop,
          //   ),
          // ),
          color: Colors.green.shade200
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeaderSection("Tourist Guide - Pakistan"),
                  SizedBox(height: 20),
                  buildTouristSpotCard(
                    context,
                    lahoreAgent,
                    "Lahore",
                    "Abdullah",
                    "abdullahbinata450@gmail.com",
                    4,
                    "Experience the historical and cultural richness of Lahore.",
                    4.7,
                  ),
                  buildTouristSpotCard(
                    context,
                    karachiImgUrl,
                    "Karachi",
                    "Humayun",
                    "humayunZafar@gmail.com",
                    3,
                    "Explore the bustling city of Karachi with its vibrant markets and beaches.",
                    4.5,
                  ),
                  buildTouristSpotCard(
                    context,
                    islamabadImgUrl,
                    "Islamabad",
                    "Hamza",
                    "abdullahbinata450@gmail.com",
                    3,
                    "Discover the serene and modern capital city of Islamabad.",
                    4.8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Explore the beauty of Pakistan, from its majestic mountains to its vibrant cities.",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget buildTouristSpotCard(
      BuildContext context,
      String imageUrl,
      String cityName,
      String name,
      String email,
      double experience,
      String description,
      double rating,
      ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(cityName),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  imageUrl.isNotEmpty
                      ? Image.network(imageUrl, fit: BoxFit.cover)
                      : CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Contact Information:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Name: $name'),
                  Text('City: $cityName'),
                  Text('Email: $email'),
                  Text('Experience: $experience years'),
                  Text('Charges: 5000 PKR/day'),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(onPressed: () {
                  showConfirmationDialog(context, cityName, name);
                }, child: Text("Hire Me")),
              ],
            );
          },
        );
      },
      child: Card(
        color: Colors.green.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                image: DecorationImage(
                  image: imageUrl.isNotEmpty
                      ? NetworkImage(imageUrl)
                      : AssetImage("assets/images/bg4.jpg") as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Available For City: $cityName",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  RatingBarIndicator(
                    rating: rating,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showConfirmationDialog(BuildContext context, String cityName, String name) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirmation"),
        content: Text("Do you want to hire $name for $cityName?"),
        actions: [
          TextButton(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text("Yes"),
            onPressed: () {
              String msg="Hello 👋\n ThankYou For Booking Our Agent ${name} for City ${cityName} ! 😀🎉 \n Our Agent will Contact Your Shortly";
              sendbookMessage(msg);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You have hired $name for $cityName.')),
              );
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
