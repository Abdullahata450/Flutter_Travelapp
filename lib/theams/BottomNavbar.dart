import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Gnav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        color: Colors.indigo.shade200, // Container background color
        child: GNav(
          backgroundColor: Colors.indigo.shade200,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.deepPurpleAccent.shade200,
          curve: Curves.easeOutExpo,
          // duration: Duration(milliseconds: 1000),
          gap: 8,
          rippleColor: Colors.grey,
          hoverColor: Colors.purple.shade400,
          haptic: true,
          tabBorderRadius: 15,
          padding: EdgeInsets.all(16),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
              // onPressed: ,
            ),
            GButton(
              icon: Icons.favorite_outline,

              text: 'Favorite',
            ),
            GButton(
              icon: Icons.location_city_outlined,
              text: 'Place',
            ),
            GButton(
              icon: Icons.person_2_outlined,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
