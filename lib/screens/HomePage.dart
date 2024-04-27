import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../OtherModule/FlightBooking.dart';
import '../theams/BottomNavbar.dart';
import '../theams/Homeappbar.dart';
import 'HomeScreen.dart';

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
    "Airport Taxi",
    "Map",
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
                          onTap: () {},
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
                  SizedBox(height: 20,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            GestureDetector(
                              onTap: () {
                               switch(i){
                                 case 0:
                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(builder: (context) => HomeScreen()),
                                   );
                                   break;
                                 case 1:
                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(builder: (context) => FlightBookingPage()),
                                   );
                                   break;
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
                  SizedBox(height: 20,),
                  Text(
                    "Trending Destination in Pakistan",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  SizedBox(height: 20,),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(), // Disable scrolling
                    shrinkWrap: true,
                    itemCount: 3, // Set the number of items
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0), // Add padding as needed
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/city${index + 1}.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),

                            ),
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: RatingBar.builder(
                                    // itemBuilder: (BuildContext context, int index) {  }, onRatingUpdate: (double value) {  },
                                    initialRating: 3,
                                    minRating: 1,
                                    itemSize: 27,
                                    unratedColor: Colors.white,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.favorite,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  )
                                ),
                              ],
                            ),


                          ),

                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Gnav(),
      ),
    );
  }
}
