import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Cities/IslamabadPostScreen.dart';
import '../Cities/KPKpostScreen.dart';
import '../Cities/KarchipostScreen.dart';
import '../Cities/KashmirPostScreen.dart';
import '../Cities/LahorepostScreen.dart';
import '../Cities/MultanPostScreen.dart';
import '../OtherModule/CarRent.dart';
import '../OtherModule/FlightBooking.dart';
import '../OtherModule/Maplocation.dart';
import '../OtherModule/Stays.dart';
import '../theams/BottomNavbar.dart';
import '../theams/Homeappbar.dart';
import 'HomeScreen.dart';
import 'guidScreen.dart';

void main() {
  runApp(Homepage());
}

class Homepage extends StatelessWidget {
  List<String> cityNames = [
    "Lahore",
    "Karachi",
    "Islamabad",
    "Multan",
    "KPK",
    "Kashmir"
  ];
  List<String> Catagory = [
    "Stays",
    "Flight",
    "Car Rental",
    "Avail Guides",
    "Map",
  ];

  List<dynamic> cityRoutes = [
    LahorePostScreen(),
    KarachipostScreen(),
    IslamabadPostScreen(),
    MultanPostScreen(),
    KPKpostScreen(),
    KashmirPostScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.indigo.shade50,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: HomeAppBar(),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 260,
                    child: ListView.builder(
                      itemCount: 6,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            // Navigate to the corresponding city post screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => cityRoutes[index],
                              ),
                            );
                          },
                          child: Container(
                            width: 150,
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/city${index + 1}.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.bookmark_add_outlined,
                                    size: 29,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  child: Text(
                                    cityNames[index],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            GestureDetector(
                              onTap: () {
                                switch (i) {
                                  case 0:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Stays()),
                                    );
                                    break;
                                  case 1:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FlightBookingPage()),
                                    );
                                    break;
                                  case 2:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CarRent()),
                                    );
                                    break;
                                  case 3:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GuidScreen()),
                                    );
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.indigoAccent.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white,
                                      )
                                    ]),
                                child: Text(
                                  Catagory[i],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.1),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Trending Destination in Pakistan",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    // Disable scrolling
                    shrinkWrap: true,
                    itemCount: 3, // Changed itemCount to 6
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0), // Add padding as needed
                        child: InkWell(
                          onTap: () {
                            // Navigate to the corresponding city post screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => cityRoutes[index],
                              ),
                            );
                          },
                          child: Container(
                            height: 200,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/city${index + 1}.jpg",
                                      ),
                                      fit: BoxFit.cover,
                                      opacity: 0.7,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          // Access the corresponding text for each index
                                          cityNames[index],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RatingBar.builder(
                                          initialRating: 3,
                                          minRating: 1,
                                          itemSize: 27,
                                          unratedColor: Colors.white,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.favorite,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],///
              ),
            ),
          ),
        ),
        bottomNavigationBar: Gnav(),


      ),
    );
  }
}


