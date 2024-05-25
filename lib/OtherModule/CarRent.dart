import 'package:flutter/material.dart';

import '../screens/HomePage.dart';
import '../theams/BottomNavbar.dart';
import 'StripePayment.dart';

class CarRent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Looking For A Car?",
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo.shade50,
            foregroundColor: Colors.black,
            title: Text("Looking For a Car?",textAlign: TextAlign.center,),
            bottom: TabBar(
              tabs: [
                Tab(child:Text("Honda",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.purple.shade400,fontSize: 20),)),
                Tab(child:Text("Toyota",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.purple.shade400,fontSize: 20),)),
                Tab(child:Text("Suzuki",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.purple.shade400,fontSize: 20),)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              CarList(carType: "Honda"),
              CarList(carType: "Corolla"),
              CarList(carType: "Suzuki"),
            ],
          ),
        ),
      ),
    );
  }
}

class CarList extends StatelessWidget {
  final String carType;

  CarList({required this.carType});

  @override
  Widget build(BuildContext context) {
    // Dummy car data for demonstration
    List<Map<String, dynamic>> hondaCars = [
      {
        "name": "Make Honda Model Civic",
        "image": "assets/images/honda1.jpg",
        "seats": 4,
        "engineType": "Petrol",
        "price": "\$50/day",
      },
      {
        "name": "Make Honda Model Jeep",
        "image": "assets/images/honda2.jpg",
        "seats": 7,
        "engineType": "Diesel",
        "price": "\$60/day",
      },
    ];

    List<Map<String, dynamic>> corollaCars = [
      {
        "name": "Toyota Corolla",
        "image": "assets/images/corolla.jpg",
        "seats": 5,
        "engineType": "Petrol",
        "price": "\$70/day",
      },
      {
        "name": "Toyota Fortuiner ",
        "image": "assets/images/fortuiner.jpg",
        "seats": 7,
        "engineType": "Diesel",
        "price": "\$90/day",
      },
    ];

    List<Map<String, dynamic>> suzukiCars = [
      {
        "name": "Suzuki Swift",
        "image": "assets/images/Swift.jpg",
        "seats": 5,
        "engineType": "Petrol",
        "price": "\$90/day",
      },
      {
        "name": "Suzuki Every",
        "image": "assets/images/Every.jpg",
        "seats": 8,
        "engineType": "Petrol",
        "price": "\$100/day",
      },
    ];

    List<Map<String, dynamic>> cars = [];
    if (carType == "Honda") {
      cars = hondaCars;
    } else if (carType == "Corolla") {
      cars = corollaCars;
    } else if (carType == "Suzuki") {
      cars = suzukiCars;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(carType),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Homepage()),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.asset(
                          cars[index]["image"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cars[index]["name"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.event_seat),
                              SizedBox(width: 5),
                              Text(
                                "${cars[index]["seats"]} Seats",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.engineering_sharp),
                              SizedBox(width: 5),
                              Text(
                                "Engine: ${cars[index]["engineType"]}",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Price: ${cars[index]["price"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => myStrip(),
                        //   ),
                        // );
                        // Add functionality to rent the car
                        // For now, just show a toast message
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text("You rented ${cars[index]["name"]}"),
                        //   ),
                        // );
                      },
                      child: Text("Rent",style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar:  Gnav(),
    );
  }
}

void main() {
  runApp(CarRent());
}
