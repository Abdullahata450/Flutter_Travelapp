import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'loginScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg6.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.7),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08, // Adjusted horizontal padding
              vertical: screenHeight * 0.1, // Adjusted vertical padding
            ),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Enjoy",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.07, // Adjusted font size
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01), // Adjusted spacing
                      Text(
                        "The Beauty Of Pakistan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.07, // Adjusted font size
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02), // Adjusted spacing
                      Text(
                        "In the heart of Pakistan, where the mountains kiss the sky and the rivers dance with joy, lies a land of breathtaking beauty \n From the majestic peaks of the Himalayas to the serene valleys of Kashmir, Pakistan is a canvas painted with nature's finest hues ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.035, // Adjusted font size
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05), // Adjusted spacing
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Homepage()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(screenWidth * 0.04), // Adjusted padding
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(screenWidth * 0.04), // Adjusted border radius
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: screenWidth * 0.06, // Adjusted icon size
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
