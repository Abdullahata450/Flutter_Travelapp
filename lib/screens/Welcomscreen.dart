import 'package:flutter/material.dart';
import 'package:mad_project1/screens/singupScreen.dart';

import '../theams/custom_theam.dart';
import 'loginScreen.dart';


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CutomsScreen(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Explore Your Journey With us!\n",
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: "\n Enter Your Details Click Below",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              color: Colors.transparent, // Adjust color as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade400, // Button color
                      foregroundColor: Colors.black,
                      textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), // Button text style
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Button border radius
                      ),
                    ),
                    child: Text('Signup'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

