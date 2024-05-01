import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mad_project1/screens/singupScreen.dart';

import 'ForgetPassword.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late User _currentUser;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _userDataStream;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),

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
                  // Wrap with Center widget
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.indigo.shade50,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/userprofile.png"),
                              radius: 50,
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignupScreen()),
                                );
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 70),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )
                              ),


                              child: Text("SING UP")),
                          SizedBox(height: 5,),
                          ListTile(
                            leading: Icon(Icons.person,size: 30,),
                            title: Text("$name"),
                            subtitle: Text("Full name",style: TextStyle(color: Colors.grey),),
                          ),
                          ListTile(
                            leading: Icon(Icons.mail,size: 30,),
                            title: Text("$email"),
                            subtitle: Text("Email",style: TextStyle(color: Colors.grey),),
                          ),
                          ListTile(
                            leading: Icon(Icons.password,size: 30,),
                            title: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PasswordResetPage()),
                                );
                              },
                              child: Text("Change Password"),
                            ),
                            subtitle: Text("Change Password ?",style: TextStyle(color: Colors.grey),),
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
