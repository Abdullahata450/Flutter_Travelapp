import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'loginScreen.dart'; // Import Firebase Authentication

class SignupScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signup(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      // Signup successful, navigate to next screen or do something else
    } catch (e) {
      // Handle signup errors
      print('Signup failed: $e');
      // Display error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.grey,
                fontSize: 40,
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter Name",
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter Email",
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter Password",
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _signup(context), // Call signup function
              child: Text('Sign Up'),
            ),
            SizedBox(height: 30),
            Text("Sign up with"),
            SizedBox(height: 19,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Your social login buttons
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account ?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                // GestureDetector(
                //   onTap: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                //   },
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
