import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../screens/UserProfileScreen.dart';

class Gnav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03, // Adjusted horizontal padding
          vertical: screenHeight * 0.03, // Adjusted vertical padding
        ),
        color: Colors.indigo.shade200, // Container background color
        child: GNav(
          backgroundColor: Colors.indigo.shade200,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.deepPurpleAccent.shade200,
          curve: Curves.easeOutExpo,
          // duration: Duration(milliseconds: 1000),
          gap: screenWidth * 0.01, // Adjusted gap between tabs
          rippleColor: Colors.grey,
          hoverColor: Colors.purple.shade400,
          haptic: true,
          tabBorderRadius: screenWidth * 0.03, // Adjusted tab border radius
          padding: EdgeInsets.all(screenWidth * 0.03), // Adjusted padding
          tabs: [
            GButton(
              icon: Icons.home,
              iconSize: screenWidth * 0.06, // Adjusted icon size
              text: 'Home',
              // onPressed: ,
            ),
            GButton(
              icon: Icons.favorite_outline,
              iconSize: screenWidth * 0.06, // Adjusted icon size
              text: 'Favorite',
            ),
            GButton(
              icon: Icons.location_city_outlined,
              iconSize: screenWidth * 0.06, // Adjusted icon size
              text: 'Place',
            ),
            GButton(
              icon: Icons.person_2_outlined,
              iconSize: screenWidth * 0.06, // Adjusted icon size
              text: 'Profile',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
