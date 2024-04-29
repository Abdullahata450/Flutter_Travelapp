import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isDark = false;
  User? _user; // Firebase User object

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() {
                isDark = !isDark;
              });
            },
          ),
        ],
      ),
      body: _user != null
          ? StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('User data not found'));
                }
                // Extract user data
                var userData =
                    snapshot.data!.docs.first.data() as Map<String, dynamic>;
                String name = userData['Name'] ?? '';
                String email = userData['Email'] ?? '';
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: $name'),
                        Text('Email: $email'),
                        // Add more widgets to display other user data if needed
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
