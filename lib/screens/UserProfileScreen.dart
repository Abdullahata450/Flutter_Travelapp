import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'ForgetPassword.dart';
import 'singupScreen.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late User _currentUser;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _userDataStream;
  File? _image;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _loadImage();
  }

  Future<void> _getCurrentUser() async {
    _currentUser = FirebaseAuth.instance.currentUser!;
    setState(() {
      _userDataStream = FirebaseFirestore.instance
          .collection('users')
          .where('Email', isEqualTo: _currentUser.email)
          .snapshots();
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _saveImage(pickedFile.path);
      }
    });
  }

  Future<void> _saveImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', path);
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image');
    setState(() {
      if (imagePath != null) {
        _image = File(imagePath);
      }
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _signOut,
          )
        ],
      ),
      body: _currentUser != null
          ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _userDataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('User data not found'));
          }

          final userData = snapshot.data!.docs.first.data();
          final name = userData['Name'] ?? 'Name';
          final email = userData['Email'] ?? 'Email';

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.indigo.shade50,
                        child: CircleAvatar(
                          backgroundImage: _image != null
                              ? FileImage(_image!)
                              : AssetImage("assets/images/userprofile.png") as ImageProvider,
                          radius: 50,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "$name",
                      style: TextStyle(fontSize: 28, color: Colors.blue),
                    ),
                    Text(
                      "$email",
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    SizedBox(height: 5,),
                    ElevatedButton(
                        onPressed: _signOut,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 70),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),
                        child: Text("SIGN OUT")
                    ),
                    SizedBox(height: 5,),
                    ListTile(
                      leading: Icon(Icons.person, size: 30,),
                      title: Text("$name"),
                      subtitle: Text("Full name", style: TextStyle(color: Colors.grey),),
                    ),
                    ListTile(
                      leading: Icon(Icons.mail, size: 30,),
                      title: Text("$email"),
                      subtitle: Text("Email", style: TextStyle(color: Colors.grey),),
                    ),
                    ListTile(
                      leading: Icon(Icons.password, size: 30,),
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PasswordResetPage()),
                          );
                        },
                        child: Text("Change Password"),
                      ),
                      subtitle: Text("Change Password ?", style: TextStyle(color: Colors.grey),),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'User Profile',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: UserProfile(),
  ));
}
