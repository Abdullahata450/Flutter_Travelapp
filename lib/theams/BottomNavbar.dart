import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../OtherModule/CarRent.dart';
import '../OtherModule/FlightBooking.dart';
import '../screens/HomePage.dart';
import '../screens/UserProfileScreen.dart';

class Gnav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
          vertical: screenHeight * 0.03,
        ),
        color: Colors.indigo.shade200,
        child: GNav(
          backgroundColor: Colors.indigo.shade200,
          color: Colors.white,
          tabBackgroundColor: Colors.red.shade200,
          curve: Curves.easeOutExpo,
          duration: Duration(milliseconds: 1000),
          gap: screenWidth * 0.01,
          rippleColor: Colors.grey,
          hoverColor: Colors.purple.shade400,
          haptic: true,
          tabBorderRadius: screenWidth * 0.03,
          padding: EdgeInsets.all(screenWidth * 0.03),
          tabs: [
            GButton(
              icon: Icons.home,
              iconSize: screenWidth * 0.09,
              text: 'Home',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
              },

            ),
            GButton(
              icon: Icons.flight_takeoff_outlined,
              iconSize: screenWidth * 0.09,
              text: 'Flight',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FlightBookingPage()));
              },
            ),
            GButton(
              icon: Icons.car_rental_outlined,
              iconSize: screenWidth * 0.09,
              text: 'Car Rental',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CarRent()));
              },
            ),
            GButton(
              icon: Icons.person_2_outlined,
              iconSize: screenWidth * 0.09,
              text: 'Profile',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
